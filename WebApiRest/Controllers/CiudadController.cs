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
    public class CiudadController : ControllerBase
    {
        readonly CiudadData data = new();

        [HttpGet]
        [Route("list/{estado}")]
        [Authorize]
        public async Task<IActionResult> GetList([FromRoute] int estado)
        {
            CiudadList response = await data.GetCiudadList(estado);
            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpPost]
        [Route("create")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> Create([FromBody] Ciudad ciudad)
        {
            Response response = VF.ValidarCiudad(ciudad);

            if (response.Error == 0)
            {
                response = await data.CreateCiudad(ciudad);
            }

            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpPut]
        [Route("update")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> Update([FromBody] Ciudad ciudad)
        {
            Response response = VF.ValidarCiudad(ciudad);

            if (response.Error == 0)
            {
                response = await data.UpdateCiudad(ciudad);
            }

            return StatusCode(StatusCodes.Status200OK, new { response });
        }
    }
}
