namespace WebApiRest.Models
{
    public class TipoArchivo
    {
        public Guid IdTipoArchivo { get; set; }
        public string Nombre { get; set; }
        public string Descripcion { get; set; }
        public int Estado { get; set; }
        public DateTime FechaCreacion { get; set; }
        public DateTime FechaModificacion { get; set; }        
    }

    public class TipoArchivoList
    {
        public string Info { get; set; }
        public int Error { get; set; }
        public List<TipoArchivo> Lista { get; set; }
    }
}
