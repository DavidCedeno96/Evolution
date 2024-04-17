namespace WebApiRest.Models
{
    public class Licencia
    {
        public Guid IdLicencia { get; set; }
        public string Tabla { get; set; }
        public string Nombre { get; set; }
        public int CantUsada { get; set; }
        public int CantMax { get; set; }
        public int PorcentajeUso { get; set; }
        public int Estado { get; set; }
        public DateTime FechaCreacion { get; set; }
        public DateTime FechaModificacion { get; set; }
    }

    public class LicenciaList
    {
        public string Info { get; set; }
        public int Error { get; set; }
        public List<Licencia> Lista { get; set; }
    }
}
