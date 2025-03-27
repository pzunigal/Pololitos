<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div class="offcanvas offcanvas-start text-bg-dark" tabindex="-1" id="offcanvasFiltro" aria-labelledby="offcanvasFiltroLabel">
    <div class="offcanvas-header">
       <h5 class="offcanvas-title" id="offcanvasFiltroLabel">Filtrar Servicios</h5>
       <button type="button" class="btn-close btn-close-white" data-bs-dismiss="offcanvas"></button>
    </div>
    <div class="offcanvas-body">
       <form action="/servicios" method="get">
          <div class="mb-3">
             <label for="categoriaId" class="form-label">Categoría</label>
             <select name="categoriaId" id="categoriaId" class="form-select">
                <option value="">Todas las categorías</option>
                <c:forEach var="categoria" items="${categorias}">
                   <option value="${categoria.id}" <c:if test="${param.categoriaId == categoria.id}">selected</c:if>>
                      ${categoria.nombre}
                   </option>
                </c:forEach>
             </select>
          </div>
          <div class="mb-3">
             <label for="rangeSlider" class="form-label">Rango de Precio</label>
             <div class="d-flex justify-content-between">
                <span>$<span id="minValueLabel">0</span></span>
                <span>$<span id="maxValueLabel">500000</span></span>
             </div>
             <input type="range" class="form-range" id="precioMinSlider" name="precioMin" min="0" max="500000" step="500" value="${param.precioMin != null ? param.precioMin : 0}" oninput="updateSliderLabels()">
             <input type="range" class="form-range mt-2" id="precioMaxSlider" name="precioMax" min="0" max="500000" step="500" value="${param.precioMax != null ? param.precioMax : 500000}" oninput="updateSliderLabels()">
          </div>
          <button type="submit" class="btn btn-warning w-100">
             <i class="bi bi-search"></i> Aplicar Filtro
          </button>
       </form>
    </div>
 </div>