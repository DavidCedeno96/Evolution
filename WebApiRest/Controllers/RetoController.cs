using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
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
        [Route("ranking/{top}")]
        [Authorize]
        public async Task<IActionResult> Ranking([FromRoute] int top)
        {
            string userId = User.FindFirst("id").Value;
            Usuario_RetoList response = await data.GetUsuarioRetoPuntosList(new Guid(userId), top);
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
        [Route("buscarUsuarioRetoByIdUsuario/{texto}")]
        [Authorize]
        public async Task<IActionResult> GetUsuarioRetoByIdUsuario([FromRoute] string texto)
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

            Claim userClaim = User.FindFirst("id");
            usuarioReto.Usuario.IdUsuario = new Guid(userClaim.Value);

            Response response = await data.UpdateUsuario_Reto(usuarioReto);
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
