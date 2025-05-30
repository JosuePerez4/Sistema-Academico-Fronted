<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Iniciar sesión - Sistema Académico</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Inter', sans-serif;
        }

        body {
            min-height: 100vh;
            display: flex;
            background-color: #21465b;
        }

        .login-container {
            display: flex;
            width: 100%;
            min-height: 100vh;
        }

        .left-section {
            flex: 1;
            display: flex;
            flex-direction: column;
            justify-content: center;
            padding: 40px;
            color: white;
        }

        .left-section h1 {
            font-size: 2.5rem;
            margin-bottom: 20px;
            font-weight: 700;
        }

        .left-section p {
            font-size: 1.1rem;
            line-height: 1.6;
            opacity: 0.9;
        }

        .right-section {
            flex: 1;
            background: white;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 40px;
        }

        .login-form {
            width: 100%;
            max-width: 400px;
        }

        .form-header {
            text-align: center;
            margin-bottom: 30px;
        }

        .form-header h2 {
            color: #21465b;
            font-size: 1.8rem;
            margin-bottom: 10px;
        }

        .form-header p {
            color: #6c757d;
            font-size: 0.9rem;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            color: #21465b;
            font-size: 0.9rem;
            margin-bottom: 8px;
            font-weight: 500;
        }

        .input-wrapper {
            position: relative;
        }

        .input-wrapper i {
            position: absolute;
            left: 12px;
            top: 50%;
            transform: translateY(-50%);
            color: #6c757d;
        }

        .form-control {
            width: 100%;
            padding: 12px 12px 12px 40px;
            border: 1px solid #dee2e6;
            border-radius: 8px;
            font-size: 0.9rem;
            transition: all 0.3s ease;
        }

        .form-control:focus {
            border-color: #21465b;
            box-shadow: 0 0 0 0.2rem rgba(33, 70, 91, 0.25);
            outline: none;
        }

        .forgot-password {
            display: block;
            text-align: right;
            color: #21465b;
            font-size: 0.8rem;
            text-decoration: none;
            margin-top: 8px;
        }

        .forgot-password:hover {
            text-decoration: underline;
        }

        .btn-login {
            width: 100%;
            padding: 12px;
            background-color: #21465b;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 1rem;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 20px;
        }

        .btn-login:hover {
            background-color: #1a3747;
            transform: translateY(-1px);
        }

        .divider {
            display: flex;
            align-items: center;
            text-align: center;
            margin: 20px 0;
            color: #6c757d;
        }

        .divider::before,
        .divider::after {
            content: '';
            flex: 1;
            border-bottom: 1px solid #dee2e6;
        }

        .divider span {
            padding: 0 10px;
            font-size: 0.9rem;
        }

        .btn-google {
            width: 100%;
            padding: 12px;
            background-color: white;
            border: 1px solid #dee2e6;
            border-radius: 8px;
            font-size: 0.9rem;
            color: #21465b;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }

        .btn-google:hover {
            background-color: #f8f9fa;
            transform: translateY(-1px);
        }

        .alert {
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-size: 0.9rem;
        }

        .alert-danger {
            background-color: #f8d7da;
            border: 1px solid #f5c6cb;
            color: #721c24;
        }

        .alert-success {
            background-color: #d4edda;
            border: 1px solid #c3e6cb;
            color: #155724;
        }

        .recaptcha-container {
            margin: 20px 0;
            padding: 10px;
            border: 1px solid #dee2e6;
            border-radius: 8px;
            background-color: #f8f9fa;
        }

        .recaptcha-container img {
            vertical-align: middle;
            margin-right: 10px;
        }

        .recaptcha-container span {
            font-size: 0.8rem;
            color: #6c757d;
        }

        @media (max-width: 768px) {
            .login-container {
                flex-direction: column;
            }
            
            .left-section {
                padding: 20px;
                text-align: center;
            }
            
            .right-section {
                padding: 20px;
            }
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="left-section">
            <h1>Bienvenido al Sistema Académico</h1>
            <p>Accede a tu cuenta para gestionar tus materias, calificaciones y más.</p>
        </div>
        <div class="right-section">
            <div class="login-form">
                <div class="form-header">
                    <h2>Iniciar Sesión</h2>
                    <p>Ingresa tus credenciales para continuar</p>
                </div>

                <form action="<c:url value='/login' />" method="post">
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger">
                            <i class="fas fa-exclamation-circle"></i> ${error}
                        </div>
                    </c:if>
                    <c:if test="${param.registered == 'true'}">
                        <div class="alert alert-success">
                            <i class="fas fa-check-circle"></i> ¡Registro exitoso! Por favor, inicia sesión con tus credenciales.
                        </div>
                    </c:if>

                    <div class="form-group">
                        <label for="correo">Correo electrónico</label>
                        <div class="input-wrapper">
                            <i class="fas fa-envelope"></i>
                            <input type="email" id="correo" name="correo" class="form-control" 
                                   placeholder="ejemplo@ufps.edu.co" required>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="contrasena">Contraseña</label>
                        <div class="input-wrapper">
                            <i class="fas fa-lock"></i>
                            <input type="password" id="contrasena" name="contrasena" class="form-control" 
                                   placeholder="Ingresa tu contraseña" required>
                        </div>
                        <a href="/forgot-password" class="forgot-password">¿Olvidaste tu contraseña?</a>
                    </div>

                    <div class="recaptcha-container">
                        <input type="checkbox" id="not-robot" required>
                        <label for="not-robot">No soy un robot</label>
                        <div style="margin-top: 10px;">
                            <img src="https://www.gstatic.com/recaptcha/api2/logo_48.png" alt="reCAPTCHA">
                            <span>reCAPTCHA</span>
                            <span>Privacy - Terms</span>
                        </div>
                    </div>

                    <button type="submit" class="btn-login">
                        <i class="fas fa-sign-in-alt"></i> Iniciar sesión
                    </button>
                </form>

                <div class="divider">
                    <span>o continúa con</span>
                </div>

                <button type="button" class="btn-google">
                    <img src="https://www.gstatic.com/firebasejs/ui/2.0.0/images/auth/google.svg" alt="Google" width="18">
                    Iniciar sesión con Google
                </button>
            </div>
        </div>
    </div>
</body>
</html>