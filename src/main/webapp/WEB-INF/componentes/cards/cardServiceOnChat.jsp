<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!-- Skeleton de card del servicio -->
<div id="skeleton-servicio" class="col-12 col-md-6 col-lg-5 placeholder-wave">
  <div class="card shadow h-100">
    <div class="skeleton-img-top"></div>
    <div class="card-body">
      <h5 class="placeholder col-8 mb-2" style="height: 20px;"></h5>
      <p class="placeholder col-12 mb-2" style="height: 14px;"></p>
      <p class="placeholder col-10 mb-3" style="height: 14px;"></p>
    </div>
    <div class="card-footer bg-transparent border-0">
      <div class="btn btn-primary disabled placeholder col-6" style="height: 35px;"></div>
    </div>
  </div>
</div>

<!-- Contenido real del servicio -->
<div id="contenido-servicio" class="col-12 col-md-6 col-lg-5 d-none">
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
      <a href="/servicio/detalles/${servicio.id}" class="btn btn-primary">
        Ver servicio
      </a>
    </div>
  </div>
</div>
