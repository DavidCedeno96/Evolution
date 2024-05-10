namespace WebApiRest.Models
{
    public class TipoEncuesta
    {
        public Guid IdTipoEncuesta { get; set; }
        public string Nombre { get; set; }
        public string Descripcion { get; set; }
        public int Estado { get; set; }
        public DateTime FechaCreacion { get; set; }
        public DateTime FechaModificacion { get; set; }        
    }

    public class TipoEncuestaList
    {
        public string Info { get; set; }
        public int Error { get; set; }
        public List<TipoEncuesta> Lista { get; set; }
    }
}
