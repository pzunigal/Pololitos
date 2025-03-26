<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" %> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %>
<!DOCTYPE html>
<html lang="es">
  <head>
    <meta charset="UTF-8" />
    <title>Mostrar Usuario</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <!-- Bootstrap & Icons -->
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

    <main class="container my-5">
      <%@ include file="/WEB-INF/componentes/cards/cardProfile.jsp" %>
    </main>

    <%@ include file="/WEB-INF/componentes/layout/footer.jsp" %>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
      function confirmarEdicion() {
        Swal.fire({
          title: "¿Editar tu perfil?",
          text: "Serás redirigido al formulario de edición.",
          icon: "question",
          showCancelButton: true,
          confirmButtonColor: "#3085d6",
          cancelButtonColor: "#6c757d",
          confirmButtonText: "Sí, continuar",
          cancelButtonText: "Cancelar",
        }).then((result) => {
          if (result.isConfirmed) {
            window.location.href = "/editarPerfil";
          }
        });
      }
    </script>
  </body>
</html>
