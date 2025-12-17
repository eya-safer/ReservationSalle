package com.coworking.servlet;

import com.coworking.model.Room;
import com.coworking.service.RoomService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

@WebServlet(name = "RoomServlet", urlPatterns = { "/rooms/*" })
public class RoomServlet extends HttpServlet {

    private RoomService roomService;

    @Override
    public void init() throws ServletException {
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
                listRooms(request, response);
                break;
            case "view":
                viewRoom(request, response);
                break;
            case "add":
                showAddForm(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "delete":
                deleteRoom(request, response);
                break;
            default:
                listRooms(request, response);
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
            case "add":
                addRoom(request, response);
                break;
            case "edit":
                updateRoom(request, response);
                break;
            default:
                listRooms(request, response);
                break;
        }
    }

    private void listRooms(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<Room> rooms = roomService.getAllRooms();
            request.setAttribute("rooms", rooms);
            request.getRequestDispatcher("/WEB-INF/views/rooms/list.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Erreur lors de la récupération des salles: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
        }
    }

    private void viewRoom(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Long roomId = Long.parseLong(request.getParameter("id"));
            Room room = roomService.getRoomById(roomId);

            if (room != null) {
                request.setAttribute("room", room);
                request.getRequestDispatcher("/WEB-INF/views/rooms/view.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Salle non trouvée");
                listRooms(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("error", "Erreur: " + e.getMessage());
            listRooms(request, response);
        }
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!isAdmin(request)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Accès refusé");
            return;
        }
        request.getRequestDispatcher("/WEB-INF/views/rooms/add.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!isAdmin(request)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Accès refusé");
            return;
        }

        try {
            Long roomId = Long.parseLong(request.getParameter("id"));
            Room room = roomService.getRoomById(roomId);

            if (room != null) {
                request.setAttribute("room", room);
                request.getRequestDispatcher("/WEB-INF/views/rooms/edit.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Salle non trouvée");
                listRooms(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("error", "Erreur: " + e.getMessage());
            listRooms(request, response);
        }
    }

    private void addRoom(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!isAdmin(request)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Accès refusé");
            return;
        }

        try {
            Room room = new Room();
            room.setName(request.getParameter("name"));
            room.setCapacity(Integer.parseInt(request.getParameter("capacity")));
            room.setDescription(request.getParameter("description"));
            room.setImageUrl(request.getParameter("imageUrl"));

            String priceStr = request.getParameter("pricePerHour");
            if (priceStr != null && !priceStr.isEmpty()) {
                room.setPricePerHour(new BigDecimal(priceStr));
            }

            String status = request.getParameter("status");
            room.setStatus(status != null ? status : "AVAILABLE");

            roomService.createRoom(room);
            response.sendRedirect(request.getContextPath() + "/rooms/list");
        } catch (Exception e) {
            request.setAttribute("error", "Erreur lors de la création de la salle: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/rooms/add.jsp").forward(request, response);
        }
    }

    private void updateRoom(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!isAdmin(request)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Accès refusé");
            return;
        }

        try {
            Long roomId = Long.parseLong(request.getParameter("id"));
            Room room = roomService.getRoomById(roomId);

            if (room != null) {
                room.setName(request.getParameter("name"));
                room.setCapacity(Integer.parseInt(request.getParameter("capacity")));
                room.setDescription(request.getParameter("description"));
                room.setImageUrl(request.getParameter("imageUrl"));

                String priceStr = request.getParameter("pricePerHour");
                if (priceStr != null && !priceStr.isEmpty()) {
                    room.setPricePerHour(new BigDecimal(priceStr));
                }

                String status = request.getParameter("status");
                room.setStatus(status != null ? status : "AVAILABLE");

                roomService.updateRoom(room);
                response.sendRedirect(request.getContextPath() + "/rooms/list");
            } else {
                request.setAttribute("error", "Salle non trouvée");
                listRooms(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("error", "Erreur lors de la modification: " + e.getMessage());
            showEditForm(request, response);
        }
    }

    private void deleteRoom(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        if (!isAdmin(request)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Accès refusé");
            return;
        }

        try {
            Long roomId = Long.parseLong(request.getParameter("id"));
            roomService.deleteRoom(roomId);
            response.sendRedirect(request.getContextPath() + "/rooms/list");
        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/rooms/list?error=" + e.getMessage());
        }
    }

    private boolean isAuthenticated(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        return session != null && session.getAttribute("user") != null;
    }

    private boolean isAdmin(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            String role = (String) session.getAttribute("userRole");
            return "ADMIN".equals(role);
        }
        return false;
    }

    private String getAction(HttpServletRequest request) {
        String pathInfo = request.getPathInfo();
        if (pathInfo == null || pathInfo.equals("/")) {
            return "list";
        }
        return pathInfo.substring(1);
    }

    @Override
    public void destroy() {
    }
}
