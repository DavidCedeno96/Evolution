namespace WebApiRest.Models
{
    public class Rol
    {
        public string IdRol { get; set; }
        public string Nombre { get; set; }
        public string Descripcion { get; set; }
        public int Estado { get; set; }
        public DateTime FechaCreacion { get; set; }
        public DateTime FechaModificacion { get; set; }
    }

    public class RolList
    {
        public int Error { get; set; }
        public string Info { get; set; }        
        public List<Rol> Lista { get; set; }
    }    
}
