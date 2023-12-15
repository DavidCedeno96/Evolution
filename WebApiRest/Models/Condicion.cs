namespace WebApiRest.Models
{
    public class Condicion
    {
        public Guid IdCondicion { get; set; }
        public string Nombre { get; set; }
        public string Descripcion { get; set; }
        public int Estado { get; set; }
        public DateTime FechaCreacion { get; set; }
        public DateTime FechaModificacion { get; set; }
    }

    public class CondicionList
    {
        public string Info { get; set; }
        public int Error { get; set; }
        public List<Condicion> Lista { get; set; }
    }
}
