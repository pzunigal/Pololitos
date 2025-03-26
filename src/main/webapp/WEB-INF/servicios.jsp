<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" %> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %> <%@ taglib uri="http://java.sun.com/jsp/jstl/functions"
prefix="fn" %> <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="es">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Servicios</title>

    <!-- Fuentes -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Noto+Sans&family=Quicksand&family=Roboto&display=swap"
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

  <body class="d-flex flex-column body-without-bg">
    <!-- Navbar -->
    <%@ include file="/WEB-INF/componentes/layout/nav.jsp" %>

    <main class="container py-5">
      <!-- Botón para abrir filtros -->
      <div class="d-flex justify-content-start mb-4">
        <button
          class="btn btn-outline-light"
          type="button"
          data-bs-toggle="offcanvas"
          data-bs-target="#offcanvasFiltro"
        >
          <i class="bi bi-funnel"></i> Filtros
        </button>
      </div>

      <!-- Offcanvas lateral -->
      <%@ include file="/WEB-INF/componentes/offcanvas/serviceFilter.jsp" %>

      <h1 class="text-center mb-4">Servicios por Categoría</h1>
      <!-- carrusel para los servicios por categoria -->
      <%@ include file="/WEB-INF/componentes/carrusel/carruselService.jsp" %>
    </main>

    <!-- Footer -->
    <%@ include file="/WEB-INF/componentes/layout/footer.jsp" %>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
      function openModal(nombreVendedor, nombreServicio) {
        alert(
          `Simulación de contacto con ${nombreVendedor} para el servicio: ${nombreServicio}`
        );
      }

      function updateSliderLabels() {
        const min = document.getElementById("precioMinSlider").value;
        const max = document.getElementById("precioMaxSlider").value;
        document.getElementById("minValueLabel").textContent = formatCLP(min);
        document.getElementById("maxValueLabel").textContent = formatCLP(max);
      }

      function formatCLP(value) {
        return Number(value).toLocaleString("es-CL");
      }

      updateSliderLabels();

      // Scroll horizontal solo si no estamos en los extremos
      document.querySelectorAll(".servicio-carrusel").forEach((carrusel) => {
        carrusel.addEventListener(
          "wheel",
          function (e) {
            const delta = e.deltaY;
            const atStart = carrusel.scrollLeft === 0;
            const atEnd =
              carrusel.scrollLeft + carrusel.clientWidth >=
              carrusel.scrollWidth - 1;

            // Si NO estamos en el inicio o fin, prevenir scroll vertical
            if ((delta < 0 && !atStart) || (delta > 0 && !atEnd)) {
              e.preventDefault();
              carrusel.scrollBy({
                left: delta < 0 ? -300 : 300,
                behavior: "smooth",
              });
            }
            // Si estamos al inicio o al final, dejamos pasar el scroll vertical
            // automáticamente (no hacemos nada).
          },
          { passive: false }
        );
      });
    </script>
  </body>
</html>
