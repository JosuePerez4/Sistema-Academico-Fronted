<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Error - Sistema Académico</title>
    <link rel="stylesheet" href="/css/profesor.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
<div class="container">
    <%@ include file="common/sidebar.jsp" %>
    <main class="main-content">
        <div class="error-container">
            <div class="error-content">
                <i class="fas fa-exclamation-circle error-icon"></i>
                <h1>¡Ups! Algo salió mal</h1>
                <p>${error}</p>
                <a href="javascript:history.back()" class="btn-primary">
                    <i class="fas fa-arrow-left"></i> Volver
                </a>
            </div>
        </div>
    </main>
</div>

<style>
.error-container {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100%;
    padding: 20px;
}

.error-content {
    text-align: center;
    background: white;
    padding: 40px;
    border-radius: 8px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    max-width: 500px;
}

.error-icon {
    font-size: 48px;
    color: #dc3545;
    margin-bottom: 20px;
}

.error-content h1 {
    margin-bottom: 16px;
    color: #333;
}

.error-content p {
    margin-bottom: 24px;
    color: #666;
}

.btn-primary {
    background-color: #007bff;
    color: white;
    padding: 8px 16px;
    border-radius: 4px;
    text-decoration: none;
    display: inline-flex;
    align-items: center;
    gap: 8px;
}
</style>
</body>
</html> 