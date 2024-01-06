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
    public class OpcionController : ControllerBase
    {
        readonly OpcionData data = new();

        [HttpGet]
        [Route("listByIdPregunta/{estado}/{idPregunta}")]
        [Authorize]
        public async Task<IActionResult> GetListByIdPregunta([FromRoute] int estado, [FromRoute] Guid idPregunta)
        {
            OpcionList response = await data.GetOpcionList(estado, idPregunta);
            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpPost]
        [Route("create")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> Create([FromBody] Opcion opcion)
        {
            Response response = VF.ValidarOpcion(opcion);                 

            if (response.Error == 0)
            {
                response = await data.CreateOpcion(opcion);                
            }

            return StatusCode(StatusCodes.Status200OK, new { response });
        }    

        [HttpDelete]
        [Route("delete/{idOpcion}")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> Delete([FromRoute] Guid idOpcion)
        {
            Response response = await data.DeleteOpcion(idOpcion);
            return StatusCode(StatusCodes.Status200OK, new { response });
        }
    }
}
