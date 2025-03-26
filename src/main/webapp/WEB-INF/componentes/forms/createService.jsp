<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<form:form
  modelAttribute="servicio"
  action="/publicar"
  method="POST"
  enctype="multipart/form-data"
>
  <div class="mb-3">
    <label for="nombre" class="form-label">Nombre del Servicio:</label>
    <form:input path="nombre" class="form-control" required="true" />
    <form:errors path="nombre" class="text-danger" />
  </div>

  <div class="mb-3">
    <label for="descripcion" class="form-label">Descripción:</label>
    <form:textarea
      path="descripcion"
      class="form-control"
      rows="4"
      required="true"
    />
    <form:errors path="descripcion" class="text-danger" />
  </div>

  <div class="mb-3">
    <label for="precio" class="form-label">Precio:</label>
    <form:input
      path="precio"
      type="number"
      step="0.01"
      class="form-control"
      required="true"
    />
    <form:errors path="precio" class="text-danger" />
  </div>

  <div class="mb-3">
    <label for="ciudad" class="form-label">Ciudad:</label>
    <form:input path="ciudad" class="form-control" />
    <form:errors path="ciudad" class="text-danger" />
  </div>

  <div class="mb-3">
    <label for="file" class="form-label">Foto del Servicio:</label>
    <input
      type="file"
      name="file"
      id="fileInput"
      class="form-control"
      accept="image/*"
      required
    />
    <div class="mt-3 text-center">
      <img
        id="previewImage"
        class="img-thumbnail"
        style="max-width: 300px; display: none"
        alt="Vista previa"
      />
    </div>
  </div>

  <div class="mb-4">
    <label for="categoria" class="form-label">Categoría:</label>
    <form:select path="categoria.id" class="form-control" required="true">
      <form:option value="" label="Seleccione una categoría" />
      <c:forEach var="categoria" items="${categorias}">
        <form:option value="${categoria.id}" label="${categoria.nombre}" />
      </c:forEach>
    </form:select>
    <form:errors path="categoria" class="text-danger" />
  </div>

  <div class="text-center">
    <button type="submit" class="btn btn-success btn-lg px-5">
      <i class="bi bi-cloud-upload"></i> Publicar Servicio
    </button>
  </div>
</form:form>
