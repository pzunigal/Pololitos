// public/js/firebase-init.js
const firebaseConfig = {
    apiKey: "",
    authDomain: "pololitos-a96fb.firebaseapp.com",
    databaseURL: "https://pololitos-a96fb-default-rtdb.firebaseio.com",
    projectId: "pololitos-a96fb",
    storageBucket: "pololitos-a96fb.appspot.com",
    messagingSenderId: "",
    appId: "",
  };
  
  if (!firebase.apps.length) {
    firebase.initializeApp(firebaseConfig);
  }
  
  const db = firebase.database();
  window.firebaseDB = db; // Hacemos accesible desde cualquier script
  