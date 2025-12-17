<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="com.coworking.model.Room, java.util.List" %>
        <!DOCTYPE html>
        <html lang="fr">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>New Reservation - SPACE</title>
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

                .container {
                    max-width: 700px;
                    margin: 3rem auto;
                    padding: 0 2rem;
                }

                .form-container {
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

                .alert {
                    padding: 1rem;
                    border-radius: var(--radius);
                    margin-bottom: 1.5rem;
                    border: 1px solid;
                }

                .alert-error {
                    background: rgba(239, 68, 68, 0.1);
                    border-color: var(--danger-color);
                    color: var(--danger-color);
                }

                .form-group {
                    margin-bottom: 1.5rem;
                }

                label {
                    display: block;
                    margin-bottom: 0.5rem;
                    color: var(--text-primary);
                    font-weight: 500;
                }

                input,
                select,
                textarea {
                    width: 100%;
                    padding: 0.75rem;
                    border: 1px solid var(--border-color);
                    border-radius: var(--radius);
                    font-size: 0.875rem;
                    background-color: #2A2A2A;
                    color: var(--text-primary);
                    transition: border-color 0.2s;
                }

                input:focus,
                select:focus,
                textarea:focus {
                    outline: none;
                    border-color: var(--primary-color);
                    box-shadow: 0 0 0 3px rgba(255, 215, 0, 0.1);
                }

                textarea {
                    resize: vertical;
                    min-height: 100px;
                }

                .required {
                    color: var(--danger-color);
                }

                .btn-group {
                    display: flex;
                    gap: 1rem;
                    margin-top: 2rem;
                }

                .btn-group .btn {
                    flex: 1;
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
                        <a href="${pageContext.request.contextPath}/auth/logout" class="btn btn-secondary"
                            style="padding: 0.5rem 1rem;">
                            <i class="fa-solid fa-sign-out-alt"></i> Logout
                        </a>
                    </nav>
                </div>
            </header>

            <div class="container">
                <div class="form-container">
                    <h1 class="page-title"><i class="fa-regular fa-calendar-plus"></i> New Reservation</h1>

                    <% if (request.getAttribute("error") !=null) { %>
                        <div class="alert alert-error">
                            <i class="fa-solid fa-exclamation-circle"></i>
                            <%= request.getAttribute("error") %>
                        </div>
                        <% } %>

                            <form action="${pageContext.request.contextPath}/reservations/create" method="post">
                                <div class="form-group">
                                    <label for="roomId">Room <span class="required">*</span></label>
                                    <select id="roomId" name="roomId" required>
                                        <option value="">-- Select a room --</option>
                                        <% List<Room> rooms = (List<Room>) request.getAttribute("rooms");
                                                Room selectedRoom = (Room) request.getAttribute("selectedRoom");
                                                if (rooms != null) {
                                                for (Room room : rooms) {
                                                boolean isSelected = selectedRoom != null &&
                                                selectedRoom.getId().equals(room.getId());
                                                %>
                                                <option value="<%= room.getId() %>" <%=isSelected ? "selected" : "" %>>
                                                    <%= room.getName() %> - <%= room.getCapacity() %> people - <%=
                                                                room.getPricePerHour() %>€/h
                                                </option>
                                                <% } } %>
                                    </select>
                                </div>

                                <div class="form-group">
                                    <label for="startDatetime">Start Date & Time <span class="required">*</span></label>
                                    <input type="datetime-local" id="startDatetime" name="startDatetime" required>
                                </div>

                                <div class="form-group">
                                    <label for="endDatetime">End Date & Time <span class="required">*</span></label>
                                    <input type="datetime-local" id="endDatetime" name="endDatetime" required>
                                </div>

                                <div class="form-group">
                                    <label for="notes">Notes (optional)</label>
                                    <textarea id="notes" name="notes"
                                        placeholder="Add notes about your reservation..."></textarea>
                                </div>

                                <div class="btn-group">
                                    <a href="${pageContext.request.contextPath}/rooms/list" class="btn btn-secondary">
                                        <i class="fa-solid fa-times"></i> Cancel
                                    </a>
                                    <button type="submit" class="btn btn-primary">
                                        <i class="fa-solid fa-check"></i> Confirm Reservation
                                    </button>
                                </div>
                            </form>
                </div>
            </div>

            <script>
                const now = new Date();
                now.setMinutes(now.getMinutes() - now.getTimezoneOffset());
                document.getElementById('startDatetime').min = now.toISOString().slice(0, 16);
                document.getElementById('endDatetime').min = now.toISOString().slice(0, 16);

                document.getElementById('startDatetime').addEventListener('change', function () {
                    document.getElementById('endDatetime').min = this.value;
                    if (document.getElementById('endDatetime').value < this.value) {
                        document.getElementById('endDatetime').value = '';
                    }
                });
            </script>
        </body>

        </html>