<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<form:form action="/iniciarSesion" method="POST" modelAttribute="loginUsuario">
  <div class="mb-3">
    <form:label path="emailLogin" class="form-label"
      >Correo Electrónico</form:label
    >
    <form:input path="emailLogin" class="form-control" />
    <form:errors path="emailLogin" class="text-danger" />
  </div>
  <div class="mb-3">
    <form:label path="passwordLogin" class="form-label">Contraseña</form:label>
    <form:input path="passwordLogin" type="password" class="form-control" />
    <form:errors path="passwordLogin" class="text-danger" />
  </div>
  <button type="submit" class="btn btn-primary">Ingresar</button>
</form:form>
