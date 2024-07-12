using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using System.Security.Claims;
using WebApiRest.Data;
using WebApiRest.Models;
using WebApiRest.Utilities;
using System.IO;
using System.IO.Compression;
using MathNet.Numerics.Distributions;
using NPOI.HPSF;
using SixLabors.ImageSharp;

namespace WebApiRest.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class RetoController : ControllerBase
    {        
        readonly RetoData data = new();
        readonly OpcionData dataOpcion = new();
        readonly TipoValidadorData dataTipoValidador = new();

        private readonly IWebHostEnvironment _env;
        private readonly string nombreCarpeta = "Reto";        

        public RetoController(IWebHostEnvironment env)
        {
            _env = env;
        }

        [HttpGet]
        [Route("list/{estado}")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> GetList([FromRoute] int estado)
        {
            string userId = User.FindFirst("id").Value;
            RetoList response = await data.GetRetoList(estado, new Guid(userId));
            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpGet]
        [Route("buscar")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> List([FromQuery] string texto)
        {
            string userId = User.FindFirst("id").Value;
            RetoList response = await data.GetRetoList(texto, new Guid(userId));
            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpGet]
        [Route("item/{estado}/{idReto}")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> GetById([FromRoute] int estado, [FromRoute] Guid idReto)
        {
            RetoItem response = await data.GetReto(estado, idReto);
            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpGet]
        [Route("ranking/{top}")]
        [Authorize]
        public async Task<IActionResult> Ranking([FromRoute] int top)
        {
            string userId = User.FindFirst("id").Value;
            Usuario_RetoList response = await data.GetUsuarioRetoPuntosList(new Guid(userId), top);
            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpGet]
        [Route("usuarioRetoByIdReto/{idReto}/{validador}")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> GetUsuarioRetoByIdReto([FromRoute] Guid idReto, [FromRoute] int validador)
        {
            Usuario_RetoList response = await data.GetUsuarioRetoList(idReto, validador);
            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpGet]
        [Route("usuarioRetoByIdUsuario")]
        [Authorize]
        public async Task<IActionResult> GetUsuarioRetoByIdUsuario()
        {
            string userId = User.FindFirst("id").Value;
            Usuario_RetoList response = await data.GetUsuarioRetoList(-1, new Guid(userId), -1);
            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpGet]
        [Route("usuarioRetoByIdUsuarioYIdReto/{idReto}")]
        [Authorize]
        public async Task<IActionResult> GetUsuarioRetoByIdUsuarioYIdReto([FromRoute] Guid idReto)
        {
            string userId = User.FindFirst("id").Value;
            Usuario_RetoItem response = await data.GetUsuarioRetoList(idReto, new Guid(userId), -1);
            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpGet]
        [Route("buscarUsuarioRetoByIdUsuario")]
        [Authorize]
        public async Task<IActionResult> GetUsuarioRetoByIdUsuario([FromQuery] string texto)
        {
            string userId = User.FindFirst("id").Value;
            Usuario_RetoList response = await data.GetUsuarioRetoList(texto, new Guid(userId), -1);
            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpGet]
        [Route("equiposByReto/{idReto}/{estado}")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> GetEquiposRetoList([FromRoute] Guid idReto, [FromRoute] int estado)
        {            
            Equipo_RetoList response = await data.GetEquiposByReto(estado, idReto);
            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpGet]
        [Route("retosXvalidar/{top}")]
        [Authorize]
        public async Task<IActionResult> GetRetosXvalidar([FromRoute] int top)
        {
            string userId = User.FindFirst("id").Value;
            Usuario_RetoList response = await data.GetUsuario_RetoxValidarByValidador(new Guid(userId), top);
            return StatusCode(StatusCodes.Status200OK, new { response });
        }


        [HttpGet]
        [Route("retosXvalidar/usuarios/{idReto}")]
        [Authorize]
        public async Task<IActionResult> GetRetosXvalidarUsuarios([FromRoute] Guid idReto)
        {
            string userId = User.FindFirst("id").Value;
            Usuario_RetoList response = await data.GetUsuario_RetoxValidarByReto(idReto, new Guid(userId));
            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpGet]
        [Route("descargar-zip/archivos/{idReto}/{idUsuario}")]
        [Authorize]
        public async Task<IActionResult> GetZipArchivos([FromRoute] Guid idReto, [FromRoute] Guid idUsuario)
        {
            UsuarioxArchivoList response = await data.GetUsuarioXarchivos(idReto, idUsuario);

            if(response.Error == 0)
            {                                
                if(response.Lista.Count > 0)
                {
                    using var memoryStream = new MemoryStream();
                    using (var archive = new ZipArchive(memoryStream, ZipArchiveMode.Create, true))
                    {
                        foreach (var fileName in response.Lista)
                        {
                            string rutaArchivo = WC.GetRutaArchivo(_env, fileName.Archivo, "Recoleccion");

                            if (System.IO.File.Exists(rutaArchivo))
                            {
                                var entry = archive.CreateEntry(fileName.Archivo, CompressionLevel.Fastest);
                                using var fileStream = new FileStream(rutaArchivo, FileMode.Open);
                                using var entryStream = entry.Open();
                                fileStream.CopyTo(entryStream);
                            }
                        }
                    }

                    memoryStream.Position = 0;
                    response.File = memoryStream.ToArray();                    
                }
            }    
            
            return StatusCode(StatusCodes.Status200OK, new { response });
        }


        [HttpPost]
        [Route("create")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> Create([FromForm] IFormFile archivo, [FromForm] Reto reto, [FromForm] string jsonList)
        {
            List<string> listaCorreos = JsonConvert.DeserializeObject<List<string>>(jsonList);
            TipoValidadorItem tv = await dataTipoValidador.GetTipoValidador(1, reto.IdTipoValidador);
            Response response = VF.ValidarReto(reto);
            string rutaArchivo = "";

            if (archivo != null && response.Error == 0)
            {
                string fileName = WC.GetUniqueFileName(archivo, "ret");
                response = VF.ValidarArchivo(_env, archivo, "jpg/jpeg/png", nombreCarpeta);
                rutaArchivo = WC.GetRutaImagen(_env, fileName, nombreCarpeta);

                reto.Imagen = fileName;
            }
            else
            {
                reto.Imagen = "";
            }

            if((listaCorreos.Count == 0 || listaCorreos.Count > 5) && tv.TipoValidador.Nombre == "Usuario")
            {
                response.Error = 1;
                response.Info = "Faltan los usuarios verificadores, máximo deben ser 5";
            }

            if (response.Error == 0)
            {
                response = await data.CreateReto(reto);
                if (response.Error == 0 && !rutaArchivo.Equals(""))
                {
                    //Aqui creamos una nueva imagen
                    FileStream fileStream = new(rutaArchivo, FileMode.Create);
                    await archivo.CopyToAsync(fileStream);
                    await fileStream.DisposeAsync();
                }
                if(response.Error == 0 && tv.Error == 0 && tv.TipoValidador.Nombre == "Usuario")
                {
                    //Aqui poner para que asigne al reto los validadores
                    for (int i = 0; i < listaCorreos.Count; i++)
                    {
                        Usuario u = new();
                        Usuario_Reto ur = new();
                        u.Correo = listaCorreos[i];
                        reto.IdReto = new Guid(response.Id);

                        ur.Reto = reto;
                        ur.Usuario = u;
                        ur.Puntos = -1;
                        ur.Tiempo = -1;
                        ur.Vidas = -1;
                        ur.TieneEquipo = 0;
                        ur.Validador = 1;

                        await data.CreateUsuarioReto(ur);
                    }
                }
            }

            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpPost]
        [Route("clonar")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> Clonar([FromBody] Reto reto)
        {            
            string rutaArchivo = WC.GetRutaImagen(_env, reto.Imagen, nombreCarpeta);
            string copyRutaArchivo = "";

            if (System.IO.File.Exists(rutaArchivo))
            {                    
                Guid newId = Guid.NewGuid();                    
                string copyFileName = $"ret_copy_{newId}{Path.GetExtension(reto.Imagen).ToLower()}";

                copyRutaArchivo = WC.GetRutaImagen(_env, copyFileName, nombreCarpeta);

                reto.Imagen = copyFileName;                
            }
            else
            {
                reto.Imagen = null;
            }

            Response response = await data.ClonarReto(reto);

            if(response.Error == 0 && !copyRutaArchivo.Equals(""))
            {
                System.IO.File.Copy(rutaArchivo, copyRutaArchivo);
            }

            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpPost]
        [Route("createUsuarioReto")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> CreateUsuarioReto([FromBody] Usuario_Reto usuarioReto)
        {
            Response response = VF.ValidarUsuario(usuarioReto.Usuario);            

            if (response.Error == 0)
            {

                usuarioReto.Puntos = 0;
                usuarioReto.Tiempo = 0;
                usuarioReto.Vidas = 0;

                response = await data.CreateUsuarioReto(usuarioReto);
            }

            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpPost]
        [Route("massAction/createUsuarioReto/{idReto}")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> CreateUsuarioReto([FromRoute] Guid idReto, [FromForm] string jsonList)
        {
            List<string> listaCorreosIds = JsonConvert.DeserializeObject<List<string>>(jsonList);
            List<Response> response = new();            

            foreach (string item in listaCorreosIds)
            {                
                response.Add(await data.CreateUsuarioReto(idReto, item));
            }

            return StatusCode(StatusCodes.Status200OK, new { response });
        }


        [HttpPost]
        [Route("createEquipoReto/{idReto}")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> CreateEquipoReto([FromRoute] Guid idReto, [FromForm] string jsonList)
        {
            List<string> listaIdsEquipos = JsonConvert.DeserializeObject<List<string>>(jsonList);
            List<Response> response = new();

            foreach (string item in listaIdsEquipos)
            {
                response.Add(await data.CreateEquipoReto(idReto, new Guid(item)));
            }

            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpPost]
        [Route("create/usuarioxOpcion/comportamiento")]
        [Authorize]
        public async Task<IActionResult> CreateUsuarioxOpcionByValidador([FromForm] Guid idReto, [FromForm] Guid idUsuario, [FromForm] string jsonList)
        {
            Claim userClaim = User.FindFirst("id"); //=> Este es el validador
            Response response = await data.GetUsuario_RetoValidador(idReto, new Guid(userClaim.Value));

            if(response.Error == 0)
            {
                UsuarioxOpcion uxo = new()
                {
                    IdUsuario = idUsuario,
                    IdUserValidador = userClaim.Value,
                };            

                if (!string.IsNullOrEmpty(jsonList))
                {
                    List<string> listaIdsOpciones = JsonConvert.DeserializeObject<List<string>>(jsonList);

                    foreach (string idOpcion in listaIdsOpciones)
                    {
                        if (!string.IsNullOrEmpty(idOpcion))
                        {
                            uxo.IdOpcion = new Guid(idOpcion);
                            response = await dataOpcion.CreateUsuarioxOpcion(uxo);
                        }
                    }

                    if(response.Error == 0)
                    {                        
                        Usuario_Reto usuarioReto = new()
                        {
                            Usuario = new Usuario()
                            {
                                IdUsuario = idUsuario
                            },
                            Reto = new Reto()
                            {
                                IdReto = idReto
                            },
                            Puntos = 1,
                            Tiempo = -1,
                            Vidas = -1,
                            Completado = 1,
                            Correctas = -1,
                            Incorrectas = -1
                        };

                        await data.UpdateUsuario_Reto(usuarioReto);
                    }
                }
                else
                {
                    response.Info = "Sin opciones";
                    response.Error = 1;
                }
            }

            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpPut]
        [Route("update")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> Update([FromForm] IFormFile archivo, [FromForm] Reto reto)
        {
            Response response = VF.ValidarReto(reto);
            string rutaArchivo = "";

            if (archivo != null && response.Error == 0)
            {
                string fileName = WC.GetUniqueFileName(archivo, "ret");
                response = VF.ValidarArchivo(_env, archivo, "jpg/jpeg/png", nombreCarpeta);
                rutaArchivo = WC.GetRutaImagen(_env, fileName, nombreCarpeta);

                reto.Imagen = fileName;
            }
            else
            {
                reto.Imagen = "";
            }

            if (response.Error == 0)
            {
                response = await data.UpdateReto(reto);
                if (response.Error == 0 && !rutaArchivo.Equals(""))
                {
                    string imagenAnterior = response.Info.Split(":")[1];

                    //Aqui eliminamos el archivo anterior
                    string rutaArchivoAnterior = WC.GetRutaImagen(_env, imagenAnterior, nombreCarpeta);
                    if (System.IO.File.Exists(rutaArchivoAnterior))
                    {
                        System.IO.File.Delete(rutaArchivoAnterior);
                    }

                    //Aqui creamos una nueva imagen
                    FileStream fileStream = new(rutaArchivo, FileMode.Create);
                    await archivo.CopyToAsync(fileStream);
                    await fileStream.DisposeAsync();
                }
                if (response.Info.Contains("old_image"))
                {
                    response.Info = response.Info.Split(',')[0];
                }
            }

            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpPut]
        [Route("updateUsuarioReto/trivia")]
        [Authorize]
        public async Task<IActionResult> UpdateUsuario_RetoTrivia([FromBody] Usuario_Reto usuarioReto)
        {
            Claim userClaim = User.FindFirst("id");
            usuarioReto.Usuario.IdUsuario = new Guid(userClaim.Value);

            usuarioReto.Completado = 1;
            Response response = await data.UpdateUsuario_Reto(usuarioReto);
            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpPut]
        [Route("updateUsuarioReto/encuesta")]
        [Authorize]
        public async Task<IActionResult> UpdateUsuario_RetoEncuesta([FromForm] Guid idReto, [FromForm] string jsonList)
        {
            Claim userClaim = User.FindFirst("id");
            List<string> listaIdsOpciones = JsonConvert.DeserializeObject<List<string>>(jsonList);

            Usuario_Reto usuarioReto = new() 
            { 
                Usuario = new Usuario()
                {
                    IdUsuario = new Guid(userClaim.Value)
                },
                Reto = new Reto()
                {
                    IdReto = idReto
                },
                Puntos = 1,
                Tiempo = -1,
                Vidas = -1,
                Completado = 1,
                Correctas = -1,
                Incorrectas = -1
            };

            UsuarioxOpcion uxo = new()
            {
                IdUsuario = new Guid(userClaim.Value),                
            };            

            Response response = await data.UpdateUsuario_Reto(usuarioReto);

            if(response.Error == 0 && listaIdsOpciones.Count > 0)
            {
                foreach (string idOpcion in listaIdsOpciones)
                {
                    if (!string.IsNullOrEmpty(idOpcion))
                    {
                        uxo.IdOpcion = new Guid(idOpcion);
                        await dataOpcion.CreateUsuarioxOpcion(uxo);
                    }
                }
            }

            return StatusCode(StatusCodes.Status200OK, new { response });            
        }

        [HttpPut]
        [Route("updateUsuarioReto/seguimiento_evaluacion")]
        [Authorize]
        public async Task<IActionResult> UpdateUsuario_RetoSeg_eva([FromForm] Guid idReto, [FromForm] string jsonList)
        {
            Claim userClaim = User.FindFirst("id");
            List<string> listaIdsOpciones = JsonConvert.DeserializeObject<List<string>>(jsonList);

            Usuario_Reto usuarioReto = new()
            {
                Usuario = new Usuario()
                {
                    IdUsuario = new Guid(userClaim.Value)
                },
                Reto = new Reto()
                {
                    IdReto = idReto
                },
                Puntos = 1,
                Tiempo = -1,
                Vidas = -1,
                Completado = 1,
                Correctas = -1,
                Incorrectas = -1
            };

            UsuarioxOpcion uxo = new()
            {
                IdUsuario = new Guid(userClaim.Value),                
            };

            Response response = await data.UpdateUsuario_Reto(usuarioReto);

            if (response.Error == 0 && listaIdsOpciones.Count > 0)
            {
                foreach (string items in listaIdsOpciones)
                {
                    if (!string.IsNullOrEmpty(items))
                    {
                        string idOpcion = items.Split("_|_")[0];
                        string respuesta = items.Split("_|_")[1];

                        uxo.IdOpcion = new Guid(idOpcion);
                        uxo.Respuesta = respuesta;
                        await dataOpcion.CreateUsuarioxOpcion(uxo);
                    }
                }
            }

            return StatusCode(StatusCodes.Status200OK, new { response });
        }        


        [HttpPut]
        [Route("updateUsuarioReto/recoleccion/pendiente")]
        [Authorize]
        public async Task<IActionResult> UpdateUsuario_RetoRecleccionP([FromForm] Guid idReto, [FromForm] List<IFormFile> files, [FromForm] string videosNombres)
        {            
            Claim userClaim = User.FindFirst("id");

            RetoItem retoResponse = await data.GetReto(1, idReto);
            Response response = new();

            Usuario_Reto usuarioReto = new()
            {
                Usuario = new Usuario()
                {
                    IdUsuario = new Guid(userClaim.Value)
                },
                Reto = new Reto()
                {
                    IdReto = idReto
                },
                Puntos = 0,
                Tiempo = -1,
                Vidas = -1,
                Completado = 2,
                Correctas = -1,
                Incorrectas = -1
            };

            UsuarioxArchivo uxa = new()
            {
                IdReto = idReto,
                IdUsuario = new Guid(userClaim.Value)
            };

            if(retoResponse.Error == 0)
            {
                int fileMaxSize;                
                switch (retoResponse.Reto.TipoArchivo)
                {                    
                    case "Imagen/png jpg jpeg":
                        {
                            fileMaxSize = 200;                            
                            break;
                        }
                    default:
                        {
                            fileMaxSize = 150;                            
                            break;
                        }
                }

                
                if (files.Count > 0)
                {
                    response = VF.ValidarArchivos(_env, files, retoResponse.Reto.Extension, "Recoleccion", fileMaxSize, 0, 0);

                    if(response.Error == 0)
                    {
                        Response responseUpdate = await data.UpdateUsuario_Reto(usuarioReto);       
                        
                        if(responseUpdate.Error == 0)
                        {
                            foreach (IFormFile file in files)
                            {
                                Guid newId = Guid.NewGuid();
                                string nombreArchivo = $"{idReto}_{newId}{WC.GetFileExtension(file)}";
                                string rutaArchivo = WC.GetRutaArchivo(_env, nombreArchivo, "Recoleccion");

                                //Aqui guarda el archivo
                                FileStream fileStream = new(rutaArchivo, FileMode.Create);
                                await file.CopyToAsync(fileStream);
                                await fileStream.DisposeAsync();

                                uxa.Archivo = nombreArchivo;

                                await data.CreateUsuarioxArchivo(uxa);
                            }
                        }
                        else
                        {
                            response = responseUpdate;
                        }
                    }
                }
                    
                if (!string.IsNullOrEmpty(videosNombres))
                {
                    List<string> listaVideosNombres = JsonConvert.DeserializeObject<List<string>>(videosNombres);

                    response = VF.ValidarCaracteres(listaVideosNombres);

                    if (response.Error == 0)
                    {
                        Response responseUpdate = await data.UpdateUsuario_Reto(usuarioReto);

                        if (responseUpdate.Error == 0)
                        {
                            foreach (string videoNombre in listaVideosNombres)
                            {
                                Guid newId = Guid.NewGuid();
                                string nombreArchivo = $"url_{newId}";
                                uxa.Archivo = nombreArchivo;
                                uxa.Url = videoNombre;

                                await data.CreateUsuarioxArchivo(uxa);
                            }
                        }
                        else
                        {
                            response = responseUpdate;
                        }
                    }                    
                }                
            }
            else
            {                
                response.Error = 1;
                response.Info = retoResponse.Info;
            }            

            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpPut]
        [Route("updateUsuarioReto/recoleccion/finalizado/{puntos}")]
        [Authorize]
        public async Task<IActionResult> UpdateUsuario_RetoRecleccionF([FromForm] Guid idReto, [FromForm] Guid idUsuario, [FromRoute] int puntos)
        {
            Claim userClaim = User.FindFirst("id");
            Response response = await data.GetUsuario_RetoValidador(idReto, new Guid(userClaim.Value));

            if (response.Error == 0)
            {
                Usuario_Reto usuarioReto = new()
                {
                    Usuario = new Usuario()
                    {
                        IdUsuario = idUsuario
                    },
                    Reto = new Reto()
                    {
                        IdReto = idReto
                    },
                    Puntos = puntos,
                    Tiempo = -1,
                    Vidas = -1,
                    Completado = 1,
                    Correctas = -1,
                    Incorrectas = -1
                };            

                response = await data.UpdateUsuario_Reto(usuarioReto);
            }

            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpPut]
        [Route("updateUsuarioReto/recoleccion/finalizado/masivo/{puntos}")]
        [Authorize]
        public async Task<IActionResult> UpdateUsuario_RetoRecleccionFM([FromForm] Guid idReto, [FromForm] string idsUsuario, [FromRoute] int puntos)
        {
            Claim userClaim = User.FindFirst("id");
            Response response = await data.GetUsuario_RetoValidador(idReto, new Guid(userClaim.Value));

            if(response.Error == 0)
            {
                if (!string.IsNullOrEmpty(idsUsuario))
                {
                    List<string> listIdsUsuario = JsonConvert.DeserializeObject<List<string>>(idsUsuario);

                    response = VF.ValidarCaracteres(listIdsUsuario);

                    if (response.Error == 0)
                    {
                        foreach (string idUsuario in listIdsUsuario)
                        {                        
                            Usuario_Reto usuarioReto = new()
                            {
                                Usuario = new Usuario()
                                {
                                    IdUsuario = new Guid(idUsuario)
                                },
                                Reto = new Reto()
                                {
                                    IdReto = idReto
                                },
                                Puntos = puntos,
                                Tiempo = -1,
                                Vidas = -1,
                                Completado = 1,
                                Correctas = -1,
                                Incorrectas = -1
                            };

                            response = await data.UpdateUsuario_Reto(usuarioReto);
                        }                    
                    }
                }
                else
                {
                    response.Info = "Sin usuarios a verificar";
                    response.Error = 1;
                }
            }

            return StatusCode(StatusCodes.Status200OK, new { response });
        }


        [HttpPut]
        [Route("updateEstado")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> Update([FromBody] Reto reto)
        {
            Response response = await data.UpdateRetoByEstado(reto);
            return StatusCode(StatusCodes.Status200OK, new { response });
        }


        [HttpDelete]
        [Route("delete")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> Delete([FromQuery] Guid idReto)
        {            
            Response response = await data.DeleteReto(idReto);            

            if (response.Error == 0)
            {
                string imagenAnterior = response.Info.Split(':')[1];

                //Aqui eliminamos el archivo anterior
                string rutaArchivoAnterior = WC.GetRutaImagen(_env, imagenAnterior, nombreCarpeta);
                if (System.IO.File.Exists(rutaArchivoAnterior))
                {
                    System.IO.File.Delete(rutaArchivoAnterior);
                }

                //Aqui eliminamos los archivos del reto recoleccion
                WC.EliminarArchivo(_env, "Recoleccion", idReto.ToString());

                response.Info = response.Info.Split(',')[0];
            }

            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpDelete]
        [Route("deleteUsuarioReto/{idReto}/{idUsuario}")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> DeleteUsuarioReto([FromRoute] Guid idReto, [FromRoute] Guid idUsuario)
        {
            Response response = await data.DeleteUsuarioReto(idReto, idUsuario);            
            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpDelete]
        [Route("deleteEquipoReto/{idReto}/{idEquipo}")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> DeleteEquipoReto([FromRoute] Guid idReto, [FromRoute] Guid idEquipo)
        {
            Response response = await data.DeleteEquipoReto(idReto, idEquipo);
            return StatusCode(StatusCodes.Status200OK, new { response });
        }
    }
}
