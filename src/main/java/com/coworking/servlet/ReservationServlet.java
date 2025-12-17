package com.coworking.servlet;

import com.coworking.model.Reservation;
import com.coworking.model.Room;
import com.coworking.service.ReservationService;
import com.coworking.service.RoomService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.stream.Collectors;
import java.util.Arrays;

@WebServlet(name = "ReservationServlet", urlPatterns = { "/reservations/*" })
public class ReservationServlet extends HttpServlet {

    private ReservationService reservationService;
    private RoomService roomService;
    private static final DateTimeFormatter DATETIME_FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");

    @Override
    public void init() throws ServletException {
        reservationService = new ReservationService();
        roomService = new RoomService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (!isAuthenticated(request)) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }

        String action = getAction(request);

        switch (action) {
            case "list":
                listReservations(request, response);
                break;
            case "myreservations":
                listMyReservations(request, response);
                break;
            case "view":
                viewReservation(request, response);
                break;
            case "create":
                showCreateForm(request, response);
                break;
            case "cancel":
                cancelReservation(request, response);
                break;
            case "check-availability":
                checkAvailability(request, response);
                break;
            default:
                listMyReservations(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (!isAuthenticated(request)) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }

        String action = getAction(request);

        switch (action) {
            case "create":
                createReservation(request, response);
                break;
            case "update-status":
                updateReservationStatus(request, response);
                break;
            default:
                listMyReservations(request, response);
                break;
        }
    }

    private void listReservations(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!isAdmin(request)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Accès refusé");
            return;
        }
        List<Reservation> reservations = reservationService.getAllReservations();
        List<Reservation> activeReservations = reservations.stream()
                .filter(r -> !"CANCELLED".equals(r.getStatus()))
                .collect(Collectors.toList());
        request.setAttribute("reservations", activeReservations);
        request.getRequestDispatcher("/WEB-INF/views/reservations/list.jsp").forward(request, response);
    }

    private void listMyReservations(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Long userId = getUserId(request);
        List<Reservation> reservations = reservationService.getUserReservations(userId);
        List<Reservation> activeReservations = reservations.stream()
                .filter(r -> !"CANCELLED".equals(r.getStatus()))
                .collect(Collectors.toList());
        request.setAttribute("reservations", activeReservations);
        request.getRequestDispatcher("/WEB-INF/views/reservations/myreservations.jsp").forward(request, response);
    }

    private void viewReservation(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Long reservationId = Long.parseLong(request.getParameter("id"));
            Reservation reservation = reservationService.getReservationById(reservationId);
            if (reservation != null) {
                Long userId = getUserId(request);
                if (!isAdmin(request) && !reservation.getUserId().equals(userId)) {
                    response.sendError(HttpServletResponse.SC_FORBIDDEN, "Accès refusé");
                    return;
                }
                request.setAttribute("reservation", reservation);
                request.getRequestDispatcher("/WEB-INF/views/reservations/view.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/reservations/myreservations?error=notfound");
            }
        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/reservations/myreservations?error=" + e.getMessage());
        }
    }

    private void showCreateForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Room> rooms = roomService.getAvailableRooms();
        request.setAttribute("rooms", rooms);

        String roomIdParam = request.getParameter("roomId");
        if (roomIdParam != null && !roomIdParam.isEmpty()) {
            Long roomId = Long.parseLong(roomIdParam);
            Room selectedRoom = roomService.getRoomById(roomId);
            request.setAttribute("selectedRoom", selectedRoom);
        }

        request.getRequestDispatcher("/WEB-INF/views/reservations/create.jsp").forward(request, response);
    }

    private void createReservation(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Long userId = getUserId(request);
            Long roomId = Long.parseLong(request.getParameter("roomId"));
            LocalDateTime startDatetime = LocalDateTime.parse(request.getParameter("startDatetime"),
                    DATETIME_FORMATTER);
            LocalDateTime endDatetime = LocalDateTime.parse(request.getParameter("endDatetime"), DATETIME_FORMATTER);
            String notes = request.getParameter("notes");

            if (!endDatetime.isAfter(startDatetime)) {
                request.setAttribute("error", "La date de fin doit être après la date de début");
                showCreateForm(request, response);
                return;
            }

            if (startDatetime.isBefore(LocalDateTime.now())) {
                request.setAttribute("error", "Vous ne pouvez pas réserver dans le passé");
                showCreateForm(request, response);
                return;
            }

            if (!reservationService.isRoomAvailable(roomId, startDatetime, endDatetime)) {
                request.setAttribute("error", "La salle n'est pas disponible pour cette période");
                showCreateForm(request, response);
                return;
            }

            Reservation reservation = new Reservation();
            reservation.setUserId(userId);
            reservation.setRoomId(roomId);
            reservation.setStartDatetime(startDatetime);
            reservation.setEndDatetime(java.sql.Timestamp.valueOf(endDatetime));
            reservation.setStatus("CONFIRMED");
            reservation.setNotes(notes);

            Reservation created = reservationService.createReservation(reservation);
            if (created != null) {
                response.sendRedirect(request.getContextPath() + "/reservations/myreservations?success=true");
            } else {
                request.setAttribute("error", "Erreur lors de la création de la réservation");
                showCreateForm(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("error", "Erreur: " + e.getMessage());
            showCreateForm(request, response);
        }
    }

    private void cancelReservation(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try {
            Long reservationId = Long.parseLong(request.getParameter("id"));
            reservationService.cancelReservation(reservationId);
            response.sendRedirect(request.getContextPath() + "/reservations/myreservations?cancelled=true");
        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/reservations/myreservations?error=" + e.getMessage());
        }
    }

    private void updateReservationStatus(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        if (!isAdmin(request)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Accès refusé");
            return;
        }

        try {
            Long reservationId = Long.parseLong(request.getParameter("id"));
            String status = request.getParameter("status");

            if (!Arrays.asList("PENDING", "CONFIRMED", "ACCEPTED", "CANCELLED", "COMPLETED").contains(status)) {
                response.sendRedirect(request.getContextPath() + "/reservations/list?error=invalid_status");
                return;
            }

            Reservation reservation = reservationService.getReservationById(reservationId);
            if (reservation != null) {
                reservation.setStatus(status);
                reservationService.updateReservation(reservation);
                response.sendRedirect(request.getContextPath() + "/reservations/list?updated=true");
            } else {
                response.sendRedirect(request.getContextPath() + "/reservations/list?error=not_found");
            }
        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/reservations/list?error=update_failed");
        }
    }

    private void checkAvailability(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        Long roomId = Long.parseLong(request.getParameter("roomId"));
        LocalDateTime startDatetime = LocalDateTime.parse(request.getParameter("startDatetime"), DATETIME_FORMATTER);
        LocalDateTime endDatetime = LocalDateTime.parse(request.getParameter("endDatetime"), DATETIME_FORMATTER);
        boolean available = reservationService.isRoomAvailable(roomId, startDatetime, endDatetime);
        response.setContentType("application/json");
        response.getWriter().write("{\"available\": " + available + "}");
    }

    private boolean isAuthenticated(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        return session != null && session.getAttribute("user") != null;
    }

    private boolean isAdmin(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        return session != null && "ADMIN".equals(session.getAttribute("userRole"));
    }

    private Long getUserId(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        return session != null ? (Long) session.getAttribute("userId") : null;
    }

    private String getAction(HttpServletRequest request) {
        String pathInfo = request.getPathInfo();
        return (pathInfo == null || pathInfo.equals("/")) ? "myreservations" : pathInfo.substring(1);
    }
}
