namespace WebApiRest.Models
{
    public class Equipo
    {
        public Guid IdEquipo { get; set; }
        public string Nombre { get; set; }
        public string Imagen { get; set; }
        public string Descripcion { get; set; }
        public int TotalUsuarios { get; set; }
        public int Estado { get; set; }
        public DateTime FechaCreacion { get; set; }
        public DateTime FechaModificacion { get; set; }
    }

    public class EquipoItem
    {
        public string Info { get; set; }
        public int Error { get; set; }
        public Equipo Equipo { get; set; }
    }

    public class EquipoList
    {
        public string Info { get; set; }
        public int Error { get; set; }
        public List<Equipo> Lista { get; set; }
    }    


    // TABLA INTERMEDIA
    public class Usuario_Equipo
    {
        public Usuario Usuario { get; set; }
        public Equipo Equipo { get; set; }        
        public DateTime FechaCreacion { get; set; }
        public DateTime FechaModificacion { get; set; }
    }

    public class Usuario_EquipoList
    {
        public string Info { get; set; }
        public int Error { get; set; }
        public List<Usuario_Equipo> Lista { get; set; }
    }
}
