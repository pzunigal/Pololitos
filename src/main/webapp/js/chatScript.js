const firebaseConfig = {
  apiKey: "",
  authDomain: "pololitos-a96fb.firebaseapp.com",
  databaseURL: "https://pololitos-a96fb-default-rtdb.firebaseio.com",
  projectId: "pololitos-a96fb",
  storageBucket: "pololitos-a96fb.appspot.com",
  messagingSenderId: "",
  appId: "",
};
firebase.initializeApp(firebaseConfig);
const db = firebase.database();

const chatId = document.getElementById("chatId").value;
const usuarioId = parseInt(document.getElementById("usuarioId").value);
const nombreUsuario = document.getElementById("nombreUsuario").value;

const chatBox = document.getElementById("chat-box");
const skeleton = document.getElementById("chat-skeleton");
const mensajeForm = document.getElementById("mensaje-form");
const mensajeInput = document.getElementById("mensaje-input");

const mensajesRef = db.ref("chats/" + chatId + "/mensajes");

// Mostrar el skeleton solo si no hay mensajes
let mensajesCargados = false;

// Esperamos 2 segundos: si no hay mensajes, ocultamos skeleton igual
setTimeout(() => {
  if (!mensajesCargados && skeleton) {
    skeleton.style.display = "none";
  }
}, 2000);

mensajesRef.once("value", (snapshot) => {
  if (!snapshot.exists()) {
    // Chat vacío: no hacemos nada, solo dejamos el formulario listo
    return;
  }

  // Ya hay mensajes: los escuchamos en tiempo real
  mensajesRef.on("child_added", function (snap) {
    if (skeleton) skeleton.style.display = "none";
    mensajesCargados = true;

    const mensaje = snap.val();
    const div = document.createElement("div");
    div.className =
      "message " + (mensaje.usuarioId === usuarioId ? "sent" : "received");

    if (mensaje.usuarioId !== usuarioId) {
      const nombre = document.createElement("span");
      nombre.className = "nombre-usuario";
      nombre.textContent = mensaje.nombreUsuario;
      div.appendChild(nombre);
    }

    const contenido = document.createElement("span");
    contenido.textContent = mensaje.contenido;
    div.appendChild(contenido);

    chatBox.appendChild(div);
    chatBox.scrollTop = chatBox.scrollHeight;
  });
});

mensajeForm.addEventListener("submit", function (e) {
  e.preventDefault();
  enviarMensaje();
});

mensajeInput.addEventListener("keydown", function (e) {
  if (e.key === "Enter" && !e.shiftKey) {
    e.preventDefault();
    enviarMensaje();
  }
});

function enviarMensaje() {
  const contenido = mensajeInput.value.trim();
  if (contenido !== "") {
    const nuevoMensaje = {
      contenido: contenido,
      usuarioId: usuarioId,
      nombreUsuario: nombreUsuario,
      createdAt: new Date().toISOString(),
    };
    mensajesRef.push(nuevoMensaje);
    mensajeInput.value = "";
  }
}

function volverAtrasRecargando() {
  window.history.back();
  setTimeout(() => {
    location.reload();
  }, 100);
}
