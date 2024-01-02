namespace WebApiRest.Models
{
    public class TipoReto
    {
        public Guid IdTipoReto { get; set; }
        public string Nombre { get; set; }
        public string Descripcion { get; set; }
        public int Estado { get; set; }
        public DateTime FechaCreacion { get; set; }
        public DateTime FechaModificacion { get; set; }
    }

    public class TipoRetoList
    {
        public string Info { get; set; }
        public int Error { get; set; }
        public List<TipoReto> Lista { get; set; }
    }
}
