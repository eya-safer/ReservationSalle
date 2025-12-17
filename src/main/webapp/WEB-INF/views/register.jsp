<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="fr">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>SPACE - Create Account</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

        <style>
            :root {
                --primary-color: #FFD700;
                --primary-dark: #FFC700;
                --primary-light: #FFED4E;
                --background-color: #121212;
                --surface-color: #1E1E1E;
                --text-primary: #FFFFFF;
                --text-secondary: #B0B0B0;
                --border-color: #333333;
                --shadow-lg: 0 10px 15px -3px rgba(0, 0, 0, 0.6), 0 4px 6px -2px rgba(0, 0, 0, 0.4);
                --radius: 0.75rem;
            }

            body {
                margin: 0;
                font-family: 'Inter', 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                min-height: 100vh;
                display: flex;
                justify-content: flex-start;
                align-items: center;
                padding-left: 8%;
                overflow: hidden;
                background-color: var(--background-color);
            }

            .video-background {
                position: fixed;
                right: 0;
                bottom: 0;
                min-width: 100%;
                min-height: 100%;
                object-fit: cover;
                z-index: -2;
            }

            .video-overlay {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0, 0, 0, 0.7);
                z-index: -1;
            }

            .register-container {
                background: var(--surface-color);
                backdrop-filter: blur(12px);
                padding: 45px;
                border-radius: 20px;
                box-shadow: var(--shadow-lg);
                border: 1px solid var(--border-color);
                width: 100%;
                max-width: 520px;
                animation: slideIn 0.8s ease;
            }

            @keyframes slideIn {
                from {
                    opacity: 0;
                    transform: translateX(-40px);
                }

                to {
                    opacity: 1;
                    transform: translateX(0);
                }
            }

            .logo-section {
                text-align: center;
                margin-bottom: 30px;
            }

            .logo-text {
                font-size: 2rem;
                font-weight: 700;
                color: var(--primary-color);
                letter-spacing: 0.1em;
                margin-bottom: 0.5rem;
            }

            h1 {
                color: var(--text-primary);
                text-align: center;
                margin-bottom: 30px;
                font-size: 1.75rem;
            }

            .form-group {
                margin-bottom: 18px;
            }

            label {
                display: block;
                margin-bottom: 8px;
                color: var(--text-secondary);
                font-weight: 600;
            }

            input {
                width: 100%;
                padding: 12px;
                border: 2px solid var(--border-color);
                border-radius: var(--radius);
                font-size: 14px;
                box-sizing: border-box;
                transition: border-color 0.3s;
                background-color: var(--background-color);
                color: var(--text-primary);
            }

            input:focus {
                outline: none;
                border-color: var(--primary-color);
                box-shadow: 0 0 0 3px rgba(255, 215, 0, 0.2);
            }

            .required {
                color: #ff6b6b;
            }

            button {
                width: 100%;
                padding: 14px;
                margin-top: 10px;
                background: var(--primary-color);
                color: #121212;
                border: none;
                border-radius: var(--radius);
                font-size: 16px;
                font-weight: 600;
                cursor: pointer;
                transition: transform 0.2s, box-shadow 0.2s;
            }

            button:hover {
                transform: translateY(-2px);
                background: var(--primary-light);
                box-shadow: 0 8px 20px rgba(255, 215, 0, 0.4);
            }

            .alert {
                padding: 12px;
                border-radius: var(--radius);
                margin-bottom: 20px;
                font-size: 14px;
            }

            .alert-error {
                background-color: #2a1515;
                color: #ff6b6b;
                border: 1px solid #4a1f1f;
            }

            .login-link {
                text-align: center;
                margin-top: 22px;
                color: var(--text-secondary);
            }

            .login-link a {
                color: var(--primary-color);
                text-decoration: none;
                font-weight: 600;
            }

            .login-link a:hover {
                text-decoration: underline;
            }

            @media (max-width: 768px) {
                body {
                    justify-content: center;
                    padding-left: 0;
                }

                .register-container {
                    max-width: 92%;
                }
            }
        </style>
    </head>

    <body>

        <video autoplay muted loop class="video-background">
            <source src="${pageContext.request.contextPath}/videos/coworking.mp4" type="video/mp4">
        </video>
        <div class="video-overlay"></div>

        <div class="register-container">
            <div class="logo-section">
                <div class="logo-text">SPACE</div>
            </div>

            <h1>Create Account</h1>

            <% if (request.getAttribute("error") !=null) { %>
                <div class="alert alert-error">
                    <%= request.getAttribute("error") %>
                </div>
                <% } %>

                    <form action="${pageContext.request.contextPath}/auth/register" method="post">

                        <div class="form-group">
                            <label for="username">Username <span class="required">*</span></label>
                            <input type="text" id="username" name="username" required autofocus>
                        </div>

                        <div class="form-group">
                            <label for="email">Email <span class="required">*</span></label>
                            <input type="email" id="email" name="email" required>
                        </div>

                        <div class="form-group">
                            <label for="phone">Phone</label>
                            <input type="tel" id="phone" name="phone">
                        </div>

                        <div class="form-group">
                            <label for="password">Password <span class="required">*</span></label>
                            <input type="password" id="password" name="password" required minlength="6">
                        </div>

                        <div class="form-group">
                            <label for="confirmPassword">Confirm Password <span class="required">*</span></label>
                            <input type="password" id="confirmPassword" name="confirmPassword" required minlength="6">
                        </div>

                        <button type="submit">Create Account</button>
                    </form>

                    <div class="login-link">
                        Already have an account?
                        <a href="${pageContext.request.contextPath}/auth/login">Sign In</a>
                    </div>
        </div>

    </body>

    </html>