<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Chat</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" />
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet" />
  <link href="https://fonts.googleapis.com/css2?family=Quicksand&display=swap" rel="stylesheet" />
  <link rel="stylesheet" href="<c:url value='/css/views/chat.css' />" />
</head>
<body class="body-without-bg">
  <%@ include file="/WEB-INF/componentes/layout/nav.jsp" %>

  <main class="my-4">
    <div class="container">
      <div class="row justify-content-center g-4">
        
        <!-- Servicio -->
        <div class="col-12 col-md-6 col-lg-5">
          <div class="card shadow h-100">
            <img
              src="${empty servicio.imgUrl ? '/img/work.jpg' : servicio.imgUrl}"
              alt="Imagen del servicio"
              class="card-img-top"
            />
            <div class="card-body">
              <h5 class="card-title">${servicio.nombre}</h5>
              <p class="card-text">
                ${fn:length(servicio.descripcion) > 200 ?
                fn:substring(servicio.descripcion, 0, 200) + "..." :
                servicio.descripcion}
              </p>
            </div>
            <div class="card-footer bg-transparent border-0">
              <a href="/servicios/ver/${servicio.id}" class="btn btn-primary">
                Ver servicio
              </a>
            </div>
          </div>
        </div>

        <!-- Chat -->
        <div class="col-12 col-md-6 col-lg-5">
          <div class="card shadow bg-dark d-flex flex-column h-100">
            <div class="card-header d-flex align-items-center text-white">
              <img
                src="${empty otroUsuario.fotoPerfil ? '/img/user.png' : otroUsuario.fotoPerfil}"
                alt="${otroUsuario.nombre} ${otroUsuario.apellido}"
                class="rounded-circle me-2"
                style="width: 40px; height: 40px"
              />
              <div>
                <h6 class="mb-0">${otroUsuario.nombre} ${otroUsuario.apellido}</h6>
                <small>${rolDescripcion}</small>
              </div>
            </div>

            <div class="card-body flex-grow-1 p-3 overflow-auto chat-box-bg" id="chat-box" style="min-height: 200px; max-height: 400px">
              <!-- Mensajes se insertan aquí con JS -->
            </div>

            <div class="card-footer p-0">
              <form class="d-flex align-items-center gap-2" id="mensaje-form">
                <input type="hidden" id="chatId" value="${chatId}" />
                <input type="hidden" id="usuarioId" value="${sessionScope.usuarioEnSesion.id}" />
                <input type="hidden" id="nombreUsuario" value="${sessionScope.usuarioEnSesion.nombre} ${sessionScope.usuarioEnSesion.apellido}" />

                <textarea class="form-control" id="mensaje-input" rows="1" placeholder="Escribe un mensaje..."></textarea>

                <button type="submit" class="btn btn-success">
                  <i class="fas fa-paper-plane"></i>
                </button>
              </form>
            </div>
          </div>
        </div>

      </div>
    </div>
  </main>

  <div class="text-center mt-4">
    <button class="btn btn-secondary" onclick="volverAtrasRecargando()">
      <i class="fa-solid fa-arrow-left"></i> Volver
    </button>
  </div>

  <script src="https://www.gstatic.com/firebasejs/9.6.1/firebase-app-compat.js"></script>
  <script src="https://www.gstatic.com/firebasejs/9.6.1/firebase-database-compat.js"></script>
  <script src="<c:url value='/js/chatScript.js' />"></script>
</body>
</html>
