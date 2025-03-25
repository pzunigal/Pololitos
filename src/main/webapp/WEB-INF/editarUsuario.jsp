<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" %> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %>
<!DOCTYPE html>
<html lang="es">
  <head>
    <meta charset="UTF-8" />
    <title>Editar Usuario</title>
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

  <body>
    <!-- Navbar -->
    <%@ include file="/WEB-INF/componentes/layout/nav.jsp" %>

    <!-- Contenido -->
    <main class="container my-5">
      <div class="row justify-content-center">
        <div class="col-md-8">
          <div class="card bg-dark border-light p-4">
            <h2 class="text-center text-white mb-4">Editar Perfil</h2>
            <%@ include file="/WEB-INF/componentes/forms/editUser.jsp" %>
          </div>
        </div>
      </div>
    </main>

    <%@ include file="/WEB-INF/componentes/layout/footer.jsp" %>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
      document
        .getElementById("fotoPerfilArchivo")
        .addEventListener("change", function (event) {
          const preview = document.getElementById("preview");
          const file = event.target.files[0];
          if (file) {
            const reader = new FileReader();
            reader.onload = function (e) {
              preview.src = e.target.result;
              preview.style.display = "block";
            };
            reader.readAsDataURL(file);
          } else {
            preview.style.display = "none";
          }
        });

      function confirmarActualizacion(e) {
        e.preventDefault();
        Swal.fire({
          title: "¿Guardar cambios?",
          text: "Tu perfil será actualizado con la nueva información.",
          icon: "warning",
          showCancelButton: true,
          confirmButtonColor: "#3085d6",
          cancelButtonColor: "#6c757d",
          confirmButtonText: "Sí, actualizar",
          cancelButtonText: "Cancelar",
        }).then((result) => {
          if (result.isConfirmed) {
            e.target.submit();
          }
        });
        return false;
      }
    </script>
  </body>
</html>
