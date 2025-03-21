<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://www.springframework.org/tags" prefix="form" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
            <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
                <!DOCTYPE html>
                <html lang="es">

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>Mis Solicitudes Enviadas</title>
                    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
                        rel="stylesheet">
                    <link href="https://fonts.googleapis.com/css2?family=Orbitron&display=swap" rel="stylesheet">
                    <link rel="stylesheet" href="/css/home.css">
                    <style>
                        body {
                            background: linear-gradient(45deg, #1e2a47, #2c3e50);
                            font-family: 'Orbitron', sans-serif;
                            color: white;
                        }

                        .container {
                            margin-top: 50px;
                        }

                        .card {
                            background-color: #34495e;
                            border: none;
                            margin-bottom: 20px;
                        }

                        .card-title {
                            font-size: 24px;
                            color: #1abc9c;
                        }

                        .card-text {
                            font-size: 18px;
                        }

                        .btn-primary {
                            background-color: #16a085;
                            border: none;
                        }

                        .btn-primary:hover {
                            background-color: #1abc9c;
                        }

                        .table-striped tbody tr:nth-child(odd) {
                            background-color: #2c3e50;
                        }

                        .table-striped tbody tr:nth-child(even) {
                            background-color: #34495e;
                        }
                    </style>
                </head>

                <body>
                    <header>
                        <div class="nav-container">
                            <a href="/">
                                <div class="logo">
                                    <img src="img/pololitosBlanco.png" alt="Logo pololitos">
                                </div>
                            </a>
                            <nav>
                                <ul class="nav-links">
                                    <li><a href="/servicios">Servicios</a></li>
                                    <!-- Agregar la opción Mis Servicios solo si el usuario está logueado -->
                                    <c:choose>
                                        <c:when test="${not empty sessionScope.usuarioEnSesion}">
                                            <li><a href="/mis-servicios">Mis Servicios</a></li>
                                        </c:when>
                                    </c:choose>
                                    <c:choose>
                                        <c:when test="${not empty sessionScope.usuarioEnSesion}">
                                            <li><a href="/mis-solicitudes-enviadas">Enviadas</a></li>
                                        </c:when>
                                    </c:choose>
                                    <c:choose>
                                        <c:when test="${not empty sessionScope.usuarioEnSesion}">
                                            <li><a href="/mis-solicitudes-recibidas">Recibidas</a></li>
                                        </c:when>
                                    </c:choose>
                                </ul>
                            </nav>
                        </div>
                        <div class="user-info">
                            <div class="circle-busqueda">
                                <input type="text" placeholder="¿Qué servicio buscas?">
                                <a href=""><img src="img/busqueda.png" alt="lupa de busqueda"></a>
                            </div>

                            <c:choose>
                                <c:when test="${not empty sessionScope.usuarioEnSesion}">
                                    <a href="/perfilUsuario">
                                        <img src="${sessionScope.usuarioEnSesion.fotoPerfil}" alt="Foto de perfil"
                                            width="40" height="40" style="border-radius: 50%;">
                                    </a>
                                    <a href="/servicios/publicar"><button>Crear Servicio</button></a>
                                    <a href="/logout"><button>Cerrar Sesión</button></a>
                                </c:when>

                                <c:otherwise>
                                    <a href="/login"><button>Iniciar sesión</button></a>
                                    <a href="/registro"><button>Regístrate</button></a>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </header>
                    <div class="container">
                        <h1 class="text-center mb-5">Mis Solicitudes Enviadas</h1>

                        <c:if test="${not empty solicitudes}">
                            <table class="table table-striped">
                                <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>Servicio</th>
                                        <th>Estado</th>
                                        <th>Fecha de Solicitud</th>
                                        <th>Comentario Adicional</th>
                                        <th>Chat</th> <!-- Nueva columna para el chat -->
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="solicitud" items="${solicitudes}">
                                        <tr>
                                            <td>${solicitud.id}</td>
                                            <td>${solicitud.servicio.nombre}</td>
                                            <td>${solicitud.estado}</td>
                                            <td>${solicitud.fechaSolicitud}</td>
                                            <td>${solicitud.comentarioAdicional}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${chatsCreados[solicitud.id]}">
                                                        <!-- Botón verde cuando la conversación ya existe -->
                                                        <form action="/chat/continuar" method="post">
                                                            <input type="hidden" name="solicitudId"
                                                                value="${solicitud.id}">
                                                            <button type="submit" class="btn btn-success mt-2"><i
                                                                    class="fas fa-comments"></i> Chat</button>
                                                        </form>


                                                    </c:when>
                                                    <c:otherwise>
                                                        <!-- Botón gris deshabilitado con alerta -->
                                                        <button class="btn btn-secondary"
                                                            onclick="alert('La conversación aún no ha sido iniciada');"
                                                            disabled>
                                                            <i class="fas fa-comments"></i> Chat
                                                        </button>
                                                    </c:otherwise>
                                                </c:choose>

                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </c:if>

                        <c:if test="${empty solicitudes}">
                            <div class="alert alert-warning text-center">
                                No tienes solicitudes enviadas.
                            </div>
                        </c:if>
                    </div>
                    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
                </body>

                </html>