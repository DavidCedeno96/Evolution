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
    public class PreguntaController : ControllerBase
    {
        readonly PreguntaData data = new();

        [HttpGet]
        [Route("listByIdReto/{estado}/{idReto}")]
        [Authorize]
        public async Task<IActionResult> GetListByIdReto([FromRoute] int estado, [FromRoute] Guid idReto)
        {
            PreguntaList response = await data.GetPreguntaList(estado, idReto);
            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpPost]
        [Route("create")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> Create([FromBody] Pregunta pregunta)
        {
            Response response = VF.ValidarPregunta(pregunta);

            if (response.Error == 0)
            {
                response = await data.CreatePregunta(pregunta);
            }

            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpPut]
        [Route("update")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> Update([FromBody] Pregunta pregunta)
        {
            Response response = VF.ValidarPregunta(pregunta);

            if (response.Error == 0)
            {
                response = await data.UpdatePregunta(pregunta);
            }

            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpDelete]
        [Route("delete/{idPregunta}")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> Delete([FromRoute] Guid idPregunta)
        {
            Response response = await data.DeletePregunta(idPregunta);
            return StatusCode(StatusCodes.Status200OK, new { response });
        }
    }
}
