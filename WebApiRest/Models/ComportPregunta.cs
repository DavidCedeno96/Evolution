namespace WebApiRest.Models
{
    public class ComportPregunta
    {
        public Guid IdComportamiento { get; set; }
        public string Nombre { get; set; }
        public string Descripcion { get; set; }
        public int Estado { get; set; }
        public DateTime FechaCreacion { get; set; }
        public DateTime FechaModificacion { get; set; }
    }

    public class ComportPreguntaList
    {
        public string Info { get; set; }
        public int Error { get; set; }
        public List<ComportPregunta> Lista { get; set; }
    }
}