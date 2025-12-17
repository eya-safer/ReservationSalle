package com.coworking.model;

import java.sql.Timestamp;
import java.time.LocalDateTime;

public class Reservation {

    private Long id;
    private Long userId;
    private Long roomId;

    private LocalDateTime startDatetime;
    private Timestamp endDatetime;

    private String status;
    private String notes;
    private String userName;
    private String roomName;

    public Reservation() {
    }

    public Reservation(Long userId, Long roomId, Timestamp startDatetime, Timestamp endDatetime) {
        this.userId = userId;
        this.roomId = roomId;
        this.startDatetime = startDatetime != null ? startDatetime.toLocalDateTime() : null;
        this.endDatetime = endDatetime;
        this.status = "CONFIRMED";
    }

    public Reservation(Long id, Long userId, Long roomId, Timestamp startDatetime,
            Timestamp endDatetime, String status, String notes) {
        this.id = id;
        this.userId = userId;
        this.roomId = roomId;
        this.startDatetime = startDatetime != null ? startDatetime.toLocalDateTime() : null;
        this.endDatetime = endDatetime;
        this.status = status;
        this.notes = notes;
    }

    public Timestamp getStartDatetimeAsTimestamp() {
        return startDatetime != null ? Timestamp.valueOf(startDatetime) : null;
    }

    public boolean isPast() {
        return endDatetime != null && endDatetime.before(new Timestamp(System.currentTimeMillis()));
    }

    public boolean canBeCancelled() {
        return ("CONFIRMED".equals(status) || "PENDING".equals(status)) && !isPast();
    }

    public long getDurationHours() {
        if (startDatetime != null && endDatetime != null) {
            long diff = endDatetime.getTime() - Timestamp.valueOf(startDatetime).getTime();
            return diff / (1000 * 60 * 60);
        }
        return 0;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public Long getRoomId() {
        return roomId;
    }

    public void setRoomId(Long roomId) {
        this.roomId = roomId;
    }

    public LocalDateTime getStartDatetime() {
        return startDatetime;
    }

    public void setStartDatetime(LocalDateTime startDatetime) {
        this.startDatetime = startDatetime;
    }

    public Timestamp getEndDatetime() {
        return endDatetime;
    }

    public void setEndDatetime(Timestamp endDatetime) {
        this.endDatetime = endDatetime;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getRoomName() {
        return roomName;
    }

    public void setRoomName(String roomName) {
        this.roomName = roomName;
    }

    @Override
    public String toString() {
        return "Reservation{" +
                "id=" + id +
                ", userId=" + userId +
                ", roomId=" + roomId +
                ", startDatetime=" + startDatetime +
                ", endDatetime=" + endDatetime +
                ", status='" + status + '\'' +
                '}';
    }
}
