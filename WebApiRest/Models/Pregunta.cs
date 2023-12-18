namespace WebApiRest.Models
{
    public class Pregunta
    {
        public Guid IdPregunta { get; set; }
        public string Nombre { get; set; }
        public int Estado { get; set; }
        public Guid IdReto { get; set; }
        public DateTime FechaCreacion { get; set; }
        public DateTime FechaModificacion { get; set; }
    }

    public class PreguntaList
    {
        public string Info { get; set; }
        public int Error { get; set; }
        public List<Pregunta> Lista { get; set; }
    }
}
