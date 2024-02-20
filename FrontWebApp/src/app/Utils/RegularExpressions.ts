import { AbstractControl } from '@angular/forms';

export const exp_palabras = /^[a-zA-ZáéíóúüÁÉÍÓÚÜñÑ\s]+$/; //Solo letras
export const exp_numeros = /^\d+$/; //Solo numeros
export const exp_invalidos = /^[^<>]+$/; // No se permiten caracteres invalidos
export const exp_contrasena =
  /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@\.\-_$#])[a-zA-Z\d@\.\-_$#]{5,20}$/; // esta es para la contraseña

export const CaracterInvalid = () => {
  return (control: AbstractControl): { [key: string]: boolean } | null => {
    const value = control.value;
    var expresionRegular = exp_invalidos;
    var resultado = expresionRegular.test(value);

    if (value === '' || resultado) {
      return null;
    }

    return { caracterInvalid: true };
  };
};

export const ContrasenaInvalid = () => {
  return (control: AbstractControl): { [key: string]: boolean } | null => {
    const value = control.value;
    var expresionRegular = exp_contrasena;
    var resultado = expresionRegular.test(value ? value.trim() : value);

    if (value === null || value === '' || resultado) {
      return null;
    }

    return { contrasenaInvalid: true };
  };
};
