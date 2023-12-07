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
            if (!RE.ValidRE(usuario.Pais, "palabras"))
            {
                result.Error = 1;
                result.Info = WC.GetErrorLetras();
                result.Campo = "pais";
                validForm = false;
            }
            if (!RE.ValidRE(usuario.Ciudad, "palabras"))
            {
                result.Error = 1;
                result.Info = WC.GetErrorLetras();
                result.Campo = "ciudad";
                validForm = false;
            }
            if (!RE.ValidRE(usuario.Empresa, "invalid"))
            {
                result.Error = 1;
                result.Info = WC.GetInvalid();
                result.Campo = "empresa";
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

            if (validForm)
            {
                result.Error = 0;
                result.Info = WC.GetSatisfactorio();
            }
            return result;

        }
    }
}
