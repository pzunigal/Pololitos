<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="form"
uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="es">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Iniciar Sesión</title>

    <!-- Fuentes -->
    <link
      href="https://fonts.googleapis.com/css2?family=Quicksand&display=swap"
      rel="stylesheet"
    />
    <!-- Bootstrap & Icons -->
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
      rel="stylesheet"
    />
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css"
      rel="stylesheet"
    />
    <link rel="stylesheet" href="<c:url value='/css/global.css' />" />
  </head>
  <body class="body-with-bg">
    <!-- Navbar Bootstrap -->
    <%@ include file="/WEB-INF/componentes/layout/nav.jsp" %>
    <!-- Login Form -->
    <div class="login-wrapper container mb-3">
      <div class="row w-100">
        <div class="col-lg-6 d-flex align-items-center justify-content-center">
          <img
            src="/img/pololitos.png"
            alt="Logo pololitos"
            class="img-logo"
            style="max-width: 400px"
          />
        </div>
        <div class="col-lg-6">
          <div class="login-container">
            <h2 class="text-center mb-4">Iniciar Sesión</h2>
            <!-- Formulario Login -->
            <%@ include file="/WEB-INF/componentes/forms/loginForm.jsp" %>

            <button class="btn btn-google">
              <img
                src="https://res.cloudinary.com/dwz4chwv7/image/upload/v1742869751/google_yqrlgh.png"
                alt="Google Logo"
              />
              Acceder con Google
            </button>
            <p class="text-center mt-3">
              ¿No tienes una cuenta?
              <a href="/registro" class="text-warning">Regístrate</a>
            </p>
          </div>
        </div>
      </div>
    </div>

    <!-- Footer -->
    <%@ include file="/WEB-INF/componentes/layout/footer.jsp" %>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  </body>
</html>
