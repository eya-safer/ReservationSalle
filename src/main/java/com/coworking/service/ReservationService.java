package com.coworking.service;

import com.coworking.dao.ReservationDAO;
import com.coworking.model.Reservation;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;

public class ReservationService {

    private final ReservationDAO reservationDAO;

    public ReservationService() {
        this.reservationDAO = new ReservationDAO();
    }

    public Reservation createReservation(Reservation reservation) {
        if (!reservation.getEndDatetime().after(reservation.getStartDatetimeAsTimestamp()))
            return null;
        if (reservationDAO.hasConflict(reservation.getRoomId(), reservation.getStartDatetimeAsTimestamp(),
                reservation.getEndDatetime(), null))
            return null;

        long id = reservationDAO.create(reservation);
        if (id > 0) {
            reservation.setId(id);
            return reservation;
        }
        return null;
    }

    public boolean updateReservation(Reservation reservation) {
        if (!reservation.getEndDatetime().after(reservation.getStartDatetimeAsTimestamp()))
            return false;
        if (reservationDAO.hasConflict(reservation.getRoomId(), reservation.getStartDatetimeAsTimestamp(),
                reservation.getEndDatetime(), reservation.getId()))
            return false;
        return reservationDAO.update(reservation);
    }

    public boolean cancelReservation(long reservationId) {
        return reservationDAO.updateStatus(reservationId, "CANCELLED");
    }

    public boolean deleteReservation(long id) {
        return reservationDAO.delete(id);
    }

    public Reservation getReservationById(long id) {
        return reservationDAO.findById(id);
    }

    public List<Reservation> getAllReservations() {
        return reservationDAO.findAll();
    }

    public List<Reservation> getUserReservations(long userId) {
        return reservationDAO.findByUserId(userId);
    }

    public List<Reservation> getRoomReservations(long roomId) {
        return reservationDAO.findByRoomId(roomId);
    }

    public List<Reservation> getReservationsByStatus(String status) {
        return reservationDAO.findByStatus(status);
    }

    public boolean isRoomAvailable(long roomId, LocalDateTime start, LocalDateTime end) {
        return !reservationDAO.hasConflict(roomId, Timestamp.valueOf(start), Timestamp.valueOf(end), null);
    }

    public long countReservations() {
        return reservationDAO.count();
    }
}
