export interface RedSocial {
  idRed: string;
  descripcion: string;
  imagen: string;
  idCategoria: string;
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
