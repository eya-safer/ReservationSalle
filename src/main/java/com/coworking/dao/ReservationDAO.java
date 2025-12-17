package com.coworking.dao;

import com.coworking.model.Reservation;
import com.coworking.utils.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReservationDAO {

    private Reservation extractReservationFromResultSet(ResultSet rs) throws SQLException {
        Reservation reservation = new Reservation();
        reservation.setId(rs.getLong("id"));
        reservation.setUserId(rs.getLong("user_id"));
        reservation.setRoomId(rs.getLong("room_id"));

        Timestamp startTs = rs.getTimestamp("start_datetime");
        Timestamp endTs = rs.getTimestamp("end_datetime");

        reservation.setStartDatetime(startTs != null ? startTs.toLocalDateTime() : null);
        reservation.setEndDatetime(endTs);

        reservation.setStatus(rs.getString("status"));
        reservation.setNotes(rs.getString("notes"));

        try {
            reservation.setUserName(rs.getString("user_name"));
        } catch (SQLException ignored) {
        }
        try {
            reservation.setRoomName(rs.getString("room_name"));
        } catch (SQLException ignored) {
        }

        return reservation;
    }

    public long create(Reservation reservation) {
        String sql = "INSERT INTO reservations (user_id, room_id, start_datetime, end_datetime, status, notes) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setLong(1, reservation.getUserId());
            stmt.setLong(2, reservation.getRoomId());
            stmt.setTimestamp(3, reservation.getStartDatetimeAsTimestamp());
            stmt.setTimestamp(4, reservation.getEndDatetime());
            stmt.setString(5, reservation.getStatus());
            stmt.setString(6, reservation.getNotes());

            int rows = stmt.executeUpdate();
            if (rows > 0) {
                try (ResultSet keys = stmt.getGeneratedKeys()) {
                    if (keys.next()) {
                        long id = keys.getLong(1);
                        reservation.setId(id);
                        return id;
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    public boolean update(Reservation reservation) {
        String sql = "UPDATE reservations SET user_id = ?, room_id = ?, start_datetime = ?, end_datetime = ?, status = ?, notes = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setLong(1, reservation.getUserId());
            stmt.setLong(2, reservation.getRoomId());
            stmt.setTimestamp(3, reservation.getStartDatetimeAsTimestamp());
            stmt.setTimestamp(4, reservation.getEndDatetime());
            stmt.setString(5, reservation.getStatus());
            stmt.setString(6, reservation.getNotes());
            stmt.setLong(7, reservation.getId());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateStatus(long id, String status) {
        String sql = "UPDATE reservations SET status = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, status);
            stmt.setLong(2, id);

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean delete(long id) {
        String sql = "DELETE FROM reservations WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setLong(1, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public Reservation findById(long id) {
        String sql = "SELECT * FROM reservations WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setLong(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next())
                    return extractReservationFromResultSet(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Reservation> findAll() {
        List<Reservation> list = new ArrayList<>();
        String sql = "SELECT * FROM reservations";
        try (Connection conn = DBConnection.getConnection();
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next())
                list.add(extractReservationFromResultSet(rs));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Reservation> findByUserId(long userId) {
        List<Reservation> list = new ArrayList<>();
        String sql = "SELECT * FROM reservations WHERE user_id = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setLong(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next())
                    list.add(extractReservationFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Reservation> findByRoomId(long roomId) {
        List<Reservation> list = new ArrayList<>();
        String sql = "SELECT * FROM reservations WHERE room_id = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setLong(1, roomId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next())
                    list.add(extractReservationFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Reservation> findByStatus(String status) {
        List<Reservation> list = new ArrayList<>();
        String sql = "SELECT * FROM reservations WHERE status = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, status);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next())
                    list.add(extractReservationFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean hasConflict(long roomId, Timestamp start, Timestamp end, Long excludeId) {
        String sql = "SELECT COUNT(*) FROM reservations WHERE room_id = ? AND status IN ('CONFIRMED','PENDING') AND start_datetime < ? AND end_datetime > ?";
        if (excludeId != null)
            sql += " AND id != ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setLong(1, roomId);
            stmt.setTimestamp(2, end);
            stmt.setTimestamp(3, start);
            if (excludeId != null)
                stmt.setLong(4, excludeId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next())
                    return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public long count() {
        String sql = "SELECT COUNT(*) FROM reservations";
        try (Connection conn = DBConnection.getConnection();
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(sql)) {

            if (rs.next())
                return rs.getLong(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
}
