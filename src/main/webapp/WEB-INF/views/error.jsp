<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="fr">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Erreur - Coworking Space</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                min-height: 100vh;
                display: flex;
                justify-content: center;
                align-items: center;
                padding: 20px;
            }

            .error-container {
                background: white;
                padding: 60px 40px;
                border-radius: 20px;
                box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
                text-align: center;
                max-width: 500px;
            }

            .error-icon {
                font-size: 80px;
                margin-bottom: 20px;
            }

            h1 {
                color: #c62828;
                margin-bottom: 20px;
                font-size: 32px;
            }

            .error-message {
                color: #666;
                margin-bottom: 30px;
                line-height: 1.6;
            }

            .btn {
                padding: 14px 28px;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                border: none;
                border-radius: 10px;
                cursor: pointer;
                font-weight: 600;
                font-size: 16px;
                text-decoration: none;
                display: inline-block;
                transition: all 0.3s;
            }

            .btn:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 12px rgba(102, 126, 234, 0.4);
            }
        </style>
    </head>

    <body>
        <div class="error-container">
            <div class="error-icon">⚠️</div>
            <h1>Oups ! Une erreur est survenue</h1>
            <div class="error-message">
                <% String error=(String) request.getAttribute("error"); if (error !=null && !error.isEmpty()) { %>
                    <%= error %>
                        <% } else { %>
                            Une erreur inattendue s'est produite. Veuillez réessayer plus tard.
                            <% } %>
            </div>
            <a href="${pageContext.request.contextPath}/rooms/list" class="btn">
                Retour à l'accueil
            </a>
        </div>
    </body>

    </html>