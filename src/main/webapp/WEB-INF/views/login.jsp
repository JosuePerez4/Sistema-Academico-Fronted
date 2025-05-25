<%@ page contentType="text/html;charset=UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8" />
            <meta name="viewport" content="width=device-width, initial-scale=1.0" />
            <title>Iniciar sesión</title>
            <link rel="stylesheet" href="<c:url value='/css/login.css' />">
            <!-- Asegúrate de que el nombre del CSS coincida -->
        </head>

        <body>
            <div class="centered-container">
                <div class="rectangle-2">
                    <div class="paragraph-1-copy-2">
                        Iniciar sesión
                    </div>
                    <div class="ingresa-tu-c-digo-y-contrase-a-para-ver-tu-informa-1">
                        Ingresa tu código y contraseña para ver tu información.
                    </div>

                    <div class="form-group">
                        <label for="codigo" class="c-digo-1">Código</label>
                        <div class="input-wrapper">
                            <img src="/image/pin.png" class="icon-left" alt="pin">
                            <input type="text" id="codigo" class="text-input-2">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="contrasena" class="contrase-a-1">Contraseña</label>
                        <div class="input-wrapper">
                            <img src="/image/padlock.png" class="icon-left" alt="candado">
                            <input type="password" id="contrasena" class="text-input-3" placeholder="Contraseña">
                            <img src="/image/close-eye.png" class="icon-right" alt="ver contraseña"
                                onclick="togglePasswordVisibility()">
                        </div>
                        <a href="#" class="olvid-la-contrase-a-1">¿Olvidó la contraseña?</a>
                    </div>

                    <div class="reCAPTCHA-container">
                        <input type="checkbox" id="not-robot">
                        <label for="not-robot" class="reCAPTCHA-text">I'm not a robot</label>
                        <div class="reCAPTCHA-privacy">
                            <img src="https://www.gstatic.com/recaptcha/api2/logo_48.png" alt="reCAPTCHA">
                            <span>reCAPTCHA</span>
                            <span>Privacy - Terms</span>
                        </div>
                    </div>

                    <button class="button-14" onclick="">
                        Iniciar sesión
                    </button>

                    <div class="separator">
                        <span class="rectangle-1">o</span>
                    </div>

                    <button class="button-17">
                        <span class="google-icon"></span>
                        Sign in with Google
                    </button>
                </div>
            </div>
        </body>

        </html>