<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" %> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %> <%@ taglib uri="http://java.sun.com/jsp/jstl/functions"
prefix="fn" %>

<!DOCTYPE html>
<html lang="es">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Mis Solicitudes Recibidas</title>
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

    <main class="container py-5">
      <h2 class="mb-4 text-center">Mis Solicitudes Recibidas</h2>

      <c:if test="${not empty error}">
        <div class="alert alert-danger text-center">${error}</div>
      </c:if>

      <!-- ACTIVAS -->
      <%@ include file="/WEB-INF/componentes/grids/activeRequestsReceived.jsp" %>
      

      <!-- INACTIVAS -->
      <%@ include file="/WEB-INF/componentes/grids/inactiveRequestsReceived.jsp" %>
      
    </main>

    <!-- Footer -->
    <%@ include file="/WEB-INF/componentes/layout/footer.jsp" %>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <script>
      document.addEventListener("DOMContentLoaded", function () {
        // Chat no disponible
        window.chatNoDisponible = function () {
          Swal.fire({
            icon: "info",
            title: "Chat no disponible",
            text: "El proveedor debe iniciar la conversación primero.",
            confirmButtonColor: "#3085d6",
          });
        };

        // Confirmar ACEPTAR solicitud
        document.querySelectorAll(".btn-aceptar").forEach((btn) => {
          btn.addEventListener("click", () => {
            const id = btn.dataset.id;

            Swal.fire({
              title: "¿Estás seguro que deseas aceptar esta solicitud?",
              icon: "question",
              showCancelButton: true,
              confirmButtonText: "Sí, aceptar",
              cancelButtonText: "Cancelar",
              confirmButtonColor: "#28a745",
              cancelButtonColor: "#aaa",
            }).then((result) => {
              if (result.isConfirmed) {
                const form = document.createElement("form");
                form.method = "POST";
                form.action = "/aceptar-solicitud";

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

        // Confirmar RECHAZAR solicitud
        document.querySelectorAll(".btn-rechazar").forEach((btn) => {
          btn.addEventListener("click", () => {
            const id = btn.dataset.id;

            Swal.fire({
              title: "¿Estás seguro que deseas rechazar esta solicitud?",
              icon: "warning",
              showCancelButton: true,
              confirmButtonText: "Sí, rechazar",
              cancelButtonText: "Cancelar",
              confirmButtonColor: "#d33",
              cancelButtonColor: "#aaa",
            }).then((result) => {
              if (result.isConfirmed) {
                const form = document.createElement("form");
                form.method = "POST";
                form.action = "/rechazar-solicitud";

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

        // Confirmar TRABAJO COMPLETADO
        document.querySelectorAll(".btn-completar").forEach((btn) => {
          btn.addEventListener("click", () => {
            const id = btn.dataset.id;

            Swal.fire({
              title: "¿Deseas marcar esta solicitud como trabajo completado?",
              text: "Esta acción confirmará que el servicio fue realizado.",
              icon: "success",
              showCancelButton: true,
              confirmButtonText: "Sí, marcar como completado",
              cancelButtonText: "Cancelar",
              confirmButtonColor: "#198754",
              cancelButtonColor: "#aaa",
            }).then((result) => {
              if (result.isConfirmed) {
                const form = document.createElement("form");
                form.method = "POST";
                form.action = "/completar-solicitud";

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
      });
    </script>
  </body>
</html>
