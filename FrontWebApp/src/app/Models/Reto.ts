import { Usuario } from './Usuario';

export interface Reto {
  idReto: string;
  nombre: string;
  fechaApertura: Date;
  fechaCierre: Date;
  vidas: number;
  tiempo_ms: number;
  puntosRecompensa: number;
  creditosObtenidos: number;
  instrucciones: string;
  criterioMinimo: number;
  imagen: string;
  idTipoReto: string;
  tipoReto: string;
  idComportamiento: string;
  comportamientoPregunta: string;
  estado: number;
  totalPreguntas: number;
}

export interface Usuario_Reto {
  usuario: Usuario;
  reto: Reto;
  puntos: number;
  tiempo: number;
  vidas: number;
  totalRetos: number;
  completado: number;
}
