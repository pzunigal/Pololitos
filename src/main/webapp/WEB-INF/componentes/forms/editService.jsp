<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<form action="/actualizar-servicio/${servicio.id}" method="post" enctype="multipart/form-data">
    <input type="hidden" name="_method" value="PATCH">

    <div class="mb-3">
       <label for="nombre" class="form-label">Nombre</label>
       <input type="text" class="form-control" id="nombre" name="nombre" value="${servicio.nombre}" required>
    </div>

    <div class="mb-3">
       <label for="descripcion" class="form-label">Descripción</label>
       <textarea class="form-control" id="descripcion" name="descripcion" rows="4" required>${servicio.descripcion}</textarea>
    </div>

    <div class="mb-3">
       <label for="precio" class="form-label">Precio</label>
       <input type="number" class="form-control" id="precio" name="precio" value="${servicio.precio}" required>
    </div>

    <div class="mb-3">
       <label for="ciudad" class="form-label">Ciudad</label>
       <input type="text" class="form-control" id="ciudad" name="ciudad" value="${servicio.ciudad}" required>
    </div>

    <div class="mb-3">
       <label for="fechaPublicacion" class="form-label">Fecha de Publicación</label>
       <input type="text" class="form-control" id="fechaPublicacion" name="fechaPublicacion"
          value="<fmt:formatDate value='${servicio.fechaPublicacion}' pattern='dd/MM/yyyy'/>" disabled>
    </div>

    <div class="mb-3">
       <label for="categoria" class="form-label">Categoría</label>
       <select id="categoria" name="categoria" class="form-select" required>
          <c:forEach var="categoria" items="${categorias}">
             <option value="${categoria.id}" ${categoria.id == servicio.categoria.id ? 'selected' : ''}>
                ${categoria.nombre}
             </option>
          </c:forEach>
       </select>
    </div>

    <div class="mb-3">
       <label class="form-label">Imagen actual:</label><br>
       <img src="${servicio.imgUrl}" alt="Imagen actual" class="imagen-preview">
    </div>

    <div class="mb-3">
       <label for="imagen" class="form-label">Nueva imagen (opcional)</label>
       <input type="file" class="form-control" id="imagen" name="imagen" accept="image/*">
       <div class="mt-2" id="previewContainer">
          <label class="form-label">Vista previa:</label><br>
          <img id="preview" class="imagen-preview" style="display:none;">
       </div>
    </div>

    <div class="text-center mt-4">
       <button type="submit" class="btn btn-primary px-4 me-2">Actualizar Servicio</button>
       <a href="/mis-servicios" class="btn btn-secondary">Volver</a>
    </div>
 </form>