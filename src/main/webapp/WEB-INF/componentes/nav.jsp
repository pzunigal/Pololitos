<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark px-4">
  <a class="navbar-brand" href="/">
    <img src="<c:url value='/img/pololitosBlanco.png' />" alt="Logo pololitos" height="40">
  </a>
  <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarNav">
    <ul class="navbar-nav me-auto mb-2 mb-lg-0">
      <li class="nav-item"><a class="nav-link" href="/servicios">Servicios</a></li>
      <c:if test="${not empty sessionScope.usuarioEnSesion}">
        <li class="nav-item"><a class="nav-link" href="/mis-servicios">Mis Servicios</a></li>
        <li class="nav-item"><a class="nav-link" href="/mis-solicitudes-enviadas">Enviadas</a></li>
        <li class="nav-item"><a class="nav-link" href="/mis-solicitudes-recibidas">Recibidas</a></li>
      </c:if>
    </ul>

    <c:if test="${not empty sessionScope.usuarioEnSesion}">
      <div class="dropdown me-3">
        <button class="btn btn-outline-light position-relative" id="notificacionesDropdown" data-bs-toggle="dropdown" aria-expanded="false">
          <i class="bi bi-bell-fill"></i>
          <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger" id="notificacionBadge" style="display:none;">
            0
          </span>
        </button>
        <ul class="dropdown-menu dropdown-menu-end text-light bg-dark" aria-labelledby="notificacionesDropdown" style="width: 300px; max-height: 400px; overflow-y: auto;" id="notificacionesLista">
          <li class="dropdown-item text-muted">Cargando notificaciones...</li>
        </ul>
      </div>
    </c:if>

    <form class="d-flex me-3" action="/buscar-servicios" method="get">
      <input class="form-control me-2" type="search" name="query" placeholder="Buscar">
      <button class="btn btn-outline-light" type="submit"><i class="bi bi-search"></i></button>
    </form>

    <c:choose>
      <c:when test="${not empty sessionScope.usuarioEnSesion}">
        <a href="/perfilUsuario" class="me-3">
          <img src="${sessionScope.usuarioEnSesion.fotoPerfil}" alt="Perfil" width="40" height="40" class="rounded-circle">
        </a>
        <a href="/servicios/publicar" class="btn btn-success me-2">Crear Servicio</a>
        <a href="/logout" class="btn btn-danger">Cerrar Sesión</a>
      </c:when>
      <c:otherwise>
        <a href="/login" class="btn btn-outline-light me-2">Iniciar sesión</a>
        <a href="/registro" class="btn btn-outline-info">Regístrate</a>
      </c:otherwise>
    </c:choose>
  </div>
</nav>

<!-- Firebase + Notificaciones -->
<script src="https://www.gstatic.com/firebasejs/9.6.1/firebase-app-compat.js"></script>
<script src="https://www.gstatic.com/firebasejs/9.6.1/firebase-database-compat.js"></script>
<script>
  const firebaseConfig = {
    apiKey: "",
    authDomain: "pololitos-a96fb.firebaseapp.com",
    databaseURL: "https://pololitos-a96fb-default-rtdb.firebaseio.com",
    projectId: "pololitos-a96fb",
    storageBucket: "pololitos-a96fb.appspot.com",
    messagingSenderId: "",
    appId: ""
  };
  firebase.initializeApp(firebaseConfig);
  const db = firebase.database();

  const usuarioId = "${sessionScope.usuarioEnSesion.id}";
  const badge = document.getElementById("notificacionBadge");
  const lista = document.getElementById("notificacionesLista");

  function renderNotificaciones(data) {
    lista.innerHTML = "";
    let contador = 0;

    for (const id in data) {
  const n = data[id];
  if (!n.leida) contador++;

  const li = document.createElement("li");
  li.className = "dropdown-item text-white" + (!n.leida ? " fw-bold" : "");
  li.style.cursor = "pointer";
  li.textContent = n.mensaje;
  li.onclick = () => {
    db.ref(`notificaciones/${usuarioId}/${id}/leida`).set(true).then(() => {
      window.location.href = n.urlDestino;
    });
  };
  lista.appendChild(li);
}


    if (contador > 0) {
      badge.style.display = "inline-block";
      badge.textContent = contador;
    } else {
      badge.style.display = "none";
    }

    if (lista.children.length === 0) {
      lista.innerHTML = "<li class='dropdown-item text-muted'>No hay notificaciones</li>";
    }
  }

  if (usuarioId && lista) {
    const ref = db.ref(`notificaciones/${usuarioId}`);
    ref.on("value", (snapshot) => {
      const data = snapshot.val() || {};
      renderNotificaciones(data);
    });
  }
</script>
