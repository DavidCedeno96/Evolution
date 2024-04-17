namespace WebApiRest.Models
{
    public class Notificacion
    {
        public Guid IdNotificacion { get; set; }
        public string Nombre { get; set; }
        public int Estado { get; set; }
        public string MsgPersonalizado { get; set; }
        public string Descripcion { get; set; }
        public int NumDesc { get; set; }
        public int EnviarCorreo { get; set; }
        public DateTime FechaCreacion { get; set; }
        public DateTime FechaModificacion { get; set; }
    }

    public class NotificacionItem
    {
        public string Info { get; set; }
        public int Error { get; set; }
        public Notificacion Notificacion { get; set; }
    }

    public class NotificacionList
    {
        public string Info { get; set; }
        public int Error { get; set; }
        public List<Notificacion> Lista { get; set; }
    }
}
