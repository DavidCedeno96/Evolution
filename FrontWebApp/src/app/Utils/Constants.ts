import { DatePipe } from '@angular/common';
import Swal from 'sweetalert2';

export const FormatoFecha: string = 'dd/MM/yyyy';
export const TitleErrorForm: string = 'Error';
export const MsgErrorForm: string =
  'Hay errores en los campos, por favor revisa e intantalo nuevamente.';

export function AlertError(titulo: string, msg: string) {
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
}

export function DateFormat(fecha: Date): string {
  //const opciones = { weekday: 'long', year: 'numeric', month: 'short', day: 'numeric' };
  //let auxFecha = fecha.toLocaleString('es-es', opciones);
  //return fecha.toLocaleDateString('en-US');

  let pipe = new DatePipe('en-US');
  return pipe.transform(fecha, FormatoFecha)!;
}

export function Loading(visible: boolean, none: boolean) {
  const loading = document.getElementById('loading');
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
}
