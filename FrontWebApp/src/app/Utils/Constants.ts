import { DatePipe } from '@angular/common';
import { inject } from '@angular/core';
import { AbstractControl } from '@angular/forms';
import { Router } from '@angular/router';
import Swal from 'sweetalert2';

/* CONSTANTES */
export const servicioURL: string = 'http://192.168.100.91:8087';
//export const servicioURL: string = 'http://localhost:49090';

export const ImgSizeMax: number = 600 * 1024;
export const FormatoFecha: string = 'dd/MM/yyyy';
export const FormatoFechaInput: string = 'yyyy-MM-dd';
export const SinRegistros: string = 'No hay registros';
export const TitleEliminar: string = 'Confirmación Eliminar';
export const MsgEliminar: string = '¿Seguro desea eliminar el registro?';
export const MsgElimindo: string = 'Registro eliminado';
export const MsgEditado: string = 'Registro actualizado';
export const MsgFormatoDescargado: string = 'Formato descargado';
export const MsgOk: string = 'Proceso ejecutado';
export const TitleErrorForm: string = 'Error';
export const MsgErrorArchivo: string =
  'No se encuentran las cabeceras en el archivo';
export const TitleErrorArchivo: string = 'Error del archivo';
export const MsgErrorForm: string =
  'Hay errores en los campos, por favor revisa e intantalo nuevamente.';
export const TitleError: string = 'Error del servidor';
export const MsgError: string =
  'Ha ocurrido un error con el servidor, intentalo más tarde o vuelve a iniciar sesión';
export const MsgErrorConexion: string =
  'Ha ocurrido un error en la conexión, intentalo más tarde o recarga la página';

/* FUNCIONES */
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
  return (fecha: Date): string => {
    let pipe = new DatePipe('en-US');
    return pipe.transform(fecha, FormatoFecha)!;
  };
};

export const DateFormatInput = () => {
  return (fecha: string): string => {
    let date = new Date(fecha);
    let pipe = new DatePipe('en-US');
    return pipe.transform(date, FormatoFechaInput)!;
  };
};

export const ChangeRoute = () => {
  const router = inject(Router);
  return (ruta: string, params: object) => {
    router.navigate([ruta], { queryParams: params });
  };
};

export const GetImage = () => {
  return (image: string, directorio: string, defaultImage: string): string => {
    if (image !== 'N/A' && image !== '') {
      return `${servicioURL}/Content/Images/${directorio}/${image}`;
    }
    return `assets/img/default/${defaultImage}`;
  };
};

export const ObjectInvalid = () => {
  return (control: AbstractControl): { [key: string]: boolean } | null => {
    const value = control.value;

    if (value instanceof Date) {
      return { objectInvalid: true };
    }

    return null;
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
        }, 500);
      }
    }
  };
};
