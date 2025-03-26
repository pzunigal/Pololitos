<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> <%@
taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%@ taglib
uri="http://www.springframework.org/tags/form" prefix="form" %>

<!DOCTYPE html>
<html lang="es">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Publicar Servicio</title>

    <!-- Fuentes personalizadas -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Noto+Sans:ital,wght@0,100..900;1,100..900&family=Quicksand:wght@300..700&family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&family=Winky+Sans:ital,wght@0,300..900;1,300..900&display=swap"
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
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <link rel="stylesheet" href="<c:url value='/css/global.css' />" />
  </head>

  <body class="d-flex flex-column body-with-bg">
    <!-- Navbar -->
    <%@ include file="/WEB-INF/componentes/layout/nav.jsp" %>

    <!-- Contenido principal -->
    <main class="container my-5">
      <div class="bg-dark text-white p-5 rounded shadow col-xxl-6">
        <h1 class="mb-4 text-center">Publicar nuevo servicio</h1>

        <c:if test="${not empty error}">
          <div class="alert alert-danger text-center">${error}</div>
        </c:if>

        <%@ include file="/WEB-INF/componentes/forms/createService.jsp" %>
      </div>
    </main>

    <!-- Footer -->
    <%@ include file="/WEB-INF/componentes/layout/footer.jsp" %>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
      const fileInput = document.getElementById("fileInput");
      const previewImage = document.getElementById("previewImage");

      fileInput.addEventListener("change", function () {
        const file = this.files[0];
        if (file) {
          const reader = new FileReader();
          reader.onload = function (e) {
            previewImage.src = e.target.result;
            previewImage.style.display = "block";
          };
          reader.readAsDataURL(file);
        } else {
          previewImage.style.display = "none";
          previewImage.src = "";
        }
      });
    </script>
  </body>
</html>
