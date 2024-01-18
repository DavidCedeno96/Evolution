export interface Noticia {
  idNoticia: string;
  titular: string;
  descripcion: string;
  url: string;
  imagen: string;
  categoria: string;
  fechaPublicacion: Date;
  totalLikes: number;
  totalComents: number;
}

export interface Categoria {
  idCategoria: string;
  nombre: string;
  descripcion: string;
}
