<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="com.coworking.model.Room, java.util.List" %>
        <!DOCTYPE html>
        <html lang="fr">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>SPACE - Coworking Room Reservation</title>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

            <style>
                :root {
                    --primary-color: #FFD700;
                    --primary-light: #FFED4E;
                    --background-color: #121212;
                    --surface-color: #1E1E1E;
                    --text-primary: #FFFFFF;
                    --text-secondary: #B0B0B0;
                    --border-color: #333333;
                    --radius: 0.75rem;
                    --shadow: 0 4px 6px rgba(0, 0, 0, 0.5);
                    --shadow-lg: 0 10px 15px -3px rgba(0, 0, 0, 0.6);
                }

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
                    height: 50px;
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

                .header-nav a,
                .header-nav span {
                    color: var(--text-secondary);
                    font-weight: 500;
                    text-decoration: none;
                }

                .header-nav a.btn {
                    padding: 0.5rem 1rem;
                    border-radius: var(--radius);
                }

                .hero-section {
                    position: relative;
                    height: 100vh;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    overflow: hidden;
                    background-color: #000;
                }

                .hero-video {
                    position: absolute;
                    top: 50%;
                    left: 50%;
                    min-width: 100%;
                    min-height: 100%;
                    transform: translate(-50%, -50%);
                    object-fit: cover;
                    z-index: 1;
                }

                .hero-overlay {
                    position: absolute;
                    top: 0;
                    left: 0;
                    width: 100%;
                    height: 100%;
                    background: rgba(18, 18, 18, 0.6);
                    z-index: 2;
                }

                .hero-content {
                    position: relative;
                    z-index: 3;
                    text-align: center;
                    max-width: 900px;
                    padding: 2rem;
                    color: var(--text-primary);
                    animation: fadeInUp 1s ease-out;
                }

                @keyframes fadeInUp {
                    from {
                        opacity: 0;
                        transform: translateY(30px);
                    }

                    to {
                        opacity: 1;
                        transform: translateY(0);
                    }
                }

                .hero-content h1 {
                    font-size: 4rem;
                    margin-bottom: 1rem;
                    color: var(--primary-color);
                    font-weight: 700;
                }

                .hero-content p {
                    font-size: 1.5rem;
                    margin-bottom: 2rem;
                    color: var(--text-secondary);
                }

                .cta-buttons {
                    display: flex;
                    gap: 1rem;
                    justify-content: center;
                    flex-wrap: wrap;
                }

                .cta-btn {
                    padding: 1rem 2rem;
                    font-weight: 600;
                    border-radius: var(--radius);
                    text-decoration: none;
                    display: inline-flex;
                    align-items: center;
                    gap: 0.5rem;
                    transition: all 0.3s ease;
                }

                .cta-btn-primary {
                    background-color: var(--primary-color);
                    color: #121212;
                }

                .cta-btn-primary:hover {
                    background-color: var(--primary-light);
                    transform: translateY(-3px);
                }

                .cta-btn-secondary {
                    background-color: transparent;
                    color: var(--text-primary);
                    border: 2px solid var(--primary-color);
                }

                .cta-btn-secondary:hover {
                    background-color: var(--primary-color);
                    color: #121212;
                    transform: translateY(-3px);
                }

                @media (max-width: 768px) {
                    .hero-content h1 {
                        font-size: 2.5rem;
                    }

                    .hero-content p {
                        font-size: 1.2rem;
                    }

                    .cta-buttons {
                        flex-direction: column;
                    }

                    .cta-btn {
                        width: 100%;
                        justify-content: center;
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
                        <% String username=(String) session.getAttribute("username"); String role=(String)
                            session.getAttribute("userRole"); if (username !=null) { %>
                            <span><i class="fa-solid fa-user-circle"></i>
                                <%= username %>
                            </span>
                            <% if ("ADMIN".equals(role)) { %>
                                <a href="${pageContext.request.contextPath}/rooms/add" class="btn btn-primary">Add
                                    Room</a>
                                <% } %>
                                    <a href="${pageContext.request.contextPath}/auth/logout" class="btn btn-secondary">
                                        <i class="fa-solid fa-sign-out-alt"></i> Logout
                                    </a>
                                    <% } else { %>
                                        <a href="${pageContext.request.contextPath}/auth/login"
                                            class="btn btn-secondary">Sign In</a>
                                        <a href="${pageContext.request.contextPath}/auth/register"
                                            class="btn btn-primary">Register</a>
                                        <% } %>
                    </nav>
                </div>
            </header>

            <section class="hero-section">
                <video autoplay muted loop class="hero-video">
                    <source src="${pageContext.request.contextPath}/videos/coworking.mp4" type="video/mp4">
                </video>
                <div class="hero-overlay"></div>

                <div class="hero-content">
                    <h1>Your Workspace, Elevated</h1>
                    <p>Discover a premium coworking experience designed for productivity and collaboration. Book your
                        ideal workspace in seconds.</p>
                    <div class="cta-buttons">
                        <% if (username==null) { %>
                            <a href="${pageContext.request.contextPath}/auth/login" class="cta-btn cta-btn-primary">
                                <i class="fa-solid fa-arrow-right-to-bracket"></i> Sign In
                            </a>
                            <a href="${pageContext.request.contextPath}/auth/register"
                                class="cta-btn cta-btn-secondary">
                                <i class="fa-solid fa-user-plus"></i> Create Account
                            </a>
                            <% } else { %>
                                <a href="${pageContext.request.contextPath}/rooms/list" class="cta-btn cta-btn-primary">
                                    <i class="fa-solid fa-door-open"></i> See Available Rooms
                                </a>
                                <% } %>
                    </div>
                </div>
            </section>
        </body>

        </html>