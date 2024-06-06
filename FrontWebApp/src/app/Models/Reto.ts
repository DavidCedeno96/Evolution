import { Equipo } from './Equipo';
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
  idTipoEncuesta: string;
  tipoEncuesta: string;
  idComportamiento: string;
  comportamientoPregunta: string;
  idTipoArchivo: string;
  tipoArchivo: string;
  idTipoValidador: string;
  tipoValidador: string;
  estado: number;
  totalPreguntas: number;
  usuariosAsignados: number;
  equiposAsignados: number;
  validadores: number;
  puedeValidar: number;
  enEquipo: number;
  opsRequeridas: number;
  items: number;
}

export interface Usuario_Reto {
  usuario: Usuario;
  reto: Reto;
  puntos: number;
  tiempo: number;
  vidas: number;
  totalRetos: number;
  posicion: number;
  completado: number;
  tieneEquipo: number;
  archivos: UsuarioxArchivo[];
  correctas: number;
  incorrectas: number;
  fechaCreacion: Date;
  fechaModificacion: Date;
}

export interface Equipo_Reto {
  equipo: Equipo;
  reto: Reto;
  totalUsuarios: number;
}

export interface UsuarioxArchivo {
  idReto: string;
  idUsuario: string;
  archivo: string;
  url: string;
  fechaCreacion: Date;
  fechaModificacion: Date;
}
