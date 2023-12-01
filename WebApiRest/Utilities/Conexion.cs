namespace WebApiRest.Utilities
{
    public class Conexion
    {
        // Esta es la cadena de coneccion
        private readonly string connectSqlServer = "";
        private readonly Settings settings = new();

        // Este es el constructor
        public Conexion()
        {
            var config = new ConfigurationBuilder().SetBasePath(Directory.GetCurrentDirectory()).AddJsonFile("appsettings.json").Build();
            connectSqlServer = config.GetSection("ConnectionStrings:SqlServer_BDD").Value;
            settings = config.GetSection("settings").Get<Settings>();
        }

        // Este es el metodo que retorna la cadena de conexion
        public string GetConnectionSqlServer()
        {
            return connectSqlServer;
        }

        public Settings GetSettings()
        {
            return settings;
        }
    }
}
