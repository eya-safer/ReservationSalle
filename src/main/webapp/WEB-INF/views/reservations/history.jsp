<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="com.coworking.model.Reservation, java.util.List, java.time.format.DateTimeFormatter" %>
        <!DOCTYPE html>
        <html lang="fr">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Admin - Reservation History - SPACE</title>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
            <style>
                /* Reuse styles from list.jsp */
                .main-header {
                    background-color: var(--surface-color);
                    box-shadow: var(--shadow);
                    position: sticky;
                    top: 0;
                    z-index: 1000;
                    border-bottom: 2px solid var(--primary-color);
                }

                .header-wrapper {
                    max-width: 1400px;
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
                    max-width: 1400px;
                    margin: 0 auto;
                    padding: 2rem;
                }

                .page-header {
                    margin-bottom: 2rem;
                }

                .page-title {
                    color: var(--text-primary);
                    font-size: 2rem;
                    margin-bottom: 0.5rem;
                }

                .admin-badge {
                    background: var(--primary-color);
                    color: #121212;
                    padding: 0.5rem 1rem;
                    border-radius: 2rem;
                    font-size: 0.875rem;
                    font-weight: 600;
                    display: inline-block;
                }

                .table-container {
                    background: var(--surface-color);
                    border-radius: var(--radius);
                    overflow: hidden;
                    box-shadow: var(--shadow-lg);
                    border: 1px solid var(--border-color);
                }

                table {
                    width: 100%;
                    border-collapse: collapse;
                }

                thead {
                    background: var(--background-color);
                }

                th {
                    padding: 1rem;
                    text-align: left;
                    color: var(--text-primary);
                    font-weight: 600;
                    border-bottom: 2px solid var(--border-color);
                }

                td {
                    padding: 1rem;
                    border-bottom: 1px solid var(--border-color);
                    color: var(--text-secondary);
                }

                tr:hover {
                    background: var(--background-color);
                }

                .status-badge {
                    padding: 0.25rem 0.75rem;
                    border-radius: 1rem;
                    font-size: 0.75rem;
                    font-weight: 600;
                    display: inline-block;
                }

                .status-completed {
                    background: rgba(59, 130, 246, 0.2);
                    color: #3b82f6;
                }

                .action-buttons {
                    display: flex;
                    gap: 0.5rem;
                    flex-wrap: wrap;
                }

                .action-btn {
                    padding: 0.375rem 0.75rem;
                    border: none;
                    border-radius: var(--radius);
                    cursor: pointer;
                    font-size: 0.75rem;
                    font-weight: 600;
                    text-decoration: none;
                    display: inline-flex;
                    align-items: center;
                    gap: 0.25rem;
                    transition: all 0.2s;
                }

                .btn-view {
                    background: var(--primary-color);
                    color: #121212;
                }

                .btn-view:hover {
                    background: var(--primary-light);
                }

                .empty-state {
                    text-align: center;
                    padding: 4rem 2rem;
                    color: var(--text-secondary);
                }

                .empty-state i {
                    font-size: 3rem;
                    margin-bottom: 1rem;
                    opacity: 0.5;
                }

                .empty-state h2 {
                    color: var(--text-primary);
                    margin-bottom: 0.5rem;
                }

                .btn-secondary {
                    background-color: var(--surface-color);
                    color: var(--text-secondary);
                    border: 1px solid var(--border-color);
                }

                .btn-secondary:hover {
                    background-color: var(--border-color);
                    color: var(--text-primary);
                }

                .btn-primary {
                    background-color: var(--primary-color);
                    color: #121212;
                    border: 1px solid var(--primary-color);
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
                        <a href="${pageContext.request.contextPath}/reservations/list">Admin: All Reservations</a>
                        <a href="${pageContext.request.contextPath}/auth/logout" class="btn btn-secondary"
                            style="padding: 0.375rem 0.875rem;">
                            <i class="fa-solid fa-sign-out-alt"></i>
                        </a>
                    </nav>
                </div>
            </header>

            <div class="container">
                <div class="page-header">
                    <h1 class="page-title"><i class="fa-solid fa-user-shield"></i> Reservation Management</h1>
                    <span class="admin-badge"><i class="fa-solid fa-crown"></i> Admin Mode</span>
                </div>

                <div class="view-tabs mb-4">
                    <a href="${pageContext.request.contextPath}/reservations/list" class="btn btn-secondary me-2">
                        <i class="fa-solid fa-check-circle"></i> Confirmed
                    </a>
                    <a href="${pageContext.request.contextPath}/reservations/pending" class="btn btn-secondary me-2">
                        <i class="fa-solid fa-hourglass-half"></i> Pending
                    </a>
                    <a href="${pageContext.request.contextPath}/reservations/cancelled" class="btn btn-secondary me-2">
                        <i class="fa-solid fa-ban"></i> Cancelled
                    </a>
                    <a href="${pageContext.request.contextPath}/reservations/history" class="btn btn-primary">
                        <i class="fa-solid fa-clock-rotate-left"></i> History
                    </a>
                </div>

                <% List<Reservation> reservations = (List<Reservation>) request.getAttribute("reservations");
                        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");

                        if (reservations != null && !reservations.isEmpty()) {
                        %>
                        <div class="table-container">
                            <table>
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>User</th>
                                        <th>Room</th>
                                        <th>Start</th>
                                        <th>End</th>
                                        <th>Status</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% for (Reservation reservation : reservations) { %>
                                        <tr>
                                            <td><strong style="color: var(--text-primary);">#<%= reservation.getId() %>
                                                </strong></td>
                                            <td><i class="fa-solid fa-user"></i> User #<%= reservation.getUserId() %>
                                            </td>
                                            <td><i class="fa-solid fa-door-open"></i> Room #<%= reservation.getRoomId()
                                                    %>
                                            </td>
                                            <td>
                                                <%= reservation.getStartDatetime().format(formatter) %>
                                            </td>
                                            <td>
                                                <%= reservation.getEndDatetime().toLocalDateTime().format(formatter) %>
                                            </td>
                                            <td>
                                                <span class="status-badge status-completed">
                                                    <%= reservation.getStatus() %>
                                                </span>
                                            </td>
                                            <td>
                                                <div class="action-buttons">
                                                    <a href="${pageContext.request.contextPath}/reservations/view?id=<%= reservation.getId() %>"
                                                        class="action-btn btn-view">
                                                        <i class="fa-solid fa-eye"></i> View
                                                    </a>
                                                </div>
                                            </td>
                                        </tr>
                                        <% } %>
                                </tbody>
                            </table>
                        </div>
                        <% } else { %>
                            <div class="empty-state">
                                <i class="fa-solid fa-clock-rotate-left"></i>
                                <h2>No Completed Reservations</h2>
                                <p>There are no completed reservations in the history.</p>
                            </div>
                            <% } %>
            </div>
        </body>

        </html>