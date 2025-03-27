document.addEventListener("DOMContentLoaded", function () {
  const badge = document.getElementById("notificacionBadge");
  const lista = document.getElementById("notificacionesLista");
  const usuarioId = document.getElementById("usuarioIdNavbar")?.value;

  if (!usuarioId || !window.firebaseDB || !badge || !lista) return;

  const notiRef = window.firebaseDB.ref("notificaciones/" + usuarioId);
  let cantidad = 0;

  notiRef.on("value", (snapshot) => {
    lista.innerHTML = "";
    cantidad = 0;

    if (!snapshot.exists()) {
      lista.innerHTML =
        "<li class='dropdown-item text-white'>Sin notificaciones</li>";
      badge.style.display = "none";
      return;
    }

    const notis = [];
    snapshot.forEach((snap) => {
      const n = snap.val();
      notis.push({ ...n, id: snap.key });
    });

    notis.reverse().forEach((noti) => {
      const item = document.createElement("li");
      item.className =
        "dropdown-item text-white border-bottom small d-flex align-items-start gap-2";
      item.classList.add(
        noti.leida ? "notificacion-leida" : "notificacion-no-leida"
      );
      item.style.cursor = "pointer";

      const img = document.createElement("img");
      img.src = noti.imagenServicio || "/img/work.jpg";
      img.alt = "img";
      img.width = 40;
      img.height = 40;
      img.className = "rounded-circle flex-shrink-0";

      const content = document.createElement("div");
      content.className = "text-break";
      content.innerHTML = `
          <div><strong>${noti.tipo || "Usuario"}</strong></div>
          <div class="text-white-50">${noti.mensaje}</div>
        `;

      item.appendChild(img);
      item.appendChild(content);

      item.addEventListener("click", () => {
        if (!noti.leida) {
          fetch(`/notificaciones/marcar-leida/${usuarioId}/${noti.id}`, {
            method: "PATCH",
          });
        }
        window.location.href = noti.urlDestino;
      });

      lista.appendChild(item);

      if (!noti.leida) cantidad++;
    });

    badge.textContent = cantidad;
    badge.style.display = cantidad > 0 ? "inline-block" : "none";
  });
});
