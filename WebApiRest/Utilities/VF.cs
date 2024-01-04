using WebApiRest.Models;

namespace WebApiRest.Utilities
{
    // Esta clase es para Valid Forms
    public static class VF
    {
        // Usuario
        public static Response ValidarUsuario(Usuario usuario)
        {
            Response result = new();
            bool validForm = true;
            if (!RE.ValidRE(usuario.Nombre, "palabras"))
            {
                result.Error = 1;
                result.Info = WC.GetErrorLetras();
                result.Campo = "nombre";
                validForm = false;
            }
            if (!RE.ValidRE(usuario.Apellido, "palabras"))
            {
                result.Error = 1;
                result.Info = WC.GetErrorLetras();
                result.Campo = "apellido";
                validForm = false;
            }
            if (!RE.ValidRE(usuario.Correo, "email"))
            {
                result.Error = 1;
                result.Info = WC.GetErrorCorreo();
                result.Campo = "correo";
                validForm = false;
            }
            if (!RE.ValidRE(usuario.Contrasena, "clave"))
            {
                result.Error = 1;
                result.Info = WC.GetErrorClave();
                result.Campo = "clave";
                validForm = false;
            }
            if (!RE.ValidRE(usuario.Celular, "celular"))
            {
                result.Error = 1;
                result.Info = WC.GetErrorCelular();
                result.Campo = "celular";
                validForm = false;
            }            

            if (validForm)
            {
                result.Error = 0;
                result.Info = WC.GetSatisfactorio();
            }
            return result;
        }

        //Noticia
        public static Response ValidarNoticia(Noticia noticia)
        {
            Response result = new();
            bool validForm = true;
            if (!RE.ValidRE(noticia.Titular, "invalid"))
            {
                result.Error = 1;
                result.Info = WC.GetInvalid();
                result.Campo = "titular";
                validForm = false;
            }
            if (!RE.ValidRE(noticia.Descripcion, "invalid"))
            {
                result.Error = 1;
                result.Info = WC.GetInvalid();
                result.Campo = "descripcion";
                validForm = false;
            }
            if (!RE.ValidRE(noticia.Url, "invalid"))
            {
                result.Error = 1;
                result.Info = WC.GetInvalid();
                result.Campo = "url";
                validForm = false;
            }                        

            if (validForm)
            {
                result.Error = 0;
                result.Info = WC.GetSatisfactorio();
            }
            return result;
        }

        //Usuario_Noticia
        public static Response ValidarUsuarioNoticia(Usuario_Noticia usuarioNoticia)
        {
            Response result = new();
            bool validForm = true;
            if (!RE.ValidRE(usuarioNoticia.Comentario, "invalid"))
            {
                result.Error = 1;
                result.Info = WC.GetInvalid();
                result.Campo = "comentario";
                validForm = false;
            }            

            if (validForm)
            {
                result.Error = 0;
                result.Info = WC.GetSatisfactorio();
            }
            return result;
        }

        //Categoria Noticia
        public static Response ValidarCategoriaNoticia(CategoriaNoticia categoriaNoticia)
        {
            Response result = new();
            bool validForm = true;
            if (!RE.ValidRE(categoriaNoticia.Nombre, "palabras"))
            {
                result.Error = 1;
                result.Info = WC.GetErrorLetras();
                result.Campo = "nombre";
                validForm = false;
            }
            if (!RE.ValidRE(categoriaNoticia.Descripcion, "invalid"))
            {
                result.Error = 1;
                result.Info = WC.GetInvalid();
                result.Campo = "descripcion";
                validForm = false;
            }

            if (validForm)
            {
                result.Error = 0;
                result.Info = WC.GetSatisfactorio();
            }
            return result;
        }

        //Recompensa
        public static Response ValidarRecompensa(Recompensa recompensa)
        {
            Response result = new();
            bool validForm = true;
            if (!RE.ValidRE(recompensa.Nombre, "invalid"))
            {
                result.Error = 1;
                result.Info = WC.GetInvalid();
                result.Campo = "nombre";
                validForm = false;
            }
            if (!RE.ValidRE(recompensa.Descripcion, "invalid"))
            {
                result.Error = 1;
                result.Info = WC.GetInvalid();
                result.Campo = "descripcion";
                validForm = false;
            }            

            if (validForm)
            {
                result.Error = 0;
                result.Info = WC.GetSatisfactorio();
            }
            return result;
        }

        // archivos
        public static Response ValidarArchivo(IWebHostEnvironment _env, IFormFile archivo, string tipos, string nombreCarpeta)
        {
            Response result = new();
            bool validForm = true;
            string rutaArchivo = WC.GetRutaImagen(_env, archivo.FileName, nombreCarpeta);

            if (!WC.GetArchivoPermitido(tipos, archivo.FileName))
            {
                result.Error = 1;
                result.Info = WC.GetErrorArchivo();
                result.Campo = "imagen";
                validForm = false;
            }

            if (File.Exists(rutaArchivo))
            {
                result.Error = 1;
                result.Info = WC.GetArchivoExistente();
                result.Campo = "imagen";
                validForm = false;
            }

            if (!RE.ValidRE(archivo.FileName, "invalid"))
            {
                result.Error = 1;
                result.Info = WC.GetInvalid();
                result.Campo = "imagen";
                validForm = false;

            }
            else if (!RE.ValidRE(archivo.FileName, "50"))
            {
                result.Error = 1;
                result.Info = WC.GetMax50();
                result.Campo = "imagen";
                validForm = false;
            }

            if (archivo.Length > 600 * 1024)
            {
                result.Error = 1;
                result.Info = WC.GetErrorTamanoArchivo();
                result.Campo = "imagen";
                validForm = false;                
            }            

            if (validForm)
            {
                result.Error = 0;
                result.Info = WC.GetSatisfactorio();
            }
            return result;

        }
    }
}
