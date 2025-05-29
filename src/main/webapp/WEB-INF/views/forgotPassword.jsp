<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <title>Olvidó su contraseña</title>
            <link rel="stylesheet" href="<c:url value='/css/forgotPassword.css' />" />
        </head>

        <body>
            <div class="centered-container">
                <div class="rectangle-5">
                    <div class="paragraph-1-copy-4">Olvidó su contraseña?</div>
                    <div class="ingresa-el-correo-con-el-que-est-s-registrado-y-te">
                        Ingresa el correo con el que estás registrado y te enviaremos un link de recuperación.
                    </div>
                    <form method="post" action="/forgot-password">
                        <div class="correo-electr-nico">Correo electrónico</div>

                        <div class="input-container">
                            <img class="mail-icon-3" src="https://cdn-icons-png.flaticon.com/512/561/561127.png"
                                alt="mail icon">
                            <input class="text-input-6" type="email" name="correo" placeholder="ejemplo@ufps.edu.co"
                                required>
                        </div>
                        <button class="button-16" type="submit">Reiniciar contraseña</button>
                    </form>
                    <a href="/login" class="volver-al-inicio-de-sesi-n-">Volver al inicio de sesión.</a>
                </div>
            </div>
        </body>

        </html>