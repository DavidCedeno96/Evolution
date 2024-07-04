namespace WebApiRest.Models
{
    public class Medalla
    {
        public Guid IdMedalla { get; set; }
        public string Nombre { get; set; }
        public string Descripcion { get; set; }
        public string Imagen { get; set; }
        public int Estado { get; set; }
        public int TotalUsuarios { get; set; }
        public Guid IdCondicion { get; set; }
        public string Condicion { get; set; }
        public int NumCondicion { get; set; }
        public DateTime FechaCreacion { get; set; }
        public DateTime FechaModificacion { get; set; }
    }

    public class MedallaItem
    {
        public string Info { get; set; }
        public int Error { get; set; }
        public Medalla Medalla { get; set; }
    }

    public class MedallaList
    {
        public string Info { get; set; }
        public int Error { get; set; }
        public List<Medalla> Lista { get; set; }
    }

    // TABLA INTERMEDIA
    public class Usuario_Medalla
    {
        public Guid IdMedalla { get; set; }
        public string Nombre { get; set; }
        public string Imagen { get; set; }
        public string Condicion { get; set; }        
        public int NumCondicion { get; set; }
        public Guid IdUsuario { get; set; }        
        public DateTime FechaCreacion { get; set; }
        public DateTime FechaModificacion { get; set; }
    }

    public class Usuario_MedallaList
    {
        public string Info { get; set; }
        public int Error { get; set; }
        public List<Usuario_Medalla> Lista { get; set; }
    }
}
