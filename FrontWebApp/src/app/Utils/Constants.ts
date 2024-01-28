import { DatePipe } from '@angular/common';
import { inject } from '@angular/core';
import { Router } from '@angular/router';
import Swal from 'sweetalert2';

export const FormatoFecha: string = 'dd/MM/yyyy';
export const TitleErrorForm: string = 'Error';
export const MsgErrorForm: string =
  'Hay errores en los campos, por favor revisa e intantalo nuevamente.';

export const AlertError = () => {
  return (titulo: string, msg: string) => {
    Swal.fire({
      title: titulo,
      text: msg,
      icon: 'error',
      confirmButtonText: 'Aceptar',
      buttonsStyling: false,
      customClass: {
        confirmButton: 'btn btn-outline-success normal',
      },
    });
  };
};

export const DateFormat = () => {
  //const opciones = { weekday: 'long', year: 'numeric', month: 'short', day: 'numeric' };
  //let auxFecha = fecha.toLocaleString('es-es', opciones);
  //return fecha.toLocaleDateString('en-US');

  return (fecha: Date): string => {
    let pipe = new DatePipe('en-US');
    return pipe.transform(fecha, FormatoFecha)!;
  };
};

export const ChangeRoute = () => {
  const router = inject(Router);
  return (ruta: string, params: object) => {
    router.navigate([ruta], { queryParams: params });
  };
};

export const Loading = () => {
  const loading = document.getElementById('loading');
  return (visible: boolean, none: boolean) => {
    if (loading) {
      if (none) {
        loading.classList.add('hidden');
        return;
      }
      if (visible) {
        loading.classList.remove('hidden');
      } else {
        setTimeout(() => {
          loading.classList.add('hidden');
        }, 300);
      }
    }
  };
};
