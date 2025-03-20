<%@ taglib uri="http://www.springframework.org/tags" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mis Solicitudes Enviadas</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Orbitron&display=swap" rel="stylesheet">
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
</body>
</html>
