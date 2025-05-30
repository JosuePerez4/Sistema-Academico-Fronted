<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="es">

        <head>
            <meta charset="UTF-8">
            <title>Restablecer Contraseña</title>
            <link
                href="https://fonts.googleapis.com/css2?family=Montserrat:wght@800&family=Source+Sans+3:wght@400;500;600&display=swap"
                rel="stylesheet">
            <link rel="stylesheet" href="<c:url value='/css/resetPassword.css' />">
        </head>

        <body>
            <div class="centered-container">
                <div class="rectangle-7">
                    <form action="<c:url value='/reset-password' />" method="post">
                        <div class="paragraph-1-copy-6">Nueva contraseña</div>
                        <div class="su-nueva-contrase-a-debe-ser-diferente-de-la-utili">
                            Su nueva contraseña debe ser diferente de la utilizada anteriormente, y debe tener al menos
                            8
                            caracteres.
                        </div>

                        <c:if test="${not empty error}">
                            <div class="error-message">${error}</div>
                        </c:if>

                        <div class="nueva-contrase-a">Nueva contraseña</div>
                        <div class="input-container">
                            <div class="input-wrapper">
                                <img src="<c:url value='/image/padlock.png' />" class="lock-icon-4" alt="lock">
                                <input type="password" name="newPassword" class="text-input-7"
                                    placeholder="Nueva contraseña" required minlength="8">
                                <img src="<c:url value='/image/close-eye.png' />" class="eye-icon-3" alt="toggle password">
                            </div>
                        </div>

                        <div class="confirmar-contrase-a">Confirmar contraseña</div>
                        <div class="input-container">
                            <div class="input-wrapper">
                                <img src="<c:url value='/image/padlock.png' />" class="lock-icon-5" alt="lock">
                                <input type="password" name="confirmPassword" class="text-input-8"
                                    placeholder="Confirmar contraseña" required minlength="8">
                                <img src="<c:url value='/image/close-eye.png' />" class="eye-icon-4" alt="toggle password">
                            </div>
                        </div>

                        <!-- Aquí puedes agregar un campo oculto si necesitas enviar, por ejemplo, el token -->
                        <input type="hidden" name="token" value="${token}">

                        <button type="submit" class="button-20">Reiniciar contraseña</button>
                    </form>

                    <a href="<c:url value='/login' />" class="volver-al-inicio-de-sesi-n-">Volver a inicio de sesión</a>
                </div>
            </div>
        </body>

        </html>