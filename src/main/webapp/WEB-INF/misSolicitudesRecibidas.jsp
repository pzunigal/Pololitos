<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://www.springframework.org/tags" prefix="form" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
            <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
                <!DOCTYPE html>
                <html lang="es">

                <head>
                    <meta charset="UTF-8">
                    <meta http-equiv="X-UA-Compatible" content="IE=edge">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>Mis Solicitudes Recibidas</title>
                    <link rel="stylesheet"
                        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css">
                    <link rel="stylesheet" href="/css/home.css">
                    <style>
                        /* Estilo personalizado */
                        .solicitud-card {
                            border: 2px solid #3498db;
                            border-radius: 10px;
                            padding: 20px;
                            margin: 10px 0;
                            background-color: #ecf0f1;
                        }

                        .solicitud-card h5 {
                            color: #2c3e50;
                        }

                        .solicitud-card .estado {
                            font-weight: bold;
                            color: #2ecc71;
                        }

                        .solicitud-card .mensaje {
                            font-style: italic;
                            color: #7f8c8d;
                        }

                        .solicitud-card {
                            border: 2px solid;
                            border-radius: 10px;
                            padding: 20px;
                            margin: 10px 0;
                            background-color: #ecf0f1;
                            transition: all 0.3s ease;
                        }

                        .solicitud-card h5 {
                            color: #2c3e50;
                        }

                        .solicitud-card .estado {
                            font-weight: bold;
                        }

                        .solicitud-card .estado[data-estado="Aceptada"] {
                            color: #2ecc71;
                        }

                        .solicitud-card .estado[data-estado="Enviado"] {
                            color: #e74c3c;
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

                    <main style="margin-top: 120px;">
                        <section style="max-width: 900px; margin: auto; padding: 20px;">
                            <h2 class="text-center mb-4">Mis Solicitudes Recibidas</h2>
                    
                            <c:if test="${not empty solicitudes}">
                                <div class="d-flex flex-column gap-4">
                                    <c:forEach var="solicitud" items="${solicitudes}">
                                        <c:set var="borderColor"
                                            value="${solicitud.estado == 'Aceptada' ? '#2ecc71' : '#e74c3c'}" />
                                        <c:set var="estadoColor"
                                            value="${solicitud.estado == 'Aceptada' ? '#2ecc71' : '#e74c3c'}" />
                    
                                        <div class="solicitud-card" style="border-color: ${borderColor};">
                                            <h5>Solicitud de: ${solicitud.solicitante.nombre}</h5>
                                            <p><strong>Servicio:</strong> ${solicitud.servicio.nombre}</p>
                                            <p class="mensaje"><strong>Comentario:</strong> ${solicitud.comentarioAdicional}</p>
                                            <p class="estado" style="color: ${estadoColor};">
                                                <strong>Estado:</strong> ${solicitud.estado}
                                            </p>
                    
                                            <c:if test="${solicitud.estado != 'Aceptada'}">
                                                <form action="/aceptar-solicitud" method="post" class="mb-2">
                                                    <input type="hidden" name="solicitudId" value="${solicitud.id}">
                                                    <button type="submit" class="btn btn-success">Aceptar Solicitud</button>
                                                </form>
                                            </c:if>
                    
                                            <c:choose>
                                                <c:when test="${chatsCreados[solicitud.id]}">
                                                    <form action="/chat/continuar" method="post">
                                                        <input type="hidden" name="solicitudId" value="${solicitud.id}">
                                                        <button type="submit" class="btn btn-outline-success">Continuar Conversación</button>
                                                    </form>
                                                </c:when>
                                                <c:otherwise>
                                                    <form action="/chat/crear" method="post">
                                                        <input type="hidden" name="solicitanteId" value="${solicitud.solicitante.id}">
                                                        <input type="hidden" name="solicitudId" value="${solicitud.id}">
                                                        <button type="submit" class="btn btn-primary">Iniciar Conversación</button>
                                                    </form>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </c:forEach>
                                </div>
                            </c:if>
                    
                            <c:if test="${empty solicitudes}">
                                <p class="text-center text-white mt-5">No tienes solicitudes recibidas aún.</p>
                            </c:if>
                        </section>
                    </main>
                    

                    <script
                        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
                </body>

                </html>