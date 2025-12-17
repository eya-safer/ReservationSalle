<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="com.coworking.model.Room" %>
        <!DOCTYPE html>
        <html lang="fr">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Edit Room - SPACE</title>
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
                    min-height: 120px;
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
                        <a href="${pageContext.request.contextPath}/rooms/list">
                            <i class="fa-solid fa-arrow-left"></i> Back to Rooms
                        </a>
                        <a href="${pageContext.request.contextPath}/auth/logout" class="btn btn-secondary">
                            <i class="fa-solid fa-sign-out-alt"></i> Logout
                        </a>
                    </nav>
                </div>
            </header>

            <div class="container">
                <div class="form-container">
                    <span class="admin-badge"><i class="fa-solid fa-user-shield"></i> Admin Mode</span>
                    <h1 class="page-title"><i class="fa-solid fa-pen-to-square"></i> Edit Room</h1>

                    <% if (request.getAttribute("error") !=null) { %>
                        <div class="alert alert-error">
                            <i class="fa-solid fa-exclamation-circle"></i>
                            <%= request.getAttribute("error") %>
                        </div>
                        <% } %>

                            <% Room room=(Room) request.getAttribute("room"); if (room !=null) { %>
                                <form action="${pageContext.request.contextPath}/rooms/edit" method="post">
                                    <input type="hidden" name="id" value="<%= room.getId() %>">

                                    <div class="form-group">
                                        <label for="name">Room Name <span class="required">*</span></label>
                                        <input type="text" id="name" name="name" required value="<%= room.getName() %>">
                                    </div>

                                    <div class="form-group">
                                        <label for="capacity">Capacity (people) <span class="required">*</span></label>
                                        <input type="number" id="capacity" name="capacity" required min="1"
                                            value="<%= room.getCapacity() %>">
                                    </div>

                                    <div class="form-group">
                                        <label for="pricePerHour">Price per hour (€) <span
                                                class="required">*</span></label>
                                        <input type="number" id="pricePerHour" name="pricePerHour" step="0.01" min="0"
                                            value="<%= room.getPricePerHour() %>" required>
                                    </div>

                                    <div class="form-group">
                                        <label for="status">Status <span class="required">*</span></label>
                                        <select id="status" name="status" required>
                                            <option value="AVAILABLE" <%="AVAILABLE" .equals(room.getStatus())
                                                ? "selected" : "" %>>Available</option>
                                            <option value="MAINTENANCE" <%="MAINTENANCE" .equals(room.getStatus())
                                                ? "selected" : "" %>>Maintenance</option>
                                            <option value="UNAVAILABLE" <%="UNAVAILABLE" .equals(room.getStatus())
                                                ? "selected" : "" %>>Unavailable</option>
                                        </select>
                                    </div>

                                    <div class="form-group">
                                        <label for="imageUrl">Image URL</label>
                                        <input type="text" id="imageUrl" name="imageUrl"
                                            value="<%= room.getImageUrl() != null ? room.getImageUrl() : "" %>">
                                    </div>

                                    <div class="form-group">
                                        <label for="description">Description</label>
                                        <textarea id="description"
                                            name="description"><%= room.getDescription() != null ? room.getDescription() : "" %></textarea>
                                    </div>

                                    <div class="btn-group">
                                        <a href="${pageContext.request.contextPath}/rooms/list"
                                            class="btn btn-secondary">
                                            <i class="fa-solid fa-times"></i> Cancel
                                        </a>
                                        <button type="submit" class="btn btn-primary">
                                            <i class="fa-solid fa-check"></i> Save Changes
                                        </button>
                                    </div>
                                </form>
                                <% } else { %>
                                    <div class="not-found">
                                        <h2><i class="fa-solid fa-circle-exclamation"></i> Room Not Found</h2>
                                        <a href="${pageContext.request.contextPath}/rooms/list" class="btn btn-primary">
                                            <i class="fa-solid fa-arrow-left"></i> Back to Rooms
                                        </a>
                                    </div>
                                    <% } %>
                </div>
            </div>
        </body>

        </html>