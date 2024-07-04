export interface Noticia {
  idNoticia: string;
  titular: string;
  descripcion: string;
  url: string;
  imagen: string;
  idCategoria: string;
  categoria: string;
  fechaPublicacion: Date;
  totalLikes: number;
  totalComents: number;
}

export interface Reaccion {
  idNoticia: string;
  idUsuario: string;
  comentario: string;
  likes: number;
  usuario: string;
}

export interface Noticia_Reaccion {
  noticia: Noticia;
  userLiked: number;
  comentarioList: Reaccion[];
}

export interface Usuario_Noticia {
  idUsuario: string;
  idNoticia: string;
  likes: number;
  comentario: string;
}
