<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<div class="chat-container">
  <div class="header-chat">
    <img src="/img/user.png" alt="" />
    <div class="info-user">
      <h2>Nombre</h2>
      <p>Servicio que ofrece</p>
    </div>
  </div>

  <div class="chat-box" id="chat-box"></div>

  <form class="mensaje-form" id="mensaje-form">
    <input type="hidden" id="chatId" value="${chatId}" />
    <input
      type="hidden"
      id="usuarioId"
      value="${sessionScope.usuarioEnSesion.id}"
    />
    <input
      type="hidden"
      id="nombreUsuario"
      value="${sessionScope.usuarioEnSesion.nombre}"
    />

    <textarea
      class="form-control"
      id="mensaje-input"
      rows="1"
      placeholder="Escribe un mensaje..."
    ></textarea>

    <button type="submit" class="enviar-btn">
      <i class="fas fa-paper-plane"></i>
    </button>
  </form>
</div>
