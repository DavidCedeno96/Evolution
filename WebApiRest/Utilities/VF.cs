using System.Drawing;
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
            if (!RE.ValidRE(usuario.Id, "invalid"))
            {
                result.Error = 1;
                result.Info = WC.GetInvalid();
                result.Campo = "id único";
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
        public static Response ValidarCategoriaNoticia(Categoria categoriaNoticia)
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

        //Nivel
        public static Response ValidarNivel(Nivel nivel)
        {
            Response result = new();
            bool validForm = true;
            if (!RE.ValidRE(nivel.Nombre, "invalid"))
            {
                result.Error = 1;
                result.Info = WC.GetInvalid();
                result.Campo = "nombre";
                validForm = false;
            }
            if (!RE.ValidRE(nivel.Descripcion, "invalid"))
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

        //Medalla
        public static Response ValidarMedalla(Medalla medalla)
        {
            Response result = new();
            bool validForm = true;
            if (!RE.ValidRE(medalla.Nombre, "invalid"))
            {
                result.Error = 1;
                result.Info = WC.GetInvalid();
                result.Campo = "nombre";
                validForm = false;
            }
            if (!RE.ValidRE(medalla.Descripcion, "invalid"))
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

        //Pais
        public static Response ValidarPais(Pais pais)
        {
            Response result = new();
            bool validForm = true;
            if (!RE.ValidRE(pais.Nombre, "palabras"))
            {
                result.Error = 1;
                result.Info = WC.GetErrorLetras();
                result.Campo = "nombre";
                validForm = false;
            }
            if (!RE.ValidRE(pais.Descripcion, "invalid"))
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

        //Ciudad
        public static Response ValidarCiudad(Ciudad ciudad)
        {
            Response result = new();
            bool validForm = true;
            if (!RE.ValidRE(ciudad.Nombre, "palabras"))
            {
                result.Error = 1;
                result.Info = WC.GetErrorLetras();
                result.Campo = "nombre";
                validForm = false;
            }
            if (!RE.ValidRE(ciudad.Descripcion, "invalid"))
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

        //Empresa
        public static Response ValidarEmpresa(Empresa empresa)
        {
            Response result = new();
            bool validForm = true;
            if (!RE.ValidRE(empresa.Nombre, "invalid"))
            {
                result.Error = 1;
                result.Info = WC.GetInvalid();
                result.Campo = "nombre";
                validForm = false;
            }
            if (!RE.ValidRE(empresa.Descripcion, "invalid"))
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

        //Ciudad
        public static Response ValidarArea(Area area)
        {
            Response result = new();
            bool validForm = true;
            if (!RE.ValidRE(area.Nombre, "palabras"))
            {
                result.Error = 1;
                result.Info = WC.GetErrorLetras();
                result.Campo = "nombre";
                validForm = false;
            }
            if (!RE.ValidRE(area.Descripcion, "invalid"))
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

        //Reto
        public static Response ValidarReto(Reto reto)
        {
            Response result = new();
            bool validForm = true;
            if (!RE.ValidRE(reto.Nombre, "invalid"))
            {
                result.Error = 1;
                result.Info = WC.GetInvalid();
                result.Campo = "nombre";
                validForm = false;
            }
            if (!RE.ValidRE(reto.Instrucciones, "invalid"))
            {
                result.Error = 1;
                result.Info = WC.GetInvalid();
                result.Campo = "instrucciones";
                validForm = false;
            }

            if (validForm)
            {
                result.Error = 0;
                result.Info = WC.GetSatisfactorio();
            }
            return result;
        }

        //Equipo
        public static Response ValidarEquipo(Equipo equipo)
        {
            Response result = new();
            bool validForm = true;
            if (!RE.ValidRE(equipo.Nombre, "invalid"))
            {
                result.Error = 1;
                result.Info = WC.GetInvalid();
                result.Campo = "nombre";
                validForm = false;
            }
            if (!RE.ValidRE(equipo.Descripcion, "invalid"))
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

        //Opcion
        public static Response ValidarOpcion(Opcion opcion)
        {
            Response result = new();
            bool validForm = true;
            if (!RE.ValidRE(opcion.Nombre, "invalid"))
            {
                result.Error = 1;
                result.Info = WC.GetInvalid();
                result.Campo = "nombre";
                validForm = false;
            }            

            if (validForm)
            {
                result.Error = 0;
                result.Info = WC.GetSatisfactorio();
            }
            return result;
        }

        //Pregunta
        public static Response ValidarPregunta(Pregunta pregunta)
        {
            Response result = new();
            bool validForm = true;
            if (!RE.ValidRE(pregunta.Nombre, "invalid"))
            {
                result.Error = 1;
                result.Info = WC.GetInvalid();
                result.Campo = "nombre";
                validForm = false;
            }

            if (validForm)
            {
                result.Error = 0;
                result.Info = WC.GetSatisfactorio();
            }
            return result;
        }

        //RedSocial
        public static Response ValidarUsuarioRedSocial(Usuario_RedSocial usuarioRedSocial)
        {
            Response result = new();
            bool validForm = true;
            if (!RE.ValidRE(usuarioRedSocial.Comentario, "invalid"))
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

        //Configuracion
        public static Response ValidarConfiguracion(Configuracion configuracion)
        {
            Response result = new();
            bool validForm = true;
            if (!RE.ValidRE(configuracion.Tipo, "palabras"))
            {
                result.Error = 1;
                result.Info = WC.GetErrorLetras();
                result.Campo = "tipo";
                validForm = false;
            }
            if (!RE.ValidRE(configuracion.Propiedad, "invalid"))
            {
                result.Error = 1;
                result.Info = WC.GetInvalid();
                result.Campo = "propiedad";
                validForm = false;
            }
            if (!RE.ValidRE(configuracion.Nombre, "palabras"))
            {
                result.Error = 1;
                result.Info = WC.GetErrorLetras();
                result.Campo = "nombre";
                validForm = false;
            }
            if (!RE.ValidRE(configuracion.Valor, "invalid"))
            {
                result.Error = 1;
                result.Info = WC.GetInvalid();
                result.Campo = "valor";
                validForm = false;
            }
            if (!RE.ValidRE(configuracion.Descripcion, "invalid"))
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

        //Noticia
        public static Response ValidarNotificacion(Notificacion notificacion)
        {
            Response result = new();
            bool validForm = true;
            if (!RE.ValidRE(notificacion.MsgPersonalizado, "invalid"))
            {
                result.Error = 1;
                result.Info = WC.GetInvalid();
                result.Campo = "mensaje personalizado";
                validForm = false;
            }
            if(notificacion.Estado > 1 || notificacion.Estado < 0)
            {
                result.Error = 1;
                result.Info = WC.GetErrorEstado();
                result.Campo = "estado";
                validForm = false;
            }
            if(notificacion.NumDesc > 400 || notificacion.NumDesc < 0)
            {
                result.Error = 1;
                result.Info = "El NumDesc no puede ser menor a 0 o mayor a 400";
                result.Campo = "estado";
                validForm = false;
            }

            if (validForm)
            {
                result.Error = 0;
                result.Info = WC.GetSatisfactorio();
            }
            return result;
        }

        //Correo de envio
        public static Response ValidarCorreoEnvio(CorreoEnvio correoEnvio)
        {
            Response result = new();
            bool validForm = true;
            //if (!RE.ValidRE(correoEnvio.Correo, "email"))
            //{
            //    result.Error = 1;
            //    result.Info = WC.GetErrorCorreo();
            //    result.Campo = "correo";
            //    validForm = false;
            //}

            if (!RE.ValidRE(correoEnvio.Correo, "invalid"))
            {
                result.Error = 1;
                result.Info = WC.GetInvalid();
                result.Campo = "correo";
                validForm = false;
            }

            if (!RE.ValidRE(correoEnvio.Password, "invalid"))
            {
                result.Error = 1;
                result.Info = WC.GetInvalid();
                result.Campo = "password";
                validForm = false;
            }            

            if (!RE.ValidRE(correoEnvio.Host, "invalid"))
            {
                result.Error = 1;
                result.Info = WC.GetInvalid();
                result.Campo = "host";
                validForm = false;
            }

            if (validForm)
            {
                result.Error = 0;
                result.Info = WC.GetSatisfactorio();
            }
            return result;
        }

        //Licencia
        public static Response ValidarLicencia(Licencia licencia)
        {
            Response result = new();
            bool validForm = true;
            if (!RE.ValidRE(licencia.Tabla, "palabras"))
            {
                result.Error = 1;
                result.Info = WC.GetErrorLetras();
                result.Campo = "tabla";
                validForm = false;
            }
            if (!RE.ValidRE(licencia.Nombre, "palabras"))
            {
                result.Error = 1;
                result.Info = WC.GetErrorLetras();
                result.Campo = "nombre";
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
        public static Response ValidarArchivo(IWebHostEnvironment _env, IFormFile archivo, string tipos, string nombreCarpeta, int pesoMaximoKB = 200, int widthMax = 360, int heightMax = 360)
        {
            Response result = new();
            bool validForm = true;
            //string rutaArchivo = WC.GetRutaImagen(_env, archivo.FileName, nombreCarpeta);
            Size dimensions = WC.GetImageDimensions(archivo);

            if (!WC.GetArchivoPermitido(tipos, archivo.FileName))
            {
                result.Error = 1;
                result.Info = WC.GetErrorArchivo();
                result.Campo = "archivo";
                validForm = false;
            }

            //if (File.Exists(rutaArchivo))
            //{
            //    result.Error = 1;
            //    result.Info = WC.GetArchivoExistente()+": "+archivo.FileName;
            //    result.Campo = "archivo";
            //    validForm = false;
            //}

            //if (!RE.ValidRE(archivo.FileName, "invalid"))
            //{
            //    result.Error = 1;
            //    result.Info = WC.GetInvalid();
            //    result.Campo = "archivo";
            //    validForm = false;

            //}

            //else if (!RE.ValidRE(archivo.FileName, "50"))
            //{
            //    result.Error = 1;
            //    result.Info = WC.GetMax50();
            //    result.Campo = "archivo";
            //    validForm = false;
            //}

            if (archivo.Length > pesoMaximoKB * 1024)
            {
                result.Error = 1;
                result.Info = $"El archivo no puede superar los {pesoMaximoKB} KB";
                result.Campo = "archivo";
                validForm = false;                
            }
            
            if (!dimensions.IsEmpty)
            {                 
                 if(dimensions.Width > widthMax || dimensions.Height > heightMax)
                 {
                    result.Error = 1;
                    result.Info = $"El archivo no puede superar los {widthMax}x{heightMax} pixeles";
                    result.Campo = "archivo";
                    validForm = false;
                 }
            }            

            if (validForm)
            {
                result.Error = 0;
                result.Info = WC.GetSatisfactorio();
            }
            return result;

        }

        public static Response ValidarArchivos(IWebHostEnvironment _env, List<IFormFile> archivos, string tipos, string nombreCarpeta, int pesoMaximo = 200, int widthMax = 360, int heightMax = 360, string tipoPeso = "KB")
        {
            Response result = new();
            bool validForm = true;

            if(archivos.Count > 0)
            {
                foreach (IFormFile archivo in archivos)
                {
                    string rutaArchivo = WC.GetRutaArchivo(_env, archivo.FileName, nombreCarpeta);
                    Size dimensions = WC.GetImageDimensions(archivo);

                    if (!WC.GetArchivoPermitido(tipos, archivo.FileName))
                    {
                        result.Error = 1;
                        result.Info = WC.GetErrorArchivo();
                        result.Campo = "archivo";
                        validForm = false;
                    }

                    if (File.Exists(rutaArchivo))
                    {
                        result.Error = 1;
                        result.Info = WC.GetArchivoExistente() + ": " + archivo.FileName;
                        result.Campo = "archivo";
                        validForm = false;
                    }

                    if (!RE.ValidRE(archivo.FileName, "invalid"))
                    {
                        result.Error = 1;
                        result.Info = WC.GetInvalid();
                        result.Campo = "archivo";
                        validForm = false;

                    }
                    else if (!RE.ValidRE(archivo.FileName, "50"))
                    {
                        result.Error = 1;
                        result.Info = WC.GetMax50();
                        result.Campo = "archivo";
                        validForm = false;
                    }

                    if (archivo.Length > pesoMaximo * 1024)
                    {
                        result.Error = 1;
                        result.Info = $"El archivo no puede superar los {pesoMaximo} {tipoPeso}";
                        result.Campo = "archivo";
                        validForm = false;
                    }

                    if (!dimensions.IsEmpty && widthMax > 0 && heightMax > 0)
                    {
                        if (dimensions.Width > widthMax || dimensions.Height > heightMax)
                        {
                            result.Error = 1;
                            result.Info = $"El archivo no puede superar los {widthMax}x{heightMax} pixeles";
                            result.Campo = "archivo";
                            validForm = false;
                        }
                    }

                    if(result.Error == 1) {
                        break;
                    }
                }
            }


            if (validForm)
            {
                result.Error = 0;
                result.Info = WC.GetSatisfactorio();
            }
            return result;

        }

        public static Response ValidarCaracteres(List<string> listCaracteres)
        {
            Response result = new();
            bool validForm = true;

            if(listCaracteres.Count > 0)
            {
                foreach (string item in listCaracteres)
                {
                    if (!RE.ValidRE(item, "invalid"))
                    {
                        result.Error = 1;
                        result.Info = WC.GetInvalid();
                        result.Campo = "archivo";
                        validForm = false;
                        break;
                    }
                }
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
