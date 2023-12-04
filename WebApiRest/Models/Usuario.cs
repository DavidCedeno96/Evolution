namespace WebApiRest.Models
{
    public class Usuario
    {
        public Guid IdUsuario { get; set; }
        public string Nombre { get; set; }
        public string Apellido { get; set; }
        public string Correo { get; set; }
        public string Contrasena { get; set; }        
        public string Celular { get; set; }
        public string Foto { get; set; }
        public string IdRol { get; set; }
        public string Rol { get; set; }
        public string Pais { get; set; }
        public string Ciudad { get; set; }
        public string Empresa { get; set; }
        public string IdArea{ get; set; }
        public string Area { get; set; }
        public int Estado { get; set; }
        public DateTime FechaCreacion { get; set; }
        public DateTime FechaModificacion { get; set; }
    }

    public class UsuarioList
    {
        public string Info { get; set; }
        public int Error { get; set; }
        public List<Usuario> Lista { get; set; }
    }

    public class UsuarioItem
    {
        public string Info { get; set; }
        public int Error { get; set; }
        public Usuario Usuario { get; set; }
    }
}
