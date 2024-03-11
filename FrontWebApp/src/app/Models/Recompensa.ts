export interface Recompensa {
  idRecompensa: string;
  nombre: string;
  descripcion: string;
  imagen: string;
  cantDisponible: number;
  cantCanje: number; //Son los Créditos Requeridos
  totalUsuarios: number;
  estado: number;
}

export interface Usuario_Recompensa {
  idRecompensa: string;
  idUsuario: string;
}
