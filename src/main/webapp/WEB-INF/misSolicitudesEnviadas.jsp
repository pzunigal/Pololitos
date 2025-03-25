<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" %> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %> <%@ taglib uri="http://java.sun.com/jsp/jstl/functions"
prefix="fn" %> <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="es">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Mis Solicitudes Enviadas</title>

    <!-- Bootstrap -->
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
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <link rel="stylesheet" href="<c:url value='/css/global.css' />" />

  </head>

  <body class="body-without-bg">
    <!-- Navbar -->
    <%@ include file="/WEB-INF/componentes/layout/nav.jsp" %>

    <!-- Contenido -->
    <main class="container py-5">
      <h2 class="mb-4 text-center">Mis Solicitudes Enviadas</h2>

      <!-- ACTIVAS -->
      <c:if test="${not empty error}">
        <div class="alert alert-danger text-center" role="alert">${error}</div>
      </c:if>

      <c:if test="${not empty solicitudesActivas}">
        <%@ include file="/WEB-INF/componentes/grids/activeRequestsSent.jsp"
        %>
      </c:if>

      <!-- INACTIVAS -->

      <c:if test="${not empty solicitudesInactivas}">
        <%@ include
        file="/WEB-INF/componentes/grids/inactiveRequestsSent.jsp" %>
      </c:if>
      <c:if test="${empty solicitudesActivas and empty solicitudesInactivas}">
        <div class="alert alert-info text-center">
          Aún no has enviado ninguna solicitud.
        </div>
      </c:if>
    </main>

    <!-- Footer -->
    <%@ include file="/WEB-INF/componentes/layout/footer.jsp" %>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <script>
      function chatNoDisponible() {
        Swal.fire({
          icon: "info",
          title: "Chat no disponible",
          text: "El proveedor debe iniciar la conversación primero.",
          confirmButtonColor: "#3085d6",
        });
      }

      // Confirmar cancelar solicitud
      document.querySelectorAll(".btn-cancelar").forEach((btn) => {
        btn.addEventListener("click", () => {
          const id = btn.dataset.id;

          Swal.fire({
            title: "¿Estás seguro?",
            text: "Esta acción cancelará tu solicitud y no podrá ser revertida.",
            icon: "warning",
            showCancelButton: true,
            confirmButtonColor: "#d33",
            cancelButtonColor: "#aaa",
            confirmButtonText: "Sí, cancelar",
            cancelButtonText: "No",
          }).then((result) => {
            if (result.isConfirmed) {
              const form = document.createElement("form");
              form.method = "POST";
              form.action = "/cancelar-solicitud";

              const input = document.createElement("input");
              input.type = "hidden";
              input.name = "solicitudId";
              input.value = id;
              form.appendChild(input);

              document.body.appendChild(form);
              form.submit();
            }
          });
        });
      });
    </script>
  </body>
</html>
