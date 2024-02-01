using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using WebApiRest.Data;
using WebApiRest.Models;
using WebApiRest.Utilities;

namespace WebApiRest.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class RecompensaController : ControllerBase
    {
        readonly RecompensaData data = new();

        private readonly IWebHostEnvironment _env;
        private readonly string nombreCarpeta = "Recompensa";

        public RecompensaController(IWebHostEnvironment env)
        {
            _env = env;
        }

        [HttpGet]
        [Route("list/{estado}")]
        [Authorize]
        public async Task<IActionResult> GetList([FromRoute] int estado)
        {
            RecompensaList response = await data.GetRecompensaList(estado);
            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpGet]
        [Route("buscar/{texto}")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> Buscar([FromRoute] string texto)
        {
            RecompensaList response = await data.GetRecompensaList(texto);
            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpGet]
        [Route("item/{estado}/{idRecompensa}")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> GetById([FromRoute] int estado, [FromRoute] Guid idRecompensa)
        {
            RecompensaItem response = await data.GetRecompensa(estado, idRecompensa);
            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpPost]
        [Route("create")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> Create([FromForm] IFormFile archivo, [FromForm] Recompensa recompensa)
        {
            Response response = VF.ValidarRecompensa(recompensa);
            string rutaArchivo = "";

            if (archivo != null && response.Error == 0)
            {
                response = VF.ValidarArchivo(_env, archivo, "jpg/jpeg/png", nombreCarpeta);
                rutaArchivo = WC.GetRutaImagen(_env, archivo.FileName, nombreCarpeta);

                recompensa.Imagen = archivo.FileName.Trim();
            }
            else
            {
                recompensa.Imagen = "";
            }

            if (response.Error == 0)
            {
                response = await data.CreateRecompensa(recompensa);
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

        [HttpPut]
        [Route("update")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> Update([FromForm] IFormFile archivo, [FromForm] Recompensa recompensa)
        {
            Response response = VF.ValidarRecompensa(recompensa);
            string rutaArchivo = "";

            if (archivo != null && response.Error == 0)
            {
                response = VF.ValidarArchivo(_env, archivo, "jpg/jpeg/png", nombreCarpeta);
                rutaArchivo = WC.GetRutaImagen(_env, archivo.FileName, nombreCarpeta);

                recompensa.Imagen = archivo.FileName.Trim();
            }
            else
            {
                recompensa.Imagen = "";
            }

            if (response.Error == 0)
            {
                response = await data.UpdateRecompensa(recompensa);
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

        [HttpDelete]
        [Route("delete")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> Delete([FromQuery] Guid idRecompensa)
        {
            Response response = await data.DeleteRecompensa(idRecompensa);

            if (response.Error == 0)
            {
                string imagen = response.Info.Split(":")[1];

                //Aqui eliminamos el archivo
                string rutaArchivo = WC.GetRutaImagen(_env, imagen, nombreCarpeta);
                if (System.IO.File.Exists(rutaArchivo))
                {
                    System.IO.File.Delete(rutaArchivo);
                }

                if (response.Info.Contains("image"))
                {
                    response.Info = response.Info.Split(',')[0];
                }
            }

            return StatusCode(StatusCodes.Status200OK, new { response });
        }




        [HttpPost]
        [Route("createUsuarioRecompensa")]
        [Authorize]
        public async Task<IActionResult> CreateUsuarioRecompensa([FromBody] Usuario_Recompensa usuarioRecompensa)
        {
            Response response = await data.CreateUsuarioRecompensa(usuarioRecompensa);
            return StatusCode(StatusCodes.Status200OK, new { response });
        }
    }
}
