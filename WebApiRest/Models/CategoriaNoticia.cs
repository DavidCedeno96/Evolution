namespace WebApiRest.Models
{
    public class Categoria
    {
        public Guid IdCategoria { get; set; }
        public string Nombre { get; set; }
        public string Descripcion { get; set; }
        public int Estado { get; set; }
        public DateTime FechaCreacion { get; set; }
        public DateTime FechaModificacion { get; set; }
    }

    public class CategoriaItem
    {
        public string Info { get; set; }
        public int Error { get; set; }
        public Categoria CategoriaNoticia { get; set; } 
    }

    public class CategoriaList
    {
        public string Info { get; set; }
        public int Error { get; set; }
        public List<Categoria> Lista { get; set; }
    }
}
