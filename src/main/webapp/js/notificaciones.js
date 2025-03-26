// public/js/notificaciones.js
document.addEventListener("DOMContentLoaded", function () {
    const badge = document.getElementById("notificacionBadge");
    const lista = document.getElementById("notificacionesLista");
    const usuarioId = document.getElementById("usuarioIdNavbar")?.value;
  
    if (!usuarioId || !window.firebaseDB || !badge || !lista) return;
  
    const notiRef = window.firebaseDB.ref("notificaciones/" + usuarioId);
    let cantidad = 0;
  
    notiRef.on("value", (snapshot) => {
      lista.innerHTML = ""; // Limpia el dropdown
      cantidad = 0;
  
      if (!snapshot.exists()) {
        lista.innerHTML = "<li class='dropdown-item text-white'>Sin notificaciones</li>";
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
        item.className = "dropdown-item text-white border-bottom small";
        item.style.cursor = "pointer";
        item.textContent = noti.mensaje;
        item.onclick = () => window.location.href = noti.urlDestino;
  
        lista.appendChild(item);
  
        if (!noti.leida) cantidad++;
      });
  
      badge.textContent = cantidad;
      badge.style.display = cantidad > 0 ? "inline-block" : "none";
    });
  });
  