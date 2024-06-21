namespace WebApiRest.Models
{
    public class Opcion
    {
        public Guid IdOpcion { get; set; }
        public string Nombre { get; set; }
        public int Correcta { get; set; }
        public int Valor { get; set; }
        public int CantVotos { get; set; }
        public int CantVotosXvalor { get; set; }
        public int  Estado { get; set; }
        public Guid IdPregunta { get; set; }
        public Guid IdTipoEntrada { get; set; }
        public string TipoEntrada { get; set; }
        public DateTime FechaCreacion { get; set; }
        public DateTime FechaModificacion { get; set; }
    }

    public class OpcionList
    {
        public string Info { get; set; }
        public int Error { get; set; }
        public List<Opcion> Lista { get; set; }
    }

    public class UsuarioxOpcion
    {
        public Guid IdOpcion { get; set; }
        public Guid IdUsuario { get; set; }
        public string Respuesta { get; set; }
        public string IdUserValidador { get; set; }
        public DateTime FechaCreacion { get; set; }
        public DateTime FechaModificacion { get; set; }
    }
}
