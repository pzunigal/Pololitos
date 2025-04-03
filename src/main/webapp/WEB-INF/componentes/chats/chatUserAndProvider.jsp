<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
      <!-- Skeleton inicial -->
      <div id="chat-skeleton">
        <div class="skeleton-message received mb-2"></div>
        <div class="skeleton-message sent mb-2"></div>
        <div class="skeleton-message received mb-2"></div>
        <div class="skeleton-message sent mb-2"></div>
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
