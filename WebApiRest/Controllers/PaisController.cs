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
    public class PaisController : ControllerBase
    {
        readonly PaisData data = new();

        [HttpGet]
        [Route("list/{estado}")]
        [Authorize]
        public async Task<IActionResult> GetList([FromRoute] int estado)
        {
            PaisList response = await data.GetPaisList(estado);
            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpPost]
        [Route("create")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> Create([FromBody] Pais pais)
        {
            Response response = VF.ValidarPais(pais);
            
            if (response.Error == 0)
            {
                response = await data.CreatePais(pais);                
            }

            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpPut]
        [Route("update")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> Update([FromBody] Pais pais)
        {
            Response response = VF.ValidarPais(pais);

            if (response.Error == 0)
            {
                response = await data.UpdatePais(pais);
            }

            return StatusCode(StatusCodes.Status200OK, new { response });
        }
    }
}
