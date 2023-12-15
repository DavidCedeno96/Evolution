namespace WebApiRest.Models
{
    public class Noticia
    {
        public Guid IdNoticia { get; set; }
        public string Titular { get; set; }
        public string Descripcion { get; set; }
        public string Url { get; set; }
        public string Imagen { get; set; }
        public int Estado { get; set; }
        public Guid IdCategoria { get; set; }
        public string Categoria { get; set; }
        public DateTime FechaPublicacion { get; set; }
        public int TotalLikes { get; set; }
        public int TotalComents { get; set; }
        public DateTime FechaCreacion { get; set; }
        public DateTime FechaModificacion { get; set; }
    }

    public class NoticiaList
    {
        public string Info { get; set; }
        public int Error { get; set; }
        public List<Noticia> Lista { get; set; }
    }

    // TABLA INTERMEDIA
    public class Usuario_Noticia
    {
        public Guid IdUsuario { get; set; }
        public string Usuario { get; set; }
        public Guid IdNoticia { get; set; }
        public int Likes { get; set; }
        public string Comentario { get; set; }
        public DateTime FechaCreacion { get; set; }
        public DateTime FechaModificacion { get; set; }
    }

    public class Usuario_NoticiaList
    {
        public string Info { get; set; }
        public int Error { get; set; }
        public List<Usuario_Noticia> Lista { get; set; }
    }
}
