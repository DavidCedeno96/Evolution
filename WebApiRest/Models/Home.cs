namespace WebApiRest.Models
{
    public class Home
    {
        public Guid IdConfigInicio { get; set; }
        public string Nombre { get; set; }
        public int Indice { get; set; }
        public string Color { get; set; }
        public string IdRol { get; set; }
        public int Estado { get; set; }
        public DateTime FechaCreacion { get; set; }
        public DateTime FechaModificacion { get; set; }
    }

    public class HomeList
    {
        public string Info { get; set; }
        public int Error { get; set; }
        public List<Home> Lista { get; set; }
    }


    public class Preuba
    {
        public string Text { get; set; }        
    }
}
