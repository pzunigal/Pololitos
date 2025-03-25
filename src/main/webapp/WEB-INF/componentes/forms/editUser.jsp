<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<form
  method="post"
  action="/actualizarPerfil"
  enctype="multipart/form-data"
  onsubmit="return confirmarActualizacion(event)"
>
  <input type="hidden" name="_method" value="PATCH" />

  <div class="mb-3">
    <label for="nombre" class="form-label">Nombre</label>
    <input
      type="text"
      class="form-control"
      name="nombre"
      value="${usuario.nombre}"
      required
    />
  </div>

  <div class="mb-3">
    <label for="apellido" class="form-label">Apellido</label>
    <input
      type="text"
      class="form-control"
      name="apellido"
      value="${usuario.apellido}"
      required
    />
  </div>

  <div class="mb-3">
    <label for="ciudad" class="form-label">Ciudad</label>
    <input
      type="text"
      class="form-control"
      name="ciudad"
      value="${usuario.ciudad}"
      required
    />
  </div>

  <div class="mb-3">
    <label for="telefono" class="form-label">Teléfono</label>
    <input
      type="text"
      class="form-control"
      name="telefono"
      value="${usuario.telefono}"
      required
    />
  </div>

  <div class="mb-3">
    <label class="form-label">Imagen actual</label><br />
    <img
      src="${usuario.fotoPerfil}"
      alt="Imagen actual"
      class="img-thumbnail"
      style="max-width: 200px"
    />
  </div>

  <div class="mb-3">
    <label for="fotoPerfilArchivo" class="form-label"
      >Nueva imagen (opcional)</label
    >
    <input
      type="file"
      class="form-control"
      id="fotoPerfilArchivo"
      name="fotoPerfilArchivo"
      accept="image/*"
    />
    <img
      id="preview"
      class="img-thumbnail mt-2"
      style="display: none; max-width: 200px"
    />
  </div>

  <button type="submit" class="btn btn-primary w-100">Guardar Cambios</button>
</form>
