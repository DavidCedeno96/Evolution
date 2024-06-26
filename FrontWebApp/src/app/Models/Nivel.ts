export interface Nivel {
  idNivel: string;
  nombre: string;
  descripcion: string;
  puntosNecesarios: number;
  imagen: string;
  totalUsuarios: number;
  estado: number;
  fechaCreacion: Date;
}

export interface Usuario_Nivel {
  idNivel: string;
  idUsuario: string;
}
