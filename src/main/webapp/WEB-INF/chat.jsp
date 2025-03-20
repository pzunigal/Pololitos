<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chat</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css">
    <style>
        .chat-container {
            max-width: 600px;
            margin: 20px auto;
            padding: 20px;
            border: 2px solid #3498db;
            border-radius: 10px;
            background-color: #ecf0f1;
        }
        .chat-box {
            height: 300px;
            overflow-y: scroll;
            border: 1px solid #ccc;
            padding: 10px;
            background: white;
        }
        .message {
            margin: 5px 0;
            padding: 8px;
            border-radius: 5px;
        }
        .sent {
            background-color: #3498db;
            color: white;
            text-align: right;
        }
        .received {
            background-color: #2ecc71;
            color: white;
            text-align: left;
        }
    </style>
</head>
<body>

<div class="container mt-5">
    <div class="chat-container">
        <h2 class="text-center">Chat</h2>
        <p class="text-center">Conversación entre proveedor y cliente</p>

        <div class="chat-box">
            <!-- Mensajes de ejemplo (esto será dinámico más adelante) -->
            <div class="message received">¡Hola! Estoy interesado en el servicio.</div>
            <div class="message sent">¡Hola! Claro, ¿en qué puedo ayudarte?</div>
        </div>

        <!-- Formulario para enviar mensajes (sin funcionalidad aún) -->
        <form class="mt-3">
            <div class="mb-3">
                <textarea class="form-control" rows="2" placeholder="Escribe un mensaje..."></textarea>
            </div>
            <button type="submit" class="btn btn-primary w-100">Enviar</button>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
