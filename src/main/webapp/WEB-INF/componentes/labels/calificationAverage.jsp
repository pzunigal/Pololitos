<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" %>
<c:if test="${not empty promedio}">
  <div class="text-center mb-4">
    <h5>Promedio de calificaciones</h5>
    <div class="promedio-star">
      <c:forEach var="i" begin="1" end="5">
        <span class="star ${i <= promedio ? 'filled' : ''}">&#9733;</span>
      </c:forEach>
      <span class="promedio-num">
        (<fmt:formatNumber value="${promedio}" maxFractionDigits="1" /> / 5)
      </span>
    </div>
  </div>
</c:if>
