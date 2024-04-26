using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using WebApiRest.Data;
using WebApiRest.Models;
using WebApiRest.Utilities;

namespace WebApiRest.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class EquipoController : ControllerBase
    {
        readonly EquipoData data = new();

        private readonly IWebHostEnvironment _env;
        private readonly string nombreCarpeta = "Equipo";

        public EquipoController(IWebHostEnvironment env)
        {
            _env = env;
        }

        [HttpGet]
        [Route("list/{estado}")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> GetList([FromRoute] int estado)
        {
            EquipoList response = await data.GetEquipoList(estado);
            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpGet]
        [Route("buscar/{texto}")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> GetList([FromRoute] string texto)
        {
            EquipoList response = await data.GetEquipoList(texto);
            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpGet]
        [Route("item/{estado}/{idEquipo}")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> GetById([FromRoute] int estado, [FromRoute] Guid idEquipo)
        {
            EquipoItem response = await data.GetEquipo(estado, idEquipo);
            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpGet]
        [Route("usuarioEquipoByIdEquipo/{idEquipo}")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> GetUsuarioEquipoByIdEquipo([FromRoute] Guid idEquipo)
        {
            Usuario_EquipoList response = await data.GetUsuarioEquipoList(idEquipo);
            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpGet]
        [Route("ranking/{top}/{idUsuario}")]
        [Authorize]
        public async Task<IActionResult> GetUsuarioEquipoByPuntos([FromRoute] int top, [FromRoute] Guid idUsuario)
        {
            Usuario_EquipoList response = await data.GetUsuarioEquipoList(idUsuario, top);
            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpPost]
        [Route("create")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> Create([FromForm] IFormFile archivo, [FromForm] Equipo equipo)
        {
            Response response = VF.ValidarEquipo(equipo);
            string rutaArchivo = "";

            if (archivo != null && response.Error == 0)
            {
                response = VF.ValidarArchivo(_env, archivo, "jpg/jpeg/png", nombreCarpeta);
                rutaArchivo = WC.GetRutaImagen(_env, archivo.FileName, nombreCarpeta);

                equipo.Imagen = archivo.FileName.Trim();
            }
            else
            {
                equipo.Imagen = "";
            }

            if (response.Error == 0)
            {
                response = await data.CreateEquipo(equipo);
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
        [Route("createUsuarioEquipo")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> CreateUsuarioEquipo([FromBody] Usuario_Equipo usuarioEquipo)
        {
            Response response = VF.ValidarUsuario(usuarioEquipo.Usuario);

            if (response.Error == 0)
            {
                response = await data.CreateUsuarioEquipo(usuarioEquipo);
            }

            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpPost]
        [Route("massAction/createUsuarioEquipo/{idEquipo}")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> CreateUsuarioReto([FromRoute] Guid idEquipo, [FromForm] string jsonList)
        {
            List<string> listaCorreosIds = JsonConvert.DeserializeObject<List<string>>(jsonList);
            List<Response> response = new();

            foreach (string item in listaCorreosIds)
            {
                response.Add(await data.CreateUsuarioEquipo(idEquipo, item));
            }

            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpPut]
        [Route("update")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> Update([FromForm] IFormFile archivo, [FromForm] Equipo equipo)
        {
            Response response = VF.ValidarEquipo(equipo);
            string rutaArchivo = "";

            if (archivo != null && response.Error == 0)
            {
                response = VF.ValidarArchivo(_env, archivo, "jpg/jpeg/png", nombreCarpeta);
                rutaArchivo = WC.GetRutaImagen(_env, archivo.FileName, nombreCarpeta);

                equipo.Imagen = archivo.FileName.Trim();
            }
            else
            {
                equipo.Imagen = "";
            }

            if (response.Error == 0)
            {
                response = await data.UpdateEquipo(equipo);
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
        [Route("updateEstado")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> Update([FromBody] Equipo equipo)
        {
            Response response = await data.UpdateEquipoByEstado(equipo);
            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpDelete]
        [Route("delete")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> Delete([FromQuery] Guid idEquipo)
        {
            Response response = await data.DeleteEquipo(idEquipo);

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
        [Route("deleteUsuarioEquipo/{idEquipo}/{idUsuario}")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> DeleteUsuarioReto([FromRoute] Guid idEquipo, [FromRoute] Guid idUsuario)
        {
            Response response = await data.DeleteUsuarioEquipo(idEquipo, idUsuario);
            return StatusCode(StatusCodes.Status200OK, new { response });
        }
    }
}
