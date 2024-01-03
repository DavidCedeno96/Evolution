namespace WebApiRest.Models
{
    public class Empresa
    {
        public Guid IdEmpresa { get; set; }
        public string Nombre { get; set; }
        public string Descripcion { get; set; }
        public int Estado { get; set; }
        public DateTime FechaCreacion { get; set; }
        public DateTime FechaModificacion { get; set; }
    }

    public class EmpresaList
    {
        public string Info { get; set; }
        public int Error { get; set; }
        public List<Empresa> Lista { get; set; }
    }    
}
