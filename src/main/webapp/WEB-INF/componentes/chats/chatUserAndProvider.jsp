<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!-- Skeleton del contenedor del chat -->
<div id="skeleton-chat" class="col-12 col-md-6 col-lg-5 placeholder-wave">
  <div class="card shadow bg-dark d-flex flex-column h-100">
    <div class="card-header d-flex align-items-center text-white gap-3">
      <div class="skeleton-avatar rounded-circle"></div>
      <div class="w-100">
        <div class="placeholder col-6" style="height: 14px;"></div>
        <div class="placeholder col-4 mt-2" style="height: 12px;"></div>
      </div>
    </div>
    <div class="card-body p-3 overflow-auto chat-box-bg">
      <div class="skeleton-message received mb-2"></div>
      <div class="skeleton-message sent mb-2"></div>
      <div class="skeleton-message received mb-2"></div>
      <div class="skeleton-message sent mb-2"></div>
    </div>
    <div class="card-footer p-3">
      <div class="d-flex gap-2 align-items-center">
        <div class="placeholder flex-grow-1 rounded-pill" style="height: 38px;"></div>
        <div class="placeholder rounded-circle" style="width: 38px; height: 38px;"></div>
      </div>
    </div>
  </div>
</div>

<!-- Contenido real del chat -->
<div id="contenido-chat" class="col-12 col-md-6 col-lg-5 d-none">
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
      <div id="chat-skeleton">
        <div class="skeleton-message received mb-2"></div>
        <div class="skeleton-message sent mb-2"></div>
        <div class="skeleton-message received mb-2"></div>
        <div class="skeleton-message sent mb-2"></div>
      </div>
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
