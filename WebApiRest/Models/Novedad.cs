namespace WebApiRest.Models
{
    public class Novedad
    {
        public Guid IdNovedad { get; set; }
        public string Mensaje { get; set; }
        public string AuxMsg { get; set; }
        public Guid IdUsuario { get; set; }
        public Guid IdTabla { get; set; }
        public string Tabla { get; set; }
        public string Ruta { get; set; }
        public int Estado { get; set; }
        public DateTime FechaCreacion { get; set; }
        public DateTime FechaModificacion { get; set; }
    }

    public class NovedadList
    {
        public string Info { get; set; }
        public int Error { get; set; }
        public List<Novedad> Lista { get; set; }
    }
}
