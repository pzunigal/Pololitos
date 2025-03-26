<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<div class="col-12 col-sm-10 col-md-8 col-lg-5 col-xl-4 mb-4 contact-box">
  <form action="#" method="POST">
    <div class="mb-3">
      <label for="nombre" class="form-label">Nombre:</label>
      <input
        type="text"
        class="form-control"
        id="nombre"
        name="nombre"
        placeholder="Tu nombre"
        required
      />
    </div>
    <div class="mb-3">
      <label for="email" class="form-label">Correo electrónico:</label>
      <input
        type="email"
        class="form-control"
        id="email"
        name="email"
        placeholder="tuemail@ejemplo.com"
        required
      />
    </div>
    <div class="mb-3">
      <label for="telefono" class="form-label">Teléfono (opcional):</label>
      <input
        type="tel"
        class="form-control"
        id="telefono"
        name="telefono"
        placeholder="123-456-7890"
      />
    </div>
    <div class="mb-3">
      <label for="mensaje" class="form-label">¿En qué te podemos ayudar?</label>
      <textarea
        class="form-control"
        id="mensaje"
        name="mensaje"
        rows="5"
        placeholder="Describe tu necesidad o tarea..."
        required
      ></textarea>
    </div>
    <div class="text-center">
      <button type="submit" class="btn btn-warning btn-lg px-5">
        Enviar mensaje
      </button>
    </div>
  </form>
</div>
