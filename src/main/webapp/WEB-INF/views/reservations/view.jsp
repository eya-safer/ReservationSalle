<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="com.coworking.model.Reservation" %>
        <!DOCTYPE html>
        <html lang="fr">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Reservation Details - SPACE</title>
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
                    gap: 1rem;
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

                .container {
                    max-width: 900px;
                    margin: 3rem auto;
                    padding: 0 2rem;
                }

                .details-card {
                    background: var(--surface-color);
                    border-radius: var(--radius);
                    padding: 2.5rem;
                    box-shadow: var(--shadow-lg);
                    border: 1px solid var(--border-color);
                }

                .page-title {
                    color: var(--text-primary);
                    font-size: 2rem;
                    margin-bottom: 2rem;
                }

                .status-badge {
                    padding: 0.5rem 1.25rem;
                    border-radius: 1.25rem;
                    font-weight: 600;
                    display: inline-block;
                    margin-bottom: 2rem;
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

                .info-grid {
                    display: grid;
                    grid-template-columns: repeat(2, 1fr);
                    gap: 1.25rem;
                    margin: 2rem 0;
                }

                .info-item {
                    background: var(--background-color);
                    padding: 1.25rem;
                    border-radius: var(--radius);
                    border-left: 4px solid var(--primary-color);
                }

                .info-label {
                    color: var(--text-secondary);
                    font-size: 0.875rem;
                    margin-bottom: 0.5rem;
                }

                .info-label i {
                    color: var(--primary-color);
                }

                .info-value {
                    color: var(--text-primary);
                    font-size: 1.125rem;
                    font-weight: 600;
                }

                .notes-section {
                    background: var(--background-color);
                    padding: 1.25rem;
                    border-radius: var(--radius);
                    margin: 1.25rem 0;
                }

                .notes-section strong {
                    color: var(--text-primary);
                }

                .admin-controls {
                    background: rgba(255, 215, 0, 0.1);
                    border: 1px solid var(--primary-color);
                    border-radius: var(--radius);
                    padding: 1.5rem;
                    margin-bottom: 2rem;
                }

                .admin-controls h3 {
                    color: var(--text-primary);
                    margin-bottom: 1rem;
                    font-size: 1.125rem;
                }

                .admin-controls form {
                    display: flex;
                    gap: 1rem;
                }

                .actions {
                    display: flex;
                    gap: 1rem;
                    margin-top: 2rem;
                }

                .not-found {
                    text-align: center;
                    padding: 3rem;
                }

                .not-found h2 {
                    color: var(--text-primary);
                    margin-bottom: 1rem;
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
                        <a href="${pageContext.request.contextPath}/reservations/myreservations">
                            <i class="fa-solid fa-arrow-left"></i> Back
                        </a>
                        <a href="${pageContext.request.contextPath}/auth/logout" class="btn btn-secondary">
                            <i class="fa-solid fa-sign-out-alt"></i> Logout
                        </a>
                    </nav>
                </div>
            </header>

            <div class="container">
                <% Reservation reservation=(Reservation) request.getAttribute("reservation"); if (reservation !=null) {
                    java.time.format.DateTimeFormatter
                    formatter=java.time.format.DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm"); boolean isAdmin="ADMIN"
                    .equals(session.getAttribute("userRole")); %>
                    <div class="details-card">
                        <h1 class="page-title"><i class="fa-solid fa-file-lines"></i> Reservation Details #<%=
                                reservation.getId() %>
                        </h1>

                        <span class="status-badge status-<%= reservation.getStatus().toLowerCase() %>">
                            <%= reservation.getStatus() %>
                        </span>

                        <% if (isAdmin && !"CANCELLED".equals(reservation.getStatus())) { %>
                            <div class="admin-controls">
                                <h3><i class="fa-solid fa-user-shield"></i> Admin Controls</h3>
                                <form action="${pageContext.request.contextPath}/reservations/update-status"
                                    method="post">
                                    <input type="hidden" name="id" value="<%= reservation.getId() %>">
                                    <% if (!"ACCEPTED".equals(reservation.getStatus())) { %>
                                        <button type="submit" name="status" value="ACCEPTED" class="btn btn-primary">
                                            <i class="fa-solid fa-check"></i> Accept
                                        </button>
                                        <% } %>
                                            <button type="submit" name="status" value="CANCELLED" class="btn btn-danger"
                                                onclick="return confirm('Cancel this reservation?');">
                                                <i class="fa-solid fa-times"></i> Cancel Reservation
                                            </button>
                                </form>
                            </div>
                            <% } %>

                                <div class="info-grid">
                                    <div class="info-item">
                                        <div class="info-label"><i class="fa-solid fa-door-open"></i> Room</div>
                                        <div class="info-value">Room #<%= reservation.getRoomId() %>
                                        </div>
                                    </div>

                                    <div class="info-item">
                                        <div class="info-label"><i class="fa-solid fa-user"></i> User</div>
                                        <div class="info-value">User #<%= reservation.getUserId() %>
                                        </div>
                                    </div>

                                    <div class="info-item">
                                        <div class="info-label"><i class="fa-regular fa-calendar"></i> Start</div>
                                        <div class="info-value">
                                            <%= reservation.getStartDatetime().format(formatter) %>
                                        </div>
                                    </div>

                                    <div class="info-item">
                                        <div class="info-label"><i class="fa-regular fa-calendar-check"></i> End</div>
                                        <div class="info-value">
                                            <%= reservation.getEndDatetime().toLocalDateTime().format(formatter) %>
                                        </div>
                                    </div>

                                    <div class="info-item">
                                        <div class="info-label"><i class="fa-regular fa-clock"></i> Duration</div>
                                        <div class="info-value">
                                            <%= java.time.Duration.between(reservation.getStartDatetime(),
                                                reservation.getEndDatetime().toLocalDateTime()).toHours() %> hours
                                        </div>
                                    </div>

                                    <div class="info-item">
                                        <div class="info-label"><i class="fa-solid fa-circle-info"></i> Status</div>
                                        <div class="info-value">
                                            <%= reservation.getStatus() %>
                                        </div>
                                    </div>
                                </div>

                                <% if (reservation.getNotes() !=null && !reservation.getNotes().isEmpty()) { %>
                                    <div class="notes-section">
                                        <strong><i class="fa-regular fa-note-sticky"></i> Notes:</strong><br><br>
                                        <%= reservation.getNotes() %>
                                    </div>
                                    <% } %>

                                        <div class="actions">
                                            <a href="${pageContext.request.contextPath}/reservations/myreservations"
                                                class="btn btn-secondary">
                                                <i class="fa-solid fa-arrow-left"></i> Back
                                            </a>
                                            <% if (("CONFIRMED".equals(reservation.getStatus()) || "PENDING"
                                                .equals(reservation.getStatus())) && !isAdmin) { %>
                                                <a href="${pageContext.request.contextPath}/reservations/cancel?id=<%= reservation.getId() %>"
                                                    class="btn btn-danger"
                                                    onclick="return confirm('Are you sure you want to cancel this reservation?');">
                                                    <i class="fa-solid fa-times"></i> Cancel Reservation
                                                </a>
                                                <% } %>
                                        </div>
                    </div>
                    <% } else { %>
                        <div class="not-found">
                            <h2><i class="fa-solid fa-circle-exclamation"></i> Reservation Not Found</h2>
                            <a href="${pageContext.request.contextPath}/reservations/myreservations"
                                class="btn btn-primary">
                                <i class="fa-solid fa-arrow-left"></i> Back to My Reservations
                            </a>
                        </div>
                        <% } %>
            </div>
        </body>

        </html>