<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="com.coworking.model.Reservation, java.util.List, java.time.format.DateTimeFormatter" %>
        <!DOCTYPE html>
        <html lang="fr">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>My Reservations - SPACE</title>
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
                    padding: 0.5rem 1rem;
                    border-radius: var(--radius);
                    transition: all 0.2s;
                }

                .header-nav a:hover {
                    color: var(--primary-color);
                    background-color: rgba(255, 215, 0, 0.1);
                }

                .container {
                    max-width: 1200px;
                    margin: 0 auto;
                    padding: 2rem;
                }

                .page-title {
                    color: var(--text-primary);
                    font-size: 2rem;
                    margin-bottom: 2rem;
                }

                .reservations-list {
                    display: flex;
                    flex-direction: column;
                    gap: 1.5rem;
                }

                .reservation-card {
                    background: var(--surface-color);
                    border-radius: var(--radius);
                    padding: 1.5rem;
                    box-shadow: var(--shadow);
                    border: 1px solid var(--border-color);
                    transition: transform 0.2s, box-shadow 0.2s;
                }

                .reservation-card:hover {
                    transform: translateY(-3px);
                    box-shadow: var(--shadow-lg);
                }

                .reservation-header {
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                    margin-bottom: 1rem;
                }

                .room-name {
                    font-size: 1.375rem;
                    font-weight: 600;
                    color: var(--text-primary);
                }

                .status-badge {
                    padding: 0.4rem 1rem;
                    border-radius: 1.25rem;
                    font-size: 0.813rem;
                    font-weight: 600;
                }

                .status-confirmed,
                .status-accepted {
                    background: rgba(16, 185, 129, 0.2);
                    color: #10b981;
                }

                .status-pending {
                    background: rgba(245, 158, 11, 0.2);
                    color: #f59e0b;
                }

                .status-cancelled {
                    background: rgba(239, 68, 68, 0.2);
                    color: #ef4444;
                }

                .status-completed {
                    background: rgba(59, 130, 246, 0.2);
                    color: #3b82f6;
                }

                .reservation-details {
                    display: grid;
                    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                    gap: 1rem;
                    margin: 1.25rem 0;
                }

                .detail-item {
                    display: flex;
                    align-items: center;
                    gap: 0.5rem;
                    color: var(--text-secondary);
                }

                .detail-item i {
                    color: var(--primary-color);
                }

                .detail-item strong {
                    color: var(--text-primary);
                }

                .notes-section {
                    margin-top: 1rem;
                    padding: 1rem;
                    background: var(--background-color);
                    border-radius: var(--radius);
                }

                .notes-section strong {
                    color: var(--text-primary);
                }

                .actions {
                    display: flex;
                    gap: 0.75rem;
                    margin-top: 1rem;
                }

                .empty-state {
                    text-align: center;
                    padding: 4rem 2rem;
                    background: var(--surface-color);
                    border-radius: var(--radius);
                }

                .empty-state i {
                    font-size: 3rem;
                    color: var(--text-secondary);
                    opacity: 0.5;
                    margin-bottom: 1rem;
                }

                .empty-state h2 {
                    color: var(--text-primary);
                    margin-bottom: 0.5rem;
                }

                .empty-state p {
                    color: var(--text-secondary);
                    margin-bottom: 1.5rem;
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
                                <a href="${pageContext.request.contextPath}/auth/logout" class="btn btn-secondary"
                                    style="padding: 0.375rem 0.875rem;">
                                    <i class="fa-solid fa-sign-out-alt"></i>
                                </a>
                    </nav>
                </div>
            </header>

            <div class="container">
                <h1 class="page-title"><i class="fa-regular fa-calendar-days"></i> My Reservations</h1>

                <% List<Reservation> reservations = (List<Reservation>) request.getAttribute("reservations");
                        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");

                        if (reservations != null && !reservations.isEmpty()) {
                        %>
                        <div class="reservations-list">
                            <% for (Reservation reservation : reservations) { %>
                                <div class="reservation-card">
                                    <div class="reservation-header">
                                        <div class="room-name">
                                            <i class="fa-solid fa-door-open"></i> Room #<%= reservation.getRoomId() %>
                                        </div>
                                        <span class="status-badge status-<%= reservation.getStatus().toLowerCase() %>">
                                            <%= reservation.getStatus() %>
                                        </span>
                                    </div>

                                    <div class="reservation-details">
                                        <div class="detail-item">
                                            <i class="fa-regular fa-calendar"></i>
                                            <strong>Start:</strong>
                                            <%= reservation.getStartDatetime().format(formatter) %>
                                        </div>
                                        <div class="detail-item">
                                            <i class="fa-regular fa-calendar-check"></i>
                                            <strong>End:</strong>
                                            <%= reservation.getEndDatetime().toLocalDateTime().format(formatter) %>
                                        </div>
                                        <div class="detail-item">
                                            <i class="fa-solid fa-hashtag"></i>
                                            <strong>ID:</strong> #<%= reservation.getId() %>
                                        </div>
                                        <div class="detail-item">
                                            <i class="fa-regular fa-clock"></i>
                                            <strong>Duration:</strong>
                                            <%= java.time.Duration.between(reservation.getStartDatetime(),
                                                reservation.getEndDatetime().toLocalDateTime()).toHours() %> hours
                                        </div>
                                    </div>

                                    <% if (reservation.getNotes() !=null && !reservation.getNotes().isEmpty()) { %>
                                        <div class="notes-section">
                                            <strong><i class="fa-regular fa-note-sticky"></i> Notes:</strong>
                                            <%= reservation.getNotes() %>
                                        </div>
                                        <% } %>

                                            <div class="actions">
                                                <a href="${pageContext.request.contextPath}/reservations/view?id=<%= reservation.getId() %>"
                                                    class="btn btn-primary">
                                                    <i class="fa-solid fa-eye"></i> Details
                                                </a>
                                                <% if ("CONFIRMED".equals(reservation.getStatus()) || "PENDING"
                                                    .equals(reservation.getStatus())) { %>
                                                    <a href="${pageContext.request.contextPath}/reservations/cancel?id=<%= reservation.getId() %>"
                                                        class="btn btn-danger"
                                                        onclick="return confirm('Are you sure you want to cancel this reservation?');">
                                                        <i class="fa-solid fa-times"></i> Cancel
                                                    </a>
                                                    <% } %>
                                            </div>
                                </div>
                                <% } %>
                        </div>
                        <% } else { %>
                            <div class="empty-state">
                                <i class="fa-regular fa-calendar-xmark"></i>
                                <h2>No Reservations Found</h2>
                                <p>You haven't made any reservations yet.</p>
                                <a href="${pageContext.request.contextPath}/rooms/list" class="btn btn-primary">
                                    <i class="fa-solid fa-magnifying-glass"></i> Browse Available Rooms
                                </a>
                            </div>
                            <% } %>
            </div>
        </body>

        </html>