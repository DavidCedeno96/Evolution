using System.Text;

namespace WebApiRest.Utilities
{

    // Esta clase es para Web Constants
    public static class WC
    {
        private static readonly string satisfactorio = "Satisfactorio";
        private static readonly string error = "Ha ocurrido un error, intentalo más tarde";
        private static readonly string archivoExistente = "El archivo ya existe";        
        private static readonly string errorArchivo = "Tipo de archivo no permitido";
        private static readonly string errorTamanoArchivo = "El tamaño del archivo no puede superar los 600 KB.";
        private static readonly string errorLogin = "Usuario no encontrado";        
        private static readonly string errorLetrasNumeros = "Solo se permiten letras y números";
        private static readonly string errorLetras = "Solo se permiten letras";
        private static readonly string errorNumeros = "Solo se permiten números";
        private static readonly string errorCorreo = "Ingrese un correo válido";
        private static readonly string errorCelular = "Solo se permiten números y debe ser de 10 dígitos";
        private static readonly string errorClave = "Debe tener al menos 5 caracteres de longitud, contener al menos un número, contener al menos una letra mayúscula, contener al menos una letra minúscula o solo los siguientes caracteres #@_-.";
        private static readonly string invalid = "Tiene cacarteres invalidos";
        private static readonly string max50 = "Máximo 50 caracteres";        

        public static string GetRutaImagen(IWebHostEnvironment env, string nombreImagen, string nombreCarpeta)
        {
            string rutaPrincipal = Path.Combine(env.ContentRootPath, "wwwroot", "Content", "Images", nombreCarpeta);
            return Path.Combine(rutaPrincipal, nombreImagen.Trim());
        }

        public static string GetRutaArchivo(IWebHostEnvironment env, string nombreArchivo, string nombreCarpeta)
        {
            string rutaPrincipal = Path.Combine(env.ContentRootPath, "wwwroot", "Content", "Archivos", nombreCarpeta);
            return Path.Combine(rutaPrincipal, nombreArchivo.Trim());
        }

        public static string GetTrim(string cadena)
        {
            if (cadena != null)
            {
                return cadena.Trim();
            }
            return "";
        }

        public static byte[] GetBytes(string texto)
        {
            if (!string.IsNullOrEmpty(texto))
            {
                return Encoding.UTF8.GetBytes(texto);
            }
            return null;
        }

        public static string GetString(byte[] byteArray)
        {
            if (byteArray.Length > 0)
            {
                return Encoding.UTF8.GetString(byteArray);
            }
            return "";
        }


        public static string GetHoraActual(DateTime dateTime)
        {
            int hora = dateTime.Hour;
            int minuto = dateTime.Minute;
            int segundo = dateTime.Second;
            int miliSegundo = dateTime.Millisecond;

            return $"_{hora}-{minuto}-{segundo}-{miliSegundo}";
        }

        public static void EliminarArchivosAntiguos(IWebHostEnvironment env, string nombreCarpeta, string infoNombreArchivo)
        {
            string rutaArchivos = Path.Combine(env.ContentRootPath, "wwwroot", "Content", "Archivos", nombreCarpeta);
            string[] archivos = Directory.GetFiles(rutaArchivos);
            DateTime fechaHoy = DateTime.Now.Date;

            List<FileInfo> archivosAntiguos = archivos
                .Select(archivo => new FileInfo(archivo))
                .Where(info => !fechaHoy.Equals(info.LastWriteTime.Date) && info.Name.Contains(infoNombreArchivo))
                .ToList();

            if (archivosAntiguos.Count > 0)
            {
                foreach (var archivo in archivosAntiguos)
                {
                    if (File.Exists(archivo.FullName))
                    {
                        File.Delete(archivo.FullName);
                    }
                }
            }
        }

        public static bool GetArchivoPermitido(string tipos, string nombreArchivo)
        {
            string extension = Path.GetExtension(nombreArchivo.ToLower());
            List<string> tiposList = tipos.Split("/").ToList();
            foreach (string tipo in tiposList)
            {
                if (extension.Contains(tipo))
                {
                    return true;
                }
            }

            return false;
        }

        public static string GetSatisfactorio()
        {
            return satisfactorio;
        }
        public static string GetError()
        {
            return error;
        }
        public static string GetErrorLogin()
        {
            return errorLogin;
        }
        public static string GetErrorArchivo()
        {
            return errorArchivo;
        }
        public static string GetErrorTamanoArchivo()
        {
            return errorTamanoArchivo;
        }
        public static string GetArchivoExistente()
        {
            return archivoExistente;
        }
        public static string GetErrorLetrasNumeros()
        {
            return errorLetrasNumeros;
        }
        public static string GetErrorLetras()
        {
            return errorLetras;
        }
        public static string GetErrorCorreo()
        {
            return errorCorreo;
        }
        public static string GetErrorCelular()
        {
            return errorCelular;
        }
        public static string GetErrorNumeros()
        {
            return errorNumeros;
        }
        public static string GetErrorClave()
        {
            return errorClave;
        }
        public static string GetInvalid()
        {
            return invalid;
        }
        public static string GetMax50()
        {
            return max50;
        }
    }
}
