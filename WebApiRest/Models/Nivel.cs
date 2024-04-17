namespace WebApiRest.Models
{
    public class Nivel
    {
        public Guid IdNivel { get; set; }
        public string Nombre { get; set; }        
        public string Descripcion { get; set; }
        public int PuntosNecesarios { get; set; }
        public string Imagen { get; set; }
        public int Estado { get; set; }
        public int TotalUsuarios { get; set; }
        public DateTime FechaCreacion { get; set; }
        public DateTime FechaModificacion { get; set; }
    }

    public class NivelItem
    {
        public string Info { get; set; }
        public int Error { get; set; }
        public Nivel Nivel { get; set; }
    }

    public class NivelList
    {
        public string Info { get; set; }
        public int Error { get; set; }
        public List<Nivel> Lista { get; set; }
    }    

    // TABLA INTERMEDIA
    public class Usuario_Nivel
    {
        public Guid IdUsuario { get; set; }
        public Guid IdNivel { get; set; }
        public string Nombre { get; set; }
        public int Puntos { get; set; } = 0;
        public string Imagen { get; set; }
        public string Descripcion { get; set; }
        public DateTime FechaCreacion { get; set; }
        public DateTime FechaModificacion { get; set; }
    }

    public class Usuario_NivelList
    {
        public string Info { get; set; }
        public int Error { get; set; }
        public List<Usuario_Nivel> Lista { get; set; }
    }

    public class Usuario_NivelItem
    {
        public string Info { get; set; }
        public int Error { get; set; }
        public Nivel NivelActual { get; set; }
        public Nivel NivelProximo { get; set; }
        public Usuario Usuario { get; set; }
    }
}
