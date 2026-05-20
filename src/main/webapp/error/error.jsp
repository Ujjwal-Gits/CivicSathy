<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>CivicSathy - Error</title>
        <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;700&display=swap" rel="stylesheet">
        <script src="https://unpkg.com/lucide@latest/dist/umd/lucide.min.js"></script>
        <style>
            body {
                font-family: 'DM Sans', sans-serif;
                background: #F5F5F7;
                display: flex;
                align-items: center;
                justify-content: center;
                min-height: 100vh;
                margin: 0;
                color: #0A0A0A;
            }

            .card {
                background: white;
                padding: 40px;
                border-radius: 12px;
                border: 1px solid #E8E8ED;
                text-align: center;
                max-width: 400px;
                width: 90%;
            }

            .icon {
                background: #FFEBEB;
                color: #D32F2F;
                width: 64px;
                height: 64px;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                margin: 0 auto 20px;
            }

            h1 {
                font-size: 24px;
                margin-bottom: 12px;
            }

            p {
                color: #86868B;
                font-size: 14px;
                line-height: 1.6;
                margin-bottom: 24px;
            }

            .btn {
                background: #005B96;
                color: white;
                padding: 12px 24px;
                border-radius: 6px;
                text-decoration: none;
                font-weight: 600;
                font-size: 14px;
                display: inline-block;
            }
        </style>
    </head>

    <body>
        <div class="card">
            <div class="icon"><i data-lucide="alert-triangle"></i></div>
            <h1>Something went wrong</h1>
            <p>We encountered an unexpected error while processing your request. Please try returning to the dashboard.
            </p>
            <a href="${pageContext.request.contextPath}/index.jsp" class="btn">Back to Home</a>
        </div>
        <script>lucide.createIcons();</script>
    </body>

    </html>