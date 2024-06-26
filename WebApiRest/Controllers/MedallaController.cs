﻿using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;
using WebApiRest.Data;
using WebApiRest.Models;
using WebApiRest.Utilities;

namespace WebApiRest.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class MedallaController : ControllerBase
    {
        readonly MedallaData data = new();

        private readonly IWebHostEnvironment _env;
        private readonly string nombreCarpeta = "Medalla";

        public MedallaController(IWebHostEnvironment env)
        {
            _env = env;
        }

        [HttpGet]
        [Route("list/{estado}")]
        [Authorize]
        public async Task<IActionResult> GetList([FromRoute] int estado)
        {
            MedallaList response = await data.GetMedallaList(estado);
            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpGet]
        [Route("list")]
        [Authorize]
        public async Task<IActionResult> GetByIdUsuario()
        {
            Claim userClaim = User.FindFirst("id");
            Usuario_MedallaList response = await data.GetUsuarioMedallaList(-1, new Guid(userClaim.Value));

            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpGet]
        [Route("item/{estado}/{idMedalla}")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> GetById([FromRoute] int estado, [FromRoute] Guid idMedalla)
        {
            MedallaItem response = await data.GetMedalla(estado, idMedalla);
            return StatusCode(StatusCodes.Status200OK, new { response });
        }        

        [HttpGet]
        [Route("buscar")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> Buscar([FromQuery] string texto)
        {
            MedallaList response = await data.GetMedallaList(texto);
            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpPost]
        [Route("create")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> Create([FromForm] IFormFile archivo, [FromForm] Medalla medalla)
        {
            Response response = VF.ValidarMedalla(medalla);
            string rutaArchivo = "";

            if (archivo != null && response.Error == 0)
            {
                string fileName = WC.GetUniqueFileName(archivo, "med");
                response = VF.ValidarArchivo(_env, archivo, "jpg/jpeg/png", nombreCarpeta);
                rutaArchivo = WC.GetRutaImagen(_env, fileName, nombreCarpeta);

                medalla.Imagen = fileName;
            }
            else
            {
                medalla.Imagen = "";
            }

            if (response.Error == 0)
            {
                response = await data.CreateMedalla(medalla);
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
        public async Task<IActionResult> Update([FromForm] IFormFile archivo, [FromForm] Medalla medalla)
        {
            Response response = VF.ValidarMedalla(medalla);
            string rutaArchivo = "";

            if (archivo != null && response.Error == 0)
            {
                string fileName = WC.GetUniqueFileName(archivo, "med");
                response = VF.ValidarArchivo(_env, archivo, "jpg/jpeg/png", nombreCarpeta);
                rutaArchivo = WC.GetRutaImagen(_env, fileName, nombreCarpeta);

                medalla.Imagen = fileName;
            }
            else
            {
                medalla.Imagen = "";
            }

            if (response.Error == 0)
            {
                response = await data.UpdateMedalla(medalla);
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
        public async Task<IActionResult> Delete([FromQuery] Guid idMedalla)
        {
            Response response = await data.DeleteMedalla(idMedalla);

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
        [Route("createUsuarioMedalla")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> CreateUsuarioMedalla([FromBody] Usuario_Medalla usuarioMedalla)
        {
            Response response = await data.CreateUsuarioMedalla(usuarioMedalla);
            return StatusCode(StatusCodes.Status200OK, new { response });
        }
    }
}
