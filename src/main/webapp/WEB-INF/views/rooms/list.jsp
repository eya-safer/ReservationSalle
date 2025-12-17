<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="com.coworking.model.Room, java.util.List" %>
        <!DOCTYPE html>
        <html lang="fr">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Available Rooms - SPACE</title>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

            <style>
                .main-header {
                    background-color: var(--surface-color);
                    box-shadow: var(--shadow);
                    position: sticky;
                    top: 0;
                    z-index: 1000;
                    border-bottom: 2px solid var(--primary-color);
                }

                .header-wrapper {
                    max-width: 1200px;
                    margin: 0 auto;
                    padding: 1rem 2rem;
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                }

                .logo-container {
                    display: flex;
                    align-items: center;
                    gap: 1rem;
                }

                .logo-img {
                    height: 45px;
                    width: auto;
                }

                .logo-text {
                    font-size: 1.5rem;
                    font-weight: 700;
                    color: var(--primary-color);
                    letter-spacing: 0.1em;
                }

                .header-nav {
                    display: flex;
                    gap: 1.5rem;
                    align-items: center;
                }

                .header-nav a {
                    color: var(--text-secondary);
                    text-decoration: none;
                    font-weight: 500;
                    transition: color 0.2s;
                }

                .header-nav a:hover {
                    color: var(--primary-color);
                }

                .user-info {
                    display: flex;
                    align-items: center;
                    gap: 1rem;
                    color: var(--text-secondary);
                }

                .page-header {
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                    margin-bottom: 2rem;
                }

                .page-title {
                    color: var(--text-primary);
                    font-size: 2rem;
                }

                .grid-container {
                    display: grid;
                    grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
                    gap: 2rem;
                    margin-top: 2rem;
                }

                .card {
                    background-color: var(--surface-color);
                    border-radius: var(--radius);
                    box-shadow: var(--shadow);
                    border: 1px solid var(--border-color);
                    overflow: hidden;
                    transition: transform 0.2s, box-shadow 0.2s;
                    display: flex;
                    flex-direction: column;
                }

                .card:hover {
                    transform: translateY(-3px);
                    box-shadow: var(--shadow-lg);
                }

                .room-image {
                    width: 100%;
                    height: 200px;
                    object-fit: cover;
                }

                .room-content {
                    padding: 1.5rem;
                    display: flex;
                    flex-direction: column;
                    flex: 1;
                }

                .room-content h3 {
                    margin-bottom: 0.5rem;
                    color: var(--text-primary);
                }

                .room-details {
                    display: flex;
                    gap: 1rem;
                    margin-bottom: 1rem;
                    color: var(--text-secondary);
                    font-size: 0.9rem;
                }

                .room-actions {
                    display: flex;
                    gap: 0.5rem;
                    margin-top: auto;
                }

                .room-actions .btn {
                    flex: 1;
                }

                .no-rooms {
                    text-align: center;
                    padding: 4rem;
                    color: var(--text-secondary);
                }

                .no-rooms i {
                    font-size: 3rem;
                    margin-bottom: 1rem;
                    opacity: 0.5;
                }

                @media (max-width: 768px) {
                    .header-wrapper {
                        flex-direction: column;
                        gap: 1rem;
                    }
                }
            </style>
        </head>

        <body>
            <header class="main-header">
                <div class="header-wrapper">
                    <div class="logo-container">
                        <img src="${pageContext.request.contextPath}/images/logo.png" alt="SPACE Logo" class="logo-img">
                        <span class="logo-text">SPACE</span>
                    </div>
                    <nav class="header-nav">
                        <a href="${pageContext.request.contextPath}/rooms/list">Rooms</a>
                        <a href="${pageContext.request.contextPath}/reservations/myreservations">My Reservations</a>
                        <% if ("ADMIN".equals(session.getAttribute("userRole"))) { %>
                            <a href="${pageContext.request.contextPath}/reservations/list">All Reservations</a>
                            <% } %>
                                <div class="user-info">
                                    <span><i class="fa-solid fa-user-circle"></i>
                                        <%= session.getAttribute("username") %>
                                    </span>
                                    <a href="${pageContext.request.contextPath}/auth/logout" class="btn btn-secondary"
                                        style="padding: 0.25rem 0.75rem; font-size: 0.875rem;">
                                        <i class="fa-solid fa-sign-out-alt"></i>
                                    </a>
                                </div>
                    </nav>
                </div>
            </header>

            <div class="container" style="padding-top: 2rem; padding-bottom: 4rem;">
                <div class="page-header">
                    <h1 class="page-title">Available Rooms</h1>
                    <% if ("ADMIN".equals(session.getAttribute("userRole"))) { %>
                        <a href="${pageContext.request.contextPath}/rooms/add" class="btn btn-primary">
                            <i class="fa-solid fa-plus"></i> Add Room
                        </a>
                        <% } %>
                </div>

                <% List<Room> rooms = (List<Room>) request.getAttribute("rooms");
                        if (rooms != null && !rooms.isEmpty()) {
                        int index = 0;
                        String[] defaultImages = {"room-1.png", "room-2.png", "room-3.png"};
                        %>
                        <div class="grid-container">
                            <% for (Room room : rooms) { String imgPath=room.getImageUrl(); if (imgPath==null ||
                                imgPath.isEmpty() || imgPath.contains("default")) { imgPath="images/" +
                                defaultImages[index % defaultImages.length]; } else if (!imgPath.startsWith("images/")
                                && !imgPath.startsWith("http")) { imgPath="images/" + imgPath; } index++; %>
                                <div class="card">
                                    <img src="${pageContext.request.contextPath}/<%= imgPath %>"
                                        alt="<%= room.getName() %>" class="room-image"
                                        onerror="this.src='${pageContext.request.contextPath}/images/room-1.png'">
                                    <div class="room-content">
                                        <h3>
                                            <%= room.getName() %>
                                        </h3>
                                        <div class="room-details">
                                            <span><i class="fa-solid fa-users"></i>
                                                <%= room.getCapacity() %> pers.
                                            </span>
                                            <span><i class="fa-solid fa-tag"></i>
                                                <%= room.getPricePerHour() %>€ /h
                                            </span>
                                        </div>
                                        <span class="badge badge-<%= " AVAILABLE".equals(room.getStatus()) ? "available"
                                            : "maintenance" %>">
                                            <%= "AVAILABLE" .equals(room.getStatus()) ? "Available" : "Maintenance" %>
                                        </span>
                                        <div class="room-actions">
                                            <a href="${pageContext.request.contextPath}/rooms/view?id=<%= room.getId() %>"
                                                class="btn btn-secondary">
                                                Details
                                            </a>
                                            <% if ("AVAILABLE".equals(room.getStatus())) { %>
                                                <a href="${pageContext.request.contextPath}/reservations/create?roomId=<%= room.getId() %>"
                                                    class="btn btn-primary">
                                                    Book
                                                </a>
                                                <% } %>
                                        </div>
                                    </div>
                                </div>
                                <% } %>
                        </div>
                        <% } else { %>
                            <div class="no-rooms">
                                <i class="fa-regular fa-folder-open"></i>
                                <h2>No Rooms Available</h2>
                                <p>Check back later for available rooms.</p>
                            </div>
                            <% } %>
            </div>
        </body>

        </html>