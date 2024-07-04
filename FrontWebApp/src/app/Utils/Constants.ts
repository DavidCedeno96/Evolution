import { DatePipe } from '@angular/common';
import { inject } from '@angular/core';
import { AbstractControl } from '@angular/forms';
import { Router } from '@angular/router';
import { ConfigAppService } from '../services/config-app.service';
import Swal from 'sweetalert2';

const config = new ConfigAppService();

/* CONSTANTES */

export const API_URL = config.restUrl;
export const PLAY_MOVE = config.playMove;
export const API_URL_BUNNY_CDN = config.bunny;

export const ImgSizeMax: number = 200 * 1024;
export const FileSizeMax: number = 150 * 1024;
export const ImgSizeMaxConfig: number = 350 * 1024;
export const ImgWidthMax: number = 360;
export const ImgHeightMax: number = 360;
export const SoundQuizCorrect: string = 'assets/sounds/QuizCorrect.wav';
export const SoundQuizIncorrect: string = 'assets/sounds/QuizWrong.wav';
export const SoundQuizVictory: string = 'assets/sounds/Victory.mp3';
export const FormatoFecha: string = 'dd/MM/yyyy';
export const FormatoFechaInput: string = 'yyyy-MM-dd';
export const SugerenciaImagen: string =
  'Dimensiones máximas 360x360 píxeles y 200 KB. Formatos JPG y PNG.';
export const SugerenciaImagen1: string =
  'Dimensiones máximas 360x360 píxeles y 200 KB. Formatos JPG, PNG y GIF.';
export const SinRegistros: string = 'No hay registros';
export const TitleEliminar: string = 'Confirmación Eliminar';
export const MsgEliminar: string = '¿Seguro desea eliminar el registro?';
export const MsgElimindo: string = 'Registro eliminado';
export const MsgEditado: string = 'Registro actualizado';
export const MsgFormatoDescargado: string = 'Formato descargado';
export const MsgArchivoDescargado: string = 'Archivo descargado';
export const MsgOk: string = 'Proceso ejecutado';
export const MsgActivado: string = 'Registro Activado';
export const MsgDesactivado: string = 'Registro Desactivado';
export const TitleErrorForm: string = 'Error';
export const MsgErrorArchivo: string =
  'No se encuentran las cabeceras en el archivo';
export const TitleErrorArchivo: string = 'Error del archivo';
export const MsgErrorForm: string =
  'Hay errores en los campos, por favor revisa e intantalo nuevamente.';
export const TitleError: string = 'Error del servidor';
export const MsgError: string =
  'Ha ocurrido un error con el servidor, intentalo más tarde o contactate con el administrador';
export const MsgErrorConexion: string =
  'Ha ocurrido un error en la conexión, intentalo más tarde o recarga la página';
export const FontFamily: string =
  "system-ui, -apple-system, 'Segoe UI', Roboto, 'Helvetica Neue', 'Noto Sans', 'Liberation Sans', Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji'";
export const HtmlLicencias: string =
  '<a style="display: block; margin-top: 10px;" href="' +
  PLAY_MOVE +
  '" target="_blank">Comprar más licencias</a>';

export var UpsertMsg: string = '';
export var Upsert: boolean = false;

/* FUNCIONES */
export const AlertError = () => {
  return (titulo: string, msg: string) => {
    Swal.fire({
      title: titulo,
      html: msg,
      icon: 'error',
      confirmButtonText: 'Aceptar',
      buttonsStyling: false,
      customClass: {
        confirmButton: 'btn btn-outline-secondary normal',
      },
    });
  };
};

export const AlertSuccess = () => {
  return (titulo: string, msg: string) => {
    Swal.fire({
      title: titulo,
      html: msg,
      icon: 'success',
      confirmButtonText: 'Aceptar',
      buttonsStyling: false,
      customClass: {
        confirmButton: 'btn btn-outline-secondary normal',
      },
    });
  };
};

export const AlertWarning = () => {
  return (titulo: string, msg: string) => {
    Swal.fire({
      title: titulo,
      html: msg,
      icon: 'warning',
      confirmButtonText: 'Aceptar',
      buttonsStyling: false,
      customClass: {
        confirmButton: 'btn btn-outline-secondary normal',
      },
    });
  };
};

export const DateFormatInput = () => {
  return (fecha: string): string => {
    let date = new Date(fecha);
    if (date.getFullYear() > 1900) {
      let pipe = new DatePipe('en-US');
      return pipe.transform(date, FormatoFechaInput)!;
    } else {
      return '';
    }
  };
};

export const DateCompare = () => {
  return (fecha: Date): string => {
    let date = new Date(fecha);
    if (date.getFullYear() > 1900) {
      let pipe = new DatePipe('en-US');
      return pipe.transform(fecha, FormatoFecha)!;
    } else {
      return 'N/A';
    }
  };
};

export const FormatTiempo = () => {
  return (milisegundos: number): string => {
    const segundosTotales = Math.floor(milisegundos / 1000);
    const horas = Math.floor(segundosTotales / 3600);
    const minutos = Math.floor((segundosTotales % 3600) / 60);
    const segundos = segundosTotales % 60;

    let duracion = `${AgregarCeros(horas)}:${AgregarCeros(
      minutos
    )}:${AgregarCeros(segundos)}`;
    return duracion;
  };
};

const AgregarCeros = (valor: number): string => {
  return valor < 10 ? `0${valor}` : `${valor}`;
};

export const GetTypeTime = () => {
  return (milisegundos: number): string => {
    if (milisegundos >= 3600000 && milisegundos < 7200000) {
      return 'hora';
    } else if (milisegundos >= 7200000) {
      return 'horas';
    } else {
      return 'minutos';
    }
  };
};

export const GetColors = () => {
  return (numColors: number, opacidad: number): string[] => {
    let colors: string[] = [];
    for (let i = 0; i < numColors; i++) {
      let r = Math.floor(Math.random() * 256);
      let g = Math.floor(Math.random() * 256);
      let b = Math.floor(Math.random() * 256);
      colors.push(`rgb(${r}, ${g}, ${b}, ${opacidad})`);
    }
    return colors;
  };
};

export const GetColor = () => {
  return (opacidad: number): string[] => {
    let color: string[] = [];
    let r = Math.floor(Math.random() * 256);
    let g = Math.floor(Math.random() * 256);
    let b = Math.floor(Math.random() * 256);
    color.push(`rgb(${r}, ${g}, ${b}, ${opacidad})`);
    color.push(`rgb(${r}, ${g}, ${b})`);
    return color;
  };
};

export const ChangeRoute = () => {
  const router = inject(Router);
  return (ruta: string, params: object, refreshPage: boolean = false) => {
    if (ruta === '/404') {
      router.navigate(['/page_not_found'], { replaceUrl: true });
    } else {
      router.navigate([ruta], { queryParams: params }).then(() => {
        if (refreshPage) {
          window.location.reload();
        }
      });
    }
  };
};

export const GetImage = () => {
  return (
    image: string,
    serverDirectorio: string,
    defaultImage: string
  ): string => {
    if (image !== 'N/A' && image !== '') {
      return `${API_URL}/Content/Images/${serverDirectorio}/${image}`;
    }
    return `assets/img/default/${defaultImage}`;
  };
};

export const GetArchivo = () => {
  return (archivo: string, serverDirectorio: string): string => {
    if (archivo !== 'N/A' && archivo !== '') {
      return `${API_URL}/Content/Archivos/${serverDirectorio}/${archivo}`;
    }
    return 'N/A';
  };
};

export const ExtractString = () => {
  return (text: string, exp: RegExp): string => {
    const result = text.match(exp);
    return result ? result[1] : '';
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

export const SetUpsert = () => {
  return (isUpsert: boolean, msg: string) => {
    Upsert = isUpsert;
    UpsertMsg = msg;
  };
};

export const ReproducirSonido = () => {
  return (archivo: string) => {
    let audio = new Audio();
    audio.src = archivo;
    audio.load();
    audio.play();
  };
};

export const Loading = () => {
  const loading = document.getElementById('loading');
  return (visible: boolean, none: boolean, tiempo: number = 500) => {
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
        }, tiempo);
      }
    }
  };
};
