<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="fr">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>SPACE - Coworking Room Reservation</title>
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
                gap: 1.5rem;
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
                width: auto;
                height: auto;
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
                background: linear-gradient(135deg, rgba(0, 0, 0, 0.7) 0%, rgba(18, 18, 18, 0.5) 100%);
                z-index: 2;
            }

            .hero-content {
                position: relative;
                z-index: 3;
                text-align: center;
                max-width: 900px;
                padding: 2rem;
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
                margin-bottom: 1.5rem;
                color: var(--primary-color);
                text-shadow: 2px 2px 8px rgba(0, 0, 0, 0.8);
                font-weight: 700;
                letter-spacing: -0.02em;
            }

            .hero-content .subtitle {
                font-size: 1.5rem;
                color: #E0E0E0;
                margin-bottom: 3rem;
                line-height: 1.6;
                text-shadow: 1px 1px 4px rgba(0, 0, 0, 0.8);
            }

            .cta-buttons {
                display: flex;
                gap: 1.5rem;
                justify-content: center;
                flex-wrap: wrap;
            }

            .cta-btn {
                padding: 1rem 2.5rem;
                font-size: 1.1rem;
                font-weight: 600;
                border-radius: var(--radius);
                transition: all 0.3s ease;
                text-decoration: none;
                display: inline-flex;
                align-items: center;
                gap: 0.75rem;
                box-shadow: var(--shadow-lg);
            }

            .cta-btn-primary {
                background-color: var(--primary-color);
                color: #121212;
                border: none;
            }

            .cta-btn-primary:hover {
                background-color: var(--primary-light);
                transform: translateY(-3px);
                box-shadow: 0 15px 30px -5px rgba(255, 215, 0, 0.4);
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

            .features-section {
                padding: 6rem 2rem;
                background-color: var(--background-color);
            }

            .features-container {
                max-width: 1200px;
                margin: 0 auto;
            }

            .features-title {
                text-align: center;
                font-size: 2.5rem;
                color: var(--text-primary);
                margin-bottom: 4rem;
            }

            .features-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
                gap: 2.5rem;
            }

            .feature-card {
                background-color: var(--surface-color);
                padding: 2.5rem;
                border-radius: var(--radius);
                border: 1px solid var(--border-color);
                text-align: center;
                transition: all 0.3s ease;
                box-shadow: var(--shadow);
            }

            .feature-card:hover {
                transform: translateY(-8px);
                border-color: var(--primary-color);
                box-shadow: 0 12px 24px rgba(255, 215, 0, 0.15);
            }

            .feature-icon {
                font-size: 3rem;
                color: var(--primary-color);
                margin-bottom: 1.5rem;
            }

            .feature-title {
                font-size: 1.3rem;
                color: var(--text-primary);
                margin-bottom: 0.75rem;
            }

            .feature-description {
                color: var(--text-secondary);
                line-height: 1.6;
            }

            @media (max-width: 768px) {
                .hero-content h1 {
                    font-size: 2.5rem;
                }

                .hero-content .subtitle {
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
                    <a href="${pageContext.request.contextPath}/auth/login" class="btn btn-secondary">Sign In</a>
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
                <p class="subtitle">
                    Discover a premium coworking experience designed for productivity and collaboration.
                    Book your ideal workspace in seconds.
                </p>

                <div class="cta-buttons">
                    <a href="${pageContext.request.contextPath}/auth/login" class="cta-btn cta-btn-primary">
                        <i class="fa-solid fa-arrow-right-to-bracket"></i> Sign In
                    </a>
                    <a href="${pageContext.request.contextPath}/auth/register" class="cta-btn cta-btn-secondary">
                        <i class="fa-solid fa-user-plus"></i> Create Account
                    </a>
                </div>
            </div>
        </section>

        <section class="features-section">
            <div class="features-container">
                <h2 class="features-title">Why Choose SPACE?</h2>

                <div class="features-grid">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fa-solid fa-bolt"></i>
                        </div>
                        <h3 class="feature-title">Instant Booking</h3>
                        <p class="feature-description">
                            Book your workspace in seconds with our streamlined reservation system.
                        </p>
                    </div>

                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fa-solid fa-calendar-check"></i>
                        </div>
                        <h3 class="feature-title">Smart Scheduling</h3>
                        <p class="feature-description">
                            Manage your time efficiently with intelligent scheduling tools.
                        </p>
                    </div>

                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fa-solid fa-shield-halved"></i>
                        </div>
                        <h3 class="feature-title">Secure & Reliable</h3>
                        <p class="feature-description">
                            Your data is protected with enterprise-grade security measures.
                        </p>
                    </div>
                </div>
            </div>
        </section>
    </body>

    </html>