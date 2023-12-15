namespace WebApiRest.Models
{
    public class Configuracion
    {
        public Guid IdConfig { get; set; }
        public string Tipo { get; set; }
        public string Propiedad { get; set; }
        public string Nombre { get; set; }
        public string Valor { get; set; }
        public string Descripcion { get; set; }
        public Guid IdUsuario { get; set; }
        public string Usuario { get; set; }
        public DateTime FechaCreacion { get; set; }
        public DateTime FechaModificacion { get; set; }
    }

    public class ConfiguracionList
    {
        public string Info { get; set; }
        public int Error { get; set; }
        public List<Configuracion> Lista { get; set; }
    }
}
