import { Usuario } from './Usuario';

export interface Equipo {
  idEquipo: string;
  nombre: string;
  imagen: string;
  descripcion: string;
  totalUsuarios: number;
  puntos: number;
  tiempo: number;
  estado: number;
}

export interface Usuario_Equipo {
  usuario: Usuario;
  equipo: Equipo;
  posicion: number;
  fechaCreacion: Date;
  fechaModificacion: Date;
}
