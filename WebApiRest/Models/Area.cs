namespace WebApiRest.Models
{
    public class Area
    {
        public Guid IdArea { get; set; }
        public string Nombre { get; set; }
        public string Descripcion { get; set; }
        public Guid IdEmpresa { get; set; }
        public string Empresa { get; set; }
        public int Estado { get; set; }        
        public DateTime FechaCreacion { get; set; }
        public DateTime FechaModificacion { get; set; }
    }

    public class AreaItem
    {
        public string Info { get; set; }
        public int Error { get; set; }
        public Area Area { get; set; }
    }

    public class AreaList
    {
        public string Info { get; set; }
        public int Error { get; set; }
        public List<Area> Lista { get; set; }
    }    
}
