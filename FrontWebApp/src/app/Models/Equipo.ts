import { Usuario } from './Usuario';

export interface Equipo {
  idEquipo: string;
  nombre: string;
  imagen: string;
  descripcion: string;
  totalUsuarios: number;
  estado: number;
}

export interface Usuario_Equipo {
  usuario: Usuario;
  equipo: Equipo;
  fechaCreacion: Date;
  fechaModificacion: Date;
}
