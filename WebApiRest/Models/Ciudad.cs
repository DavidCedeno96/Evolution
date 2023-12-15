namespace WebApiRest.Models
{
    public class Ciudad
    {
        public Guid IdCiudad { get; set; }
        public string Nombre { get; set; }
        public string Descripcion { get; set; }
        public Guid IdPais { get; set; }
        public string Pais { get; set; }
        public int Estado { get; set; }
        public DateTime FechaCreacion { get; set; }
        public DateTime FechaModificacion { get; set; }
    }

    public class CiudadList
    {
        public string Info { get; set; }
        public int Error { get; set; }
        public List<Ciudad> Lista { get; set; }
    }

    public class CiudadItem
    {
        public string Info { get; set; }
        public int Error { get; set; }
        public Ciudad Ciudad { get; set; }
    }
}
