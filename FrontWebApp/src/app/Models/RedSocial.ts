export interface RedSocial {
  idRed: string;
  descripcion: string;
  usuario: string;
  foto: string;
  tipo: string;
  dir: string;
  imagen: string;
  fechaPublicacion: Date;
  totalLikes: number;
  totalComents: number;
}

export interface Reaccion {
  idRed: string;
  idUsuario: string;
  comentario: string;
  likes: number;
  usuario: string;
}

export interface RedSocial_Reaccion {
  redSocial: RedSocial;
  comentarioList: Reaccion[];
}

export interface Usuario_RedSocial {
  idUsuario: string;
  idRed: string;
  likes: number;
  comentario: string;
}
