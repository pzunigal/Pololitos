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
    <link rel="stylesheet" href="<c:url value='/css/global.css' />" />
  </head>
  <body class="body-without-bg">
    <%@ include file="/WEB-INF/componentes/layout/nav.jsp" %>

    <main class="my-4">
      <div class="container">
        <div class="row justify-content-center g-4">
          <!-- Servicio -->
          <%@ include file="/WEB-INF/componentes/cards/cardServiceOnChat.jsp" %>

          <!-- Chat -->
          <%@ include file="/WEB-INF/componentes/chats/chatUserAndProvider.jsp"
          %>
        </div>
      </div>
    </main>

    <div class="text-center mt-4 mb-3">
      <button class="btn btn-secondary" onclick="volverAtrasRecargando()">
        <i class="fa-solid fa-arrow-left"></i> Volver
      </button>
    </div>
    <!-- Footer -->
    <%@ include file="/WEB-INF/componentes/layout/footer.jsp" %>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <script src="https://www.gstatic.com/firebasejs/9.6.1/firebase-app-compat.js"></script>
    <script src="https://www.gstatic.com/firebasejs/9.6.1/firebase-database-compat.js"></script>
    <!-- Firebase Init común -->
    <script src="<c:url value='/js/firebase-init.js' />"></script>
    <script src="<c:url value='/js/chatScript.js' />"></script>
  </body>
</html>
