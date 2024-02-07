namespace WebApiRest.Models
{
    public class Pais
    {
        public Guid IdPais { get; set; }
        public string Nombre { get; set; }
        public string Descripcion { get; set; }
        public int Estado { get; set; }
        public DateTime FechaCreacion { get; set; }
        public DateTime FechaModificacion { get; set; }
    }

    public class PaisItem
    {
        public string Info { get; set; }
        public int Error { get; set; }
        public Pais Pais { get; set; }
    }

    public class PaisList
    {
        public string Info { get; set; }
        public int Error { get; set; }
        public List<Pais> Lista { get; set; }
    }    
}
