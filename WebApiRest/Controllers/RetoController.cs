using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using NPOI.SS.UserModel;
using NPOI.XSSF.UserModel;
using System.Security.Claims;
using WebApiRest.Data;
using WebApiRest.Models;
using WebApiRest.Utilities;

namespace WebApiRest.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class RetoController : ControllerBase
    {
        readonly RetoData data = new();

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
            RetoList response = await data.GetRetoList(estado);
            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpGet]
        [Route("buscar/{texto}")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> List([FromRoute] string texto)
        {
            RetoList response = await data.GetRetoList(texto);
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
        [Route("usuarioRetoByIdReto/{idReto}")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> GetUsuarioRetoByIdReto([FromRoute] Guid idReto)
        {
            Usuario_RetoList response = await data.GetUsuarioRetoList(idReto);
            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpGet]
        [Route("usuarioRetoByIdUsuario")]
        [Authorize]
        public async Task<IActionResult> GetUsuarioRetoByIdUsuario()
        {
            string userId = User.FindFirst("id").Value;
            Usuario_RetoList response = await data.GetUsuarioRetoList(-1, new Guid(userId), 0);
            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpGet]
        [Route("usuarioRetoByIdUsuarioYIdReto/{idReto}")]
        [Authorize]
        public async Task<IActionResult> GetUsuarioRetoByIdUsuarioYIdReto([FromRoute] Guid idReto)
        {
            string userId = User.FindFirst("id").Value;
            Usuario_RetoItem response = await data.GetUsuarioRetoList(idReto, new Guid(userId), 0);
            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpGet]
        [Route("buscarUsuarioRetoByIdUsuario/{texto}")]
        [Authorize]
        public async Task<IActionResult> GetUsuarioRetoByIdUsuario([FromRoute] string texto)
        {
            string userId = User.FindFirst("id").Value;
            Usuario_RetoList response = await data.GetUsuarioRetoList(texto, new Guid(userId), 0);
            return StatusCode(StatusCodes.Status200OK, new { response });
        }


        [HttpPost]
        [Route("create")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> Create([FromForm] IFormFile archivo, [FromForm] Reto reto)
        {
            Response response = VF.ValidarReto(reto);
            string rutaArchivo = "";

            if (archivo != null && response.Error == 0)
            {
                response = VF.ValidarArchivo(_env, archivo, "jpg/jpeg/png", nombreCarpeta);
                rutaArchivo = WC.GetRutaImagen(_env, archivo.FileName, nombreCarpeta);

                reto.Imagen = archivo.FileName.Trim();
            }
            else
            {
                reto.Imagen = "";
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
                response = await data.CreateUsuarioReto(usuarioReto);
            }

            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpPost]
        [Route("importUsuarioReto/{idReto}")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> ImportList([FromRoute] Guid idReto, [FromForm] IFormFile archivo)
        {
            Response response = new();

            List<Usuario_Reto> lista = new();

            if (archivo != null)
            {
                Stream stream = archivo.OpenReadStream();
                if (Path.GetExtension(archivo.FileName).Equals(".xlsx"))
                {
                    IWorkbook archivoExcel = new XSSFWorkbook(stream);
                    ISheet hojaExcel = archivoExcel.GetSheetAt(0);
                    int cantidadFilas = hojaExcel.LastRowNum + 1;

                    for (int i = 0; i < cantidadFilas; i++)
                    {
                        if (i > 0)
                        {
                            string filaEncabezado = hojaExcel.GetRow(0).GetCell(0).ToString();
                            IRow filaData = hojaExcel.GetRow(i);
                            Usuario_Reto ur = new() { 
                                Usuario = new(),
                                Reto = new()
                            };                            
                            try
                            {
                                if (filaEncabezado.ToLower().Contains("correo"))
                                {
                                    ur.Usuario.Correo = WC.GetTrim(filaData.GetCell(0, MissingCellPolicy.CREATE_NULL_AS_BLANK).ToString());
                                }                                    
                            }
                            catch (Exception) {}

                            if (!string.IsNullOrEmpty(ur.Usuario.Correo.Trim()))
                            {
                                ur.Reto.IdReto = idReto;
                                ur.Puntos = 0;
                                ur.Tiempo = 0;
                                ur.Vidas = 0;

                                lista.Add(ur);
                            }
                        }
                    }

                    if (lista.Count > 0)
                    {
                        foreach (var item in lista)
                        {
                            response = VF.ValidarUsuario(item.Usuario);
                            if (response.Error == 0)
                            {
                                response = await data.CreateUsuarioReto(item);
                            }
                        }
                    }
                    else
                    {
                        response.Error = 1;
                        response.Info = "el Archivo no tiene registros válidos";
                    }
                }
                else
                {
                    response.Error = 1;
                    response.Info = "Archivo no permitido";
                }
            }
            else
            {
                response.Error = 1;
                response.Info = "Falta el archivo";
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
                response = VF.ValidarArchivo(_env, archivo, "jpg/jpeg/png", nombreCarpeta);
                rutaArchivo = WC.GetRutaImagen(_env, archivo.FileName, nombreCarpeta);

                reto.Imagen = archivo.FileName.Trim();
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
        [Route("updateUsuarioReto")]
        [Authorize]
        public async Task<IActionResult> UpdateUsuario_Reto([FromBody] Usuario_Reto usuarioReto)
        {
            Response response = await data.UpdateUsuario_Reto(usuarioReto);
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
    }
}
