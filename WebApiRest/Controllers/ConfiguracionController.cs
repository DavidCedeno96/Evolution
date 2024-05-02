using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Razor.TagHelpers;
using Newtonsoft.Json;
using System.Drawing;
using System.Security.Claims;
using WebApiRest.Data;
using WebApiRest.Models;
using WebApiRest.Utilities;

namespace WebApiRest.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ConfiguracionController : ControllerBase
    {
        readonly ConfiguracionData data = new();

        private readonly IWebHostEnvironment _env;
        private readonly string nombreCarpeta = "Config";

        public ConfiguracionController(IWebHostEnvironment env)
        {
            _env = env;
        }

        [HttpGet]
        [Route("list")]
        public async Task<IActionResult> GetList()
        {
            ConfiguracionList response = await data.GetConfiguracionList();
            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpPut]
        [Route("update")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> UpdateItem([FromBody] Configuracion configuracion)
        {
            Response response = VF.ValidarConfiguracion(configuracion);
            if (response.Error == 0)
            {
                response = await data.UpdateConfiguracion(configuracion);
                if (response.Info.Contains("old_value"))
                {
                    response.Info = response.Info.Split(',')[0];
                }
            }

            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpPut]
        [Route("updateList")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> UpdateList([FromBody] List<Configuracion> configuracion)
        {
            Response response = new();
            string userId = User.FindFirst("id").Value;

            foreach (var item in configuracion)
            {
                response = VF.ValidarConfiguracion(item);
                if (response.Error > 0)
                {
                    break;
                }
            }

            if (response.Error == 0)
            {
                foreach (var item in configuracion)
                {
                    item.IdUsuario = new Guid(userId);
                    response = await data.UpdateConfiguracion(item);
                }
                if (response.Info.Contains("old_value"))
                {
                    response.Info = response.Info.Split(',')[0];
                }
            }

            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpPut]
        [Route("updateImages")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> UpdateImages([FromForm] IFormFile archivoLogin, IFormFile archivoHeader, IFormFile archivoFooter, [FromForm] string jsonConfig)
        {
            Response response = new();
            List<Configuracion> configuracion = JsonConvert.DeserializeObject<List<Configuracion>>(jsonConfig);

            string userId = User.FindFirst("id").Value;            

            foreach (var item in configuracion)
            {
                response = VF.ValidarConfiguracion(item);
                if (response.Error > 0)
                {
                    break;
                }
            }

            List<string> rutasImages = new();           
            List<Imagen> imagenes = new()
            {
                new Imagen()
                {
                    Img = archivoLogin,
                    WidthMax = 0,
                    HeightMax = 0,
                },
                new Imagen()
                {
                    Img = archivoHeader,
                    WidthMax = 1024,
                    HeightMax = 200,
                },
                new Imagen()
                {
                    Img = archivoFooter,
                    WidthMax = 300,
                    HeightMax = 300,
                },
            };

            for (int i = 0; i < imagenes.Count; i++)
            {
                if (imagenes[i].Img != null && response.Error == 0)
                {
                    response = VF.ValidarArchivo(_env, imagenes[i].Img, "jpg/jpeg/png", nombreCarpeta, 350, imagenes[i].WidthMax, imagenes[i].HeightMax);
                    rutasImages.Add(WC.GetRutaImagen(_env, imagenes[i].Img.FileName, nombreCarpeta));

                    configuracion[i].Valor = imagenes[i].Img.FileName;
                    if (response.Error > 0)
                    {
                        break;
                    }
                }
                else
                {
                    rutasImages.Add("");
                    configuracion[i].Valor = "";
                }
            }

            if (response.Error == 0)
            {
                for (int i = 0; i < configuracion.Count; i++)
                {
                    configuracion[i].IdUsuario = new Guid(userId);
                    response = await data.UpdateConfiguracion(configuracion[i]);
                    if (response.Error == 0 && rutasImages[i] != "")
                    {
                        //Aqui eliminamos el archivo anterior
                        string rutaArchivoAnterior = response.Info.Split(":")[1];
                        if (System.IO.File.Exists(rutaArchivoAnterior))
                        {
                            System.IO.File.Delete(rutaArchivoAnterior);
                        }

                        //Aqui creamos una nueva imagen
                        FileStream fileStream = new(rutasImages[i], FileMode.Create);
                        await imagenes[i].Img.CopyToAsync(fileStream);
                        await fileStream.DisposeAsync();
                    }
                }
                if (response.Info.Contains("old_value"))
                {
                    response.Info = response.Info.Split(',')[0];
                }
            }

            return StatusCode(StatusCodes.Status200OK, new { response });
        }        
    }
}