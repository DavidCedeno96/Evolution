namespace WebApiRest.Models
{
    public class Opcion
    {
        public Guid IdOpcion { get; set; }
        public string Nombre { get; set; }
        public string Correcta { get; set; }
        public string  Estado { get; set; }
        public Guid IdPregunta { get; set; }
        public DateTime FechaCreacion { get; set; }
        public DateTime FechaModificacion { get; set; }
    }

    public class OpcionList
    {
        public string Info { get; set; }
        public int Error { get; set; }
        public List<Opcion> Lista { get; set; }
    }
}
