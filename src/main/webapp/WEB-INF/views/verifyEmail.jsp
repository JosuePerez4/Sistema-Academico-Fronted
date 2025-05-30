<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html>

        <head>
            <title>Verifica tu correo</title>
            <meta charset="UTF-8">
            <link rel="stylesheet" href="<c:url value='/css/verifyEmail.css' />" />
        </head>

        <body>
            <div class="centered-container">
                <div class="rectangle-6">
                    <div class="paragraph-1-copy-5">
                        Verifica tu correo
                    </div>

                    <div class="hemos-enviado-instrucciones-para-recuperar-la-cont">
                        Hemos enviado instrucciones para recuperar la contraseña a su dirección de correo electrónico.
                    </div>

                    <div class="-no-has-recibido-el-mensaje-comprueba-tu-carpeta-">
                        ¿No has recibido el mensaje? Comprueba tu carpeta de spam o intenta
                        <a href="#">reenviar el mensaje</a>.
                    </div>

                    <a href="/login" class="button-19">Volver a inicio de sesión</a>
                </div>
            </div>
        </body>

        </html>