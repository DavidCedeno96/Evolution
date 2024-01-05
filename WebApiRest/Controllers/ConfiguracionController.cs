using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
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

        [HttpGet]
        [Route("list")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> GetList()
        {
            ConfiguracionList response = await data.GetConfiguracionList();
            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpPost]
        [Route("create")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> Create([FromBody] Configuracion configuracion)
        {
            Response response = VF.ValidarConfiguracion(configuracion);

            if (response.Error == 0)
            {
                response = await data.CreateConfiguracion(configuracion);
            }

            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpPut]
        [Route("update")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> Update([FromBody] Configuracion configuracion)
        {
            Response response = VF.ValidarConfiguracion(configuracion);

            if (response.Error == 0)
            {
                response = await data.UpdateConfiguracion(configuracion);
            }

            return StatusCode(StatusCodes.Status200OK, new { response });
        }
    }
}
