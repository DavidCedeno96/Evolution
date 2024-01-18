import Swal from 'sweetalert2';

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
