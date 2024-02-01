export const exp_palabras = /^[a-zA-ZáéíóúüÁÉÍÓÚÜñÑ\s]+$/; //Solo letras
export const exp_numeros = /^\d+$/; //Solo numeros
export const exp_invalidos = /^[^<>]+$/; // No se permiten caracteres invalidos
export const exp_contrasena =
  /^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)[#@_\-\.a-zA-Z\d]{5,}$/; // esta es para la contraseña
