package com.coworking.dao;

import com.coworking.model.Room;
import com.coworking.util.DatabaseUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RoomDAO {

    public long create(Room room) {
        String sql = "INSERT INTO rooms (name, capacity, description, image_url, price_per_hour, status) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = DatabaseUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setString(1, room.getName());
            stmt.setInt(2, room.getCapacity());
            stmt.setString(3, room.getDescription());
            stmt.setString(4, room.getImageUrl());
            stmt.setBigDecimal(5, room.getPricePerHour());
            stmt.setString(6, room.getStatus());

            int rowsAffected = stmt.executeUpdate();

            if (rowsAffected > 0) {
                try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        long id = generatedKeys.getLong(1);
                        room.setId(id);
                        return id;
                    }
                }
            }
        } catch (SQLException e) {
            System.err.println(" Erreur lors de la création de la salle: " + e.getMessage());
            e.printStackTrace();
        }
        return -1;
    }

    public boolean update(Room room) {
        String sql = "UPDATE rooms SET name = ?, capacity = ?, description = ?, image_url = ?, price_per_hour = ?, status = ? WHERE id = ?";

        try (Connection conn = DatabaseUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, room.getName());
            stmt.setInt(2, room.getCapacity());
            stmt.setString(3, room.getDescription());
            stmt.setString(4, room.getImageUrl());
            stmt.setBigDecimal(5, room.getPricePerHour());
            stmt.setString(6, room.getStatus());
            stmt.setLong(7, room.getId());

            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println(" Erreur lors de la mise à jour de la salle: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public boolean delete(long id) {
        String sql = "DELETE FROM rooms WHERE id = ?";

        try (Connection conn = DatabaseUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setLong(1, id);
            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println(" Erreur lors de la suppression de la salle: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public Room findById(long id) {
        String sql = "SELECT * FROM rooms WHERE id = ?";

        try (Connection conn = DatabaseUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setLong(1, id);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return extractRoomFromResultSet(rs);
                }
            }

        } catch (SQLException e) {
            System.err.println(" Erreur lors de la recherche de la salle: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    public List<Room> findAll() {
        List<Room> rooms = new ArrayList<>();
        String sql = "SELECT * FROM rooms ORDER BY name";

        try (Connection conn = DatabaseUtil.getConnection();
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                rooms.add(extractRoomFromResultSet(rs));
            }

        } catch (SQLException e) {
            System.err.println(" Erreur lors de la récupération des salles: " + e.getMessage());
            e.printStackTrace();
        }
        return rooms;
    }

    public List<Room> findAvailable() {
        List<Room> rooms = new ArrayList<>();
        String sql = "SELECT * FROM rooms WHERE status = 'AVAILABLE' ORDER BY name";

        try (Connection conn = DatabaseUtil.getConnection();
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                rooms.add(extractRoomFromResultSet(rs));
            }

        } catch (SQLException e) {
            System.err.println(" Erreur lors de la recherche des salles disponibles: " + e.getMessage());
            e.printStackTrace();
        }
        return rooms;
    }

    public List<Room> findByStatus(String status) {
        List<Room> rooms = new ArrayList<>();
        String sql = "SELECT * FROM rooms WHERE status = ? ORDER BY name";

        try (Connection conn = DatabaseUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, status);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    rooms.add(extractRoomFromResultSet(rs));
                }
            }

        } catch (SQLException e) {
            System.err.println(" Erreur lors de la recherche par statut: " + e.getMessage());
            e.printStackTrace();
        }
        return rooms;
    }

    public List<Room> findByMinCapacity(int minCapacity) {
        List<Room> rooms = new ArrayList<>();
        String sql = "SELECT * FROM rooms WHERE capacity >= ? AND status = 'AVAILABLE' ORDER BY capacity";

        try (Connection conn = DatabaseUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, minCapacity);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    rooms.add(extractRoomFromResultSet(rs));
                }
            }

        } catch (SQLException e) {
            System.err.println(" Erreur lors de la recherche par capacité: " + e.getMessage());
            e.printStackTrace();
        }
        return rooms;
    }

    public long count() {
        String sql = "SELECT COUNT(*) FROM rooms";

        try (Connection conn = DatabaseUtil.getConnection();
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(sql)) {

            if (rs.next()) {
                return rs.getLong(1);
            }

        } catch (SQLException e) {
            System.err.println(" Erreur lors du comptage: " + e.getMessage());
            e.printStackTrace();
        }
        return 0;
    }

    private Room extractRoomFromResultSet(ResultSet rs) throws SQLException {
        Room room = new Room();
        room.setId(rs.getLong("id"));
        room.setName(rs.getString("name"));
        room.setCapacity(rs.getInt("capacity"));
        room.setDescription(rs.getString("description"));
        room.setImageUrl(rs.getString("image_url"));
        room.setPricePerHour(rs.getBigDecimal("price_per_hour"));
        room.setStatus(rs.getString("status"));
        return room;
    }
}
