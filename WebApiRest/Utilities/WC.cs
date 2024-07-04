using NPOI.HSSF.UserModel;
using System.Drawing;
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
        private static readonly string errorLogin = "Usuario no encontrado";        
        private static readonly string errorLetrasNumeros = "Solo se permiten letras y números";
        private static readonly string errorLetras = "Solo se permiten letras";
        private static readonly string errorNumeros = "Solo se permiten números";
        private static readonly string errorCorreo = "Ingrese un correo válido";
        private static readonly string errorCelular = "Solo se permiten números y debe ser de 9 dígitos";
        private static readonly string errorClave = "Debe tener al menos 5 caracteres de longitud, contener al menos un número, contener al menos una letra mayúscula, contener al menos una letra minúscula o solo los siguientes caracteres #@_-.";
        private static readonly string errorEstado = "Estado Incorrecto";
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

            if(string.IsNullOrEmpty(nombreArchivo)) { 
                return rutaPrincipal; 
            }

            return Path.Combine(rutaPrincipal, nombreArchivo.Trim());
        }

        public static string GetFileExtension(IFormFile file)
        {
            if (file != null)
            {                
                return Path.GetExtension(file.FileName).ToLower(); //.xlsx .pdf .png .jpg
            }
            return "";
        }

        public static string GetTrim(string cadena)
        {
            if (cadena != null)
            {
                return cadena.Trim();
            }
            return "";
        }

        public static Size GetImageDimensions(IFormFile file)
        {
            if (file != null)
            {
                if(GetArchivoPermitido("jpg/jpeg/png", file.FileName))
                {
                    using var stream = file.OpenReadStream();
                    using var image = SixLabors.ImageSharp.Image.Load(stream);
                    return new Size(image.Width, image.Height);
                }
                else
                {
                    return new Size(0, 0);
                }
            }
            else
            {
                return new Size(0, 0);  
            }
        }

        public static string GetUniqueFileName(IFormFile file, string info)
        {
            Guid newId = Guid.NewGuid();            
            return $"{info}_{newId}{GetFileExtension(file)}";
        }

        public static byte[] GetBytes(string texto)
        {
            if (!string.IsNullOrEmpty(texto))
            {
                return Encoding.UTF8.GetBytes(texto);
            }
            return null;
        }

        public static byte[] GetBytesExcel(HSSFWorkbook workbook)
        {
            using MemoryStream ms = new();
            workbook.Write(ms);
            return ms.ToArray();
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

        public static string GetLetraByNumero(int numero)
        {
            string letra = "";
            while (numero > 0)
            {
                numero--;
                letra = (char)('A' + (numero % 26)) + letra;
                numero /= 26;
            }
            return letra;
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

        public static void EliminarArchivo(IWebHostEnvironment env, string nombreCarpeta, string infoNombreArchivo)
        {
            string rutaArchivos = Path.Combine(env.ContentRootPath, "wwwroot", "Content", "Archivos", nombreCarpeta);
            string[] infoArchivos = Directory.GetFiles(rutaArchivos);

            List<FileInfo> archivos = infoArchivos
                .Select(archivo => new FileInfo(archivo))
                .Where(info => info.Name.Contains(infoNombreArchivo))
                .ToList();

            if (archivos.Count > 0)
            {
                foreach (var archivo in archivos)
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

            if (!string.IsNullOrEmpty(tipos))
            {
                List<string> tiposList = tipos.Split("/").ToList();
                foreach (string tipo in tiposList)
                {
                    if (extension.Contains(tipo))
                    {
                        return true;
                    }
                }
            }            

            return false;
        }

        public static string GenerarContrasena()
        {
            Random random = new();

            string caracteresPermitidos = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789@.-_#$";
            int longitud = random.Next(5, 21);

            char[] password = new char[longitud];

            // Asegurar que hay al menos un carácter de cada tipo
            password[0] = caracteresPermitidos[random.Next(26)]; // al menos una letra minúscula
            password[1] = caracteresPermitidos[random.Next(26, 52)]; // al menos una letra mayúscula
            password[2] = caracteresPermitidos[random.Next(52, 62)]; // al menos un número
            password[3] = caracteresPermitidos[random.Next(62, 66)]; // al menos un carácter especial

            // Rellenar el resto de la contraseña con caracteres aleatorios
            for (int i = 4; i < longitud; i++)
            {
                password[i] = caracteresPermitidos[random.Next(caracteresPermitidos.Length)];
            }

            // Mezclar los caracteres para mayor aleatoriedad
            for (int i = 0; i < longitud; i++)
            {
                int j = random.Next(i, longitud);
                (password[j], password[i]) = (password[i], password[j]);
            }

            return new string(password);
        }

        //public static async Task<Response> EnviarMail(CorreoEnvio correoEnvio, string correoUsuario, string asunto, string body) // EL body SI SE PUEDE PONER UN HTML EN UN STRING
        //{
        //    Response response = new();
        //    MimeMessage message = new();
        //    SmtpClient smtpClient = new();                   

        //    message.From.Add(MailboxAddress.Parse(GetTrim(correoEnvio.Correo)));
        //    message.To.Add(MailboxAddress.Parse(GetTrim(correoUsuario)));
        //    message.Subject = asunto;
        //    message.Body = new TextPart(TextFormat.Html) { Text = body };

        //    try
        //    {
        //        await smtpClient.ConnectAsync(correoEnvio.Host, correoEnvio.Puerto, SecureSocketOptions.StartTls);
        //        await smtpClient.AuthenticateAsync(correoEnvio.Correo, correoEnvio.Password);
        //        await smtpClient.SendAsync(message);

        //        response.Info = correoEnviado;
        //        response.Error = 0;
        //    }
        //    catch (Exception ex)
        //    {
        //        response.Info = ex.Message;
        //        response.Error = 1;
        //    }
        //    finally
        //    {
        //        await smtpClient.DisconnectAsync(true);
        //    }

        //    return response;
        //}        

        public static string GetOpcionComportamiento(int index)
        {
            switch (index) {
                case 1:
                    {
                        return "Nunca";
                    }
                case 2:
                    {
                        return "Rara Vez";
                    }
                case 3:
                    {
                        return "A Veces";
                    }
                case 4:
                    {
                        return "Frecuentemente";
                    }
                case 5:
                    {
                        return "Siempre";
                    }
                default: {
                        return "";
                    }
            }
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
        public static string GetErrorEstado()
        {
            return errorEstado;
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
