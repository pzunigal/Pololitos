<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %>
<!DOCTYPE html>
<html lang="es">
  <head>
    <meta charset="UTF-8" />
    <title>Nosotros</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
      rel="stylesheet"
    />
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css"
      rel="stylesheet"
    />
    <link
      href="https://fonts.googleapis.com/css2?family=Quicksand&display=swap"
      rel="stylesheet"
    />
    <link rel="stylesheet" href="<c:url value='/css/global.css' />" />
  </head>
  <body class="body-without-bg">
    <%@ include file="/WEB-INF/componentes/layout/nav.jsp" %>

    <main class="container text-center">
      <h1 class="mb-4">¿Quiénes somos?</h1>
      <p class="lead">
        Somos una empresa que busca conectar a personas que necesitan ayuda con
        tareas y profesionales dispuestos a ayudar. <br />
        Facilitamos el día a día de nuestros usuarios promoviendo la
        colaboración y eficiencia.
      </p>

      <a href="/servicios" class="btn btn-outline-light mt-4">
        <i class="bi bi-arrow-left"></i> Volver a Servicios
      </a>
    </main>

    <%@ include file="/WEB-INF/componentes/layout/footer.jsp" %>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  </body>
</html>
