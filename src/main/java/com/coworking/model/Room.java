package com.coworking.model;

import java.math.BigDecimal;

public class Room {

    private Long id;
    private String name;
    private Integer capacity;
    private String description;
    private String imageUrl;
    private BigDecimal pricePerHour;
    private String status;

    public Room() {
    }

    public Room(String name, Integer capacity, String description) {
        this.name = name;
        this.capacity = capacity;
        this.description = description;
        this.status = "AVAILABLE";
        this.imageUrl = "images/default-room.jpg";
        this.pricePerHour = BigDecimal.ZERO;
    }

    public Room(Long id, String name, Integer capacity, String description,
            String imageUrl, BigDecimal pricePerHour, String status) {
        this.id = id;
        this.name = name;
        this.capacity = capacity;
        this.description = description;
        this.imageUrl = imageUrl;
        this.pricePerHour = pricePerHour;
        this.status = status;
    }

    public boolean isAvailable() {
        return "AVAILABLE".equals(this.status);
    }

    public Long getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public Integer getCapacity() {
        return capacity;
    }

    public String getDescription() {
        return description;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public BigDecimal getPricePerHour() {
        return pricePerHour;
    }

    public String getStatus() {
        return status;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setCapacity(Integer capacity) {
        this.capacity = capacity;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public void setPricePerHour(BigDecimal pricePerHour) {
        this.pricePerHour = pricePerHour;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "Room{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", capacity=" + capacity +
                ", status='" + status + '\'' +
                '}';
    }
}
