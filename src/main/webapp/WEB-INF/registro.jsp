<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="es">
<head>
   <meta charset="UTF-8">
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <title>Registro</title>

   <!-- Fuentes -->
   <link href="https://fonts.googleapis.com/css2?family=Quicksand&display=swap" rel="stylesheet">
   <!-- Bootstrap & Icons -->
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
   <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
   <link rel="stylesheet" href="<c:url value='/css/global.css' />" />
</head>
<body class="body-with-bg">

<!-- Navbar -->
<%@ include file="/WEB-INF/componentes/layout/nav.jsp" %>

<!-- Registro -->
<div class="registro-wrapper container">
   <div class="registro-container mb-3">
      <h2 class="text-center mb-4">Crear Cuenta</h2>
      <%@ include file="/WEB-INF/componentes/forms/registerForm.jsp" %>
      
      <button class="btn btn-google">
         <img src="https://res.cloudinary.com/dwz4chwv7/image/upload/v1742869751/google_yqrlgh.png" alt="Google Logo">
         Registrarse con Google
      </button>
      <p class="text-center mt-3">¿Ya tienes una cuenta? <a href="/login" class="text-warning">Acceder</a></p>
   </div>
</div>

<!-- Footer -->
<%@ include file="/WEB-INF/componentes/layout/footer.jsp" %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
   document.getElementById('fotoPerfil').addEventListener('change', function (event) {
      const preview = document.getElementById('preview');
      const file = event.target.files[0];
      if (file) {
         const reader = new FileReader();
         reader.onload = function (e) {
            preview.src = e.target.result;
            preview.style.display = 'block';
         };
         reader.readAsDataURL(file);
      } else {
         preview.style.display = 'none';
      }
   });
</script>
</body>
</html>
