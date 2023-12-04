namespace WebApiRest.Utilities
{
    public class Settings
    {
        public string Origin { get; set; }
        public string SecretKey { get; set; }
        public string HasherKey { get; set; }         
        public int TimeExpTokenMin { get; set; }
        public bool Production { get; set; }
        public bool HttpsClient { get; set; }
    }

    public class CorreoEnvio
    {
        public string Correo { get; set; }
        public string Password { get; set; }
        public int Puerto { get; set; }
        public string Host { get; set; }
    }
}
