<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
        <a href="/servicio/detalles/${servicio.id}" class="btn btn-primary">
          Ver servicio
        </a>
      </div>
    </div>
  </div>