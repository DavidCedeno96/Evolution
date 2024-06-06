namespace WebApiRest.Models
{
    public class TipoEntrada
    {
        public Guid IdTipoEntrada { get; set; }
        public string Nombre { get; set; }
        public string Descripcion { get; set; }
        public int Estado { get; set; }
        public DateTime FechaCreacion { get; set; }
        public DateTime FechaModificacion { get; set; }        
    }

    public class TipoEntradaList
    {
        public string Info { get; set; }
        public int Error { get; set; }
        public List<TipoEntrada> Lista { get; set; }
    }
}
