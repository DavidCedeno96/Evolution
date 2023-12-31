﻿using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using NPOI.POIFS.Crypt.Dsig;
using WebApiRest.Data;
using WebApiRest.Models;
using WebApiRest.Utilities;

namespace WebApiRest.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class NoticiaController : ControllerBase
    {
        readonly NoticiaData data = new();

        private readonly IWebHostEnvironment _env;
        private readonly string nombreCarpeta = "Noticia";

        public NoticiaController(IWebHostEnvironment env)
        {            
            _env = env;
        }

        [HttpGet]
        [Route("list/{estado}")]
        [Authorize]
        public async Task<IActionResult> GetList([FromRoute] int estado)
        {
            NoticiaList response = await data.GetNoticiaList(estado);
            return StatusCode(StatusCodes.Status200OK, new { response });
        }        

        [HttpPost]
        [Route("create")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> Create([FromForm] IFormFile archivo, [FromForm] Noticia noticia)
        {
            Response response = VF.ValidarNoticia(noticia);
            string rutaArchivo = "";

            if (archivo != null && response.Error == 0)
            {
                response = VF.ValidarArchivo(_env, archivo, "jpg/jpeg/png", nombreCarpeta);
                rutaArchivo = WC.GetRutaImagen(_env, archivo.FileName, nombreCarpeta);

                noticia.Imagen = archivo.FileName.Trim();
            }
            else
            {
                noticia.Imagen = "";
            }

            if (response.Error == 0)
            {
                response = await data.CreateNoticia(noticia);
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
        public async Task<IActionResult> Update([FromForm] IFormFile archivo, [FromForm] Noticia noticia)
        {
            Response response = VF.ValidarNoticia(noticia);
            string rutaArchivo = "";

            if (archivo != null && response.Error == 0)
            {
                response = VF.ValidarArchivo(_env, archivo, "jpg/jpeg/png", nombreCarpeta);
                rutaArchivo = WC.GetRutaImagen(_env, archivo.FileName, nombreCarpeta);

                noticia.Imagen = archivo.FileName.Trim();
            }
            else
            {
                noticia.Imagen = "";
            }

            if (response.Error == 0)
            {
                response = await data.UpdateNoticia(noticia);
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
        [Route("delete/{idNoticia}")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> Delete([FromRoute] Guid idNoticia)
        {
            Response response = await data.DeleteNoticia(idNoticia);

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




        [HttpGet]
        [Route("listUsuNotiByIdNoticia/{idNoticia}")]
        [Authorize]
        public async Task<IActionResult> GetListUsuarioNoticiaByIdNoticia([FromRoute] Guid idNoticia)
        {
            Usuario_NoticiaList response = await data.GetUsuario_NoticiaList(idNoticia);
            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpPost]
        [Route("createUsuarioNoticia")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> CreateUsuarioNoticia([FromBody] Usuario_Noticia usuarioNoticia)
        {
            Response response = VF.ValidarUsuarioNoticia(usuarioNoticia);            

            if (response.Error == 0)
            {
                response = await data.CreateUsuario_Noticia(usuarioNoticia);
            }                       

            return StatusCode(StatusCodes.Status200OK, new { response });
        }
    }
}
