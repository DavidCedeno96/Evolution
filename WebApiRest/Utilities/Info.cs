using WebApiRest.Models;

namespace WebApiRest.Utilities
{
    public class Settings
    {
        public string Origin { get; set; }
        public string SecretKey { get; set; }        
        public int TimeExpTokenMin { get; set; }
        public bool Production { get; set; }
        public bool HttpsClient { get; set; }
    }

    public class CorreoEnvio
    {
        public Guid IdCorreo { get; set; }
        public string Correo { get; set; }
        public string Password { get; set; }
        public int Puerto { get; set; }
        public string Host { get; set; }
        public string Imagen { get; set; }
        public string ColorPrimario { get; set; }
        public string ColorSecundario { get; set; }
        public string ColorTerciario { get; set; }
        public string Url { get; set; }
    }

    public class CorreoEnvioItem
    {
        public string Info { get; set; }
        public int Error { get; set; }
        public CorreoEnvio CorreoEnvio { get; set; }
    }
}
