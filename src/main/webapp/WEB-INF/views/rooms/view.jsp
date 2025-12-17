<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="com.coworking.model.Room" %>

        <!DOCTYPE html>
        <html lang="fr">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Room Details - SPACE</title>

            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

            <style>
                .room-header {
                    position: relative;
                    height: 400px;
                    overflow: hidden;
                    border-radius: var(--radius);
                    margin-bottom: 2rem;
                    box-shadow: var(--shadow-lg);
                }

                .room-header img {
                    width: 100%;
                    height: 100%;
                    object-fit: cover;
                }

                .room-badges {
                    position: absolute;
                    top: 20px;
                    right: 20px;
                }

                .info-card {
                    background: var(--surface-color);
                    border-radius: var(--radius);
                    padding: 2rem;
                    box-shadow: var(--shadow);
                    border: 1px solid var(--border-color);
                }

                .detail-grid {
                    display: grid;
                    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                    gap: 2rem;
                    margin: 2rem 0;
                    padding: 2rem 0;
                    border-top: 1px solid var(--border-color);
                    border-bottom: 1px solid var(--border-color);
                }

                .detail-item {
                    display: flex;
                    align-items: center;
                    gap: 1rem;
                }

                .detail-icon {
                    width: 3rem;
                    height: 3rem;
                    background: var(--background-color);
                    border-radius: 50%;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    color: var(--primary-color);
                    font-size: 1.25rem;
                }
            </style>
        </head>

        <body>

            <header class="main-header"
                style="background-color: var(--surface-color); box-shadow: var(--shadow); position: sticky; top: 0; z-index: 1000; border-bottom: 2px solid var(--primary-color);">
                <div
                    style="max-width: 1200px; margin: 0 auto; padding: 1rem 2rem; display: flex; justify-content: space-between; align-items: center;">
                    <div style="display: flex; align-items: center; gap: 1rem;">
                        <img src="${pageContext.request.contextPath}/images/logo.png" alt="SPACE Logo"
                            style="height: 45px; width: auto;">
                        <span
                            style="font-size: 1.5rem; font-weight: 700; color: var(--primary-color); letter-spacing: 0.1em;">SPACE</span>
                    </div>
                    <nav style="display: flex; gap: 1.5rem; align-items: center;">
                        <a href="${pageContext.request.contextPath}/rooms/list"
                            style="color: var(--text-secondary); text-decoration: none; font-weight: 500;">
                            <i class="fa-solid fa-arrow-left"></i> Back to Rooms
                        </a>
                        <a href="${pageContext.request.contextPath}/auth/logout" class="btn btn-secondary"
                            style="padding: 0.5rem 1rem;">Sign Out</a>
                    </nav>
                </div>
            </header>

            <div class="container" style="padding-top: 2rem; padding-bottom: 4rem;">

                <% Room room=(Room) request.getAttribute("room"); if (room !=null) { String imgPath=room.getImageUrl();
                    String[] defaultImages={ "room-1.png" , "room-2.png" , "room-3.png" }; if (imgPath==null ||
                    imgPath.isEmpty() || imgPath.contains("default")) { int imgIdx=(int) (room.getId() %
                    defaultImages.length); imgPath="images/" + defaultImages[imgIdx]; } else if
                    (!imgPath.startsWith("images/") && !imgPath.startsWith("http")) { imgPath="images/" + imgPath; } %>

                    <div class="room-header">
                        <img src="${pageContext.request.contextPath}/<%= imgPath %>" alt="<%= room.getName() %>"
                            onerror="this.src='${pageContext.request.contextPath}/images/room-1.png'">

                        <div class="room-badges">
                            <span class="badge badge-<%= " AVAILABLE".equals(room.getStatus()) ? "available"
                                : "maintenance" %>">
                                <%= "AVAILABLE" .equals(room.getStatus()) ? "Available" : "Maintenance" %>
                            </span>
                        </div>
                    </div>

                    <div class="info-card">

                        <div style="display:flex; justify-content:space-between;">
                            <div>
                                <h1 style="color: var(--text-primary);">
                                    <%= room.getName() %>
                                </h1>
                                <p style="color: var(--text-secondary);">Professional Room</p>
                            </div>
                            <div>
                                <span style="font-size:2rem; color:var(--primary-color);">
                                    <%= room.getPricePerHour() %>€
                                </span> per hour
                            </div>
                        </div>

                        <div class="detail-grid">
                            <div class="detail-item">
                                <div class="detail-icon"><i class="fa-solid fa-users"></i></div>
                                <div>
                                    <small style="color: var(--text-secondary);">Capacity</small><br>
                                    <strong style="color: var(--text-primary);">
                                        <%= room.getCapacity() %> people
                                    </strong>
                                </div>
                            </div>

                            <div class="detail-item">
                                <div class="detail-icon"><i class="fa-solid fa-hashtag"></i></div>
                                <div>
                                    <small style="color: var(--text-secondary);">Reference</small><br>
                                    <strong style="color: var(--text-primary);">#<%= room.getId() %></strong>
                                </div>
                            </div>
                        </div>

                        <h3 style="color: var(--text-primary);">Description</h3>
                        <p style="color: var(--text-secondary);">
                            <%= (room.getDescription() !=null && !room.getDescription().isEmpty()) ?
                                room.getDescription() : "No description available." %>
                        </p>

                        <div style="margin-top:2rem; display:flex; gap:1rem;">
                            <a href="${pageContext.request.contextPath}/rooms/list" class="btn btn-secondary">
                                Back
                            </a>

                            <% if ("AVAILABLE".equals(room.getStatus())) { %>
                                <a href="${pageContext.request.contextPath}/reservations/create?roomId=<%= room.getId() %>"
                                    class="btn btn-primary">
                                    <i class="fa-regular fa-calendar-check"></i> Book
                                </a>
                                <% } %>

                                    <% if ("ADMIN".equals(session.getAttribute("userRole"))) { %>
                                        <a href="${pageContext.request.contextPath}/rooms/edit?id=<%= room.getId() %>"
                                            class="btn btn-warning">
                                            Edit
                                        </a>
                                        <a href="${pageContext.request.contextPath}/rooms/delete?id=<%= room.getId() %>"
                                            class="btn btn-danger" onclick="return confirm('Delete this room?');">
                                            Delete
                                        </a>
                                        <% } %>
                        </div>

                    </div>

                    <% } else { %>

                        <div style="text-align:center; padding:4rem; color: var(--text-secondary);">
                            <h2 style="color: var(--text-primary);">Room Not Found</h2>
                            <a href="${pageContext.request.contextPath}/rooms/list" class="btn btn-primary">
                                Back to Rooms
                            </a>
                        </div>

                        <% } %>

            </div>
        </body>

        </html>