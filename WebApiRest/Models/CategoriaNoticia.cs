namespace WebApiRest.Models
{
    public class CategoriaNoticia
    {
        public Guid IdCategoria { get; set; }
        public string Nombre { get; set; }
        public string Descripcion { get; set; }
        public int Estado { get; set; }
        public DateTime FechaCreacion { get; set; }
        public DateTime FechaModificacion { get; set; }
    }

    public class CategoriaNoticiaList
    {
        public string Info { get; set; }
        public int Error { get; set; }
        public List<CategoriaNoticia> Lista { get; set; }
    }
}
