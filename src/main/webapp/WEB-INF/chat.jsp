<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" %> <%@ taglib uri="http://www.springframework.org/tags"
prefix="form" %> <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"
%> <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> <%@
taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="es">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Chat</title>
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
    />
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
      rel="stylesheet"
    />
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css"
      rel="stylesheet"
    />
    <link
      href="https://fonts.googleapis.com/css2?family=Quicksand&display=swap"
      rel="stylesheet"
    />
    <link rel="stylesheet" href="<c:url value='/css/views/chat.css' />" />
  </head>
  <body class="body-without-bg">
    <%@ include file="/WEB-INF/componentes/layout/nav.jsp" %>

    <main>
      <div class="servicio-container">
        <div class="servicio-info">
          <h2>Nombre de servicio</h2>
          <p>
            Descripcion de servicio Lorem ipsum dolor sit amet consectetur
            adipisicing elit. Est enim necessitatibus modi suscipit minus. Rem
            reprehenderit adipisci recusandae voluptas ducimus maxime molestiae
            voluptatem ad. Expedita cumque in magni incidunt saepe!
          </p>
        </div>
        <img src="/img/work.jpg" alt="" />
        <button>Ver servicio</button>
      </div>
      <div class="container">
        <!-- CHAT FORM -->
        <%@ include file="/WEB-INF/componentes/forms/chatForm.jsp" %>
      </div>
    </main>
    <footer>
      <button onclick="volverAtrasRecargando()">
        <i class="fa-solid fa-arrow-left"></i>
        Volver
      </button>
    </footer>
    <script src="https://www.gstatic.com/firebasejs/9.6.1/firebase-app-compat.js"></script>
    <script src="https://www.gstatic.com/firebasejs/9.6.1/firebase-database-compat.js"></script>
    <script src="<c:url value='/js/chatScript.js' />"></script>
  </body>
</html>
