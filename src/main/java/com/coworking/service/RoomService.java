package com.coworking.service;

import com.coworking.dao.RoomDAO;
import com.coworking.model.Room;

import java.util.List;

public class RoomService {

    private final RoomDAO roomDAO;

    public RoomService() {
        this.roomDAO = new RoomDAO();
    }

    public Room createRoom(Room room) {
        long id = roomDAO.create(room);
        if (id > 0) {
            return room;
        }
        return null;
    }

    public boolean updateRoom(Room room) {
        return roomDAO.update(room);
    }

    public boolean deleteRoom(long id) {
        return roomDAO.delete(id);
    }

    public Room getRoomById(long id) {
        return roomDAO.findById(id);
    }

    public List<Room> getAllRooms() {
        return roomDAO.findAll();
    }

    public List<Room> getAvailableRooms() {
        return roomDAO.findAvailable();
    }

    public List<Room> getRoomsByStatus(String status) {
        return roomDAO.findByStatus(status);
    }

    public List<Room> getRoomsByMinCapacity(int minCapacity) {
        return roomDAO.findByMinCapacity(minCapacity);
    }

    public long countRooms() {
        return roomDAO.count();
    }
}
