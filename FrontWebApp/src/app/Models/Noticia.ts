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
