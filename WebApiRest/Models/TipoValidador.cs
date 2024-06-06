namespace WebApiRest.Models
{
    public class TipoValidador
    {
        public Guid IdTipoValidador { get; set; }
        public string Nombre { get; set; }
        public string Descripcion { get; set; }
        public int Estado { get; set; }
        public DateTime FechaCreacion { get; set; }
        public DateTime FechaModificacion { get; set; }        
    }

    public class TipoValidadorItem
    {
        public string Info { get; set; }
        public int Error { get; set; }
        public TipoValidador TipoValidador { get; set; }
    }

    public class TipoValidadorList
    {
        public string Info { get; set; }
        public int Error { get; set; }
        public List<TipoValidador> Lista { get; set; }
    }
}
