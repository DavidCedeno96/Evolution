namespace WebApiRest.Models
{
    public class RedSocial
    {
        public Guid IdRed { get; set; }
        public string Descripcion { get; set; }
        public string Imagen { get; set; }
        public int Estado { get; set; }
        public DateTime FechaPublicacion { get; set; }
        public int TotalLikes { get; set; }
        public int TotalComents { get; set; }
        public DateTime FechaCreacion { get; set; }
        public DateTime FechaModificacion { get; set; }
    }

    public class RedSocialList
    {
        public string Info { get; set; }
        public int Error { get; set; }
        public List<RedSocial> Lista { get; set; }
    }    

    // TABLA INTERMEDIA
    public class Usuario_RedSocial
    {
        public Guid IdUsuario { get; set; }
        public string Usuario { get; set; }
        public Guid IdRed { get; set; }
        public int Likes { get; set; }
        public string Comentario { get; set; }
        public DateTime FechaCreacion { get; set; }
        public DateTime FechaModificacion { get; set; }
    }   

    public class Usuario_RedSocialList
    {
        public string Info { get; set; }
        public int Error { get; set; }
        public List<Usuario_RedSocial> Lista { get; set; }
    }

    public class RedSocial_ComentarioList
    {
        public string Info { get; set; }
        public int Error { get; set; }
        public RedSocial RedSocial { get; set; }
        public List<Usuario_RedSocial> ComentarioList { get; set; }
    }

    public class RedSocialList_comentarios
    {
        public string Info { get; set; }
        public int Error { get; set; }
        public List<RedSocial_ComentarioList> Lista { get; set; }
    }
}
