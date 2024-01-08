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
        readonly PreguntaData dataPregunta = new();
        readonly OpcionData dataOpcion = new();

        [HttpGet]
        [Route("listByIdReto/{estado}/{idReto}")]
        [Authorize]
        public async Task<IActionResult> GetListByIdReto([FromRoute] int estado, [FromRoute] Guid idReto)
        {
            PreguntaList response = await dataPregunta.GetPreguntaList(estado, idReto);
            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpPost]
        [Route("create")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> CreateItem([FromBody] Pregunta_OpcionList pregunta_opcionList)
        {

            Response resultPregunta = VF.ValidarPregunta(pregunta_opcionList.Pregunta);
            Response resultOpcion = new();
            Response result = new();
            foreach (var item in pregunta_opcionList.OpcionList)
            {
                resultOpcion = VF.ValidarOpcion(item);
                if (resultOpcion.Error > 0)
                {
                    break;
                }
            }

            if (resultPregunta.Error == 0 && resultOpcion.Error == 0)
            {
                result = await dataPregunta.CreatePregunta(pregunta_opcionList.Pregunta);
                if (result.Error == 0)
                {
                    Guid idPregunta = new(result.Id);
                    foreach (var item in pregunta_opcionList.OpcionList)
                    {
                        item.IdPregunta = idPregunta;
                        result = await dataOpcion.CreateOpcion(item);
                    }
                }
            }
            else if (resultPregunta.Error > 0)
            {
                result.Error = 1;
                result.Info = resultPregunta.Info;
                result.Campo = resultPregunta.Campo;
            }
            else if (resultOpcion.Error > 0)
            {
                result.Error = 1;
                result.Info = resultOpcion.Info;
                result.Campo = resultOpcion.Campo;
            }

            return StatusCode(StatusCodes.Status200OK, new { result });
        }

        [HttpPut]
        [Route("update")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> Update([FromBody] Pregunta_OpcionList pregunta_opcionList)
        {

            Response resultPregunta = VF.ValidarPregunta(pregunta_opcionList.Pregunta);
            Response resultOpcion = new();
            Response result = new();
            foreach (var item in pregunta_opcionList.OpcionList)
            {
                resultOpcion = VF.ValidarOpcion(item);
                if (resultOpcion.Error > 0)
                {
                    break;
                }
            }

            if (resultPregunta.Error == 0 && resultOpcion.Error == 0)
            {
                result = await dataPregunta.UpdatePregunta(pregunta_opcionList.Pregunta);
                if (result.Error == 0)
                {
                    foreach (var item in pregunta_opcionList.OpcionList)
                    {
                        result = await dataOpcion.UpdateOpcion(item);
                    }
                    if (result.Error == 0)
                    {
                        //Guid ultimoIdOpcion = new(result.Id);
                        //Guid idPregunta = pregunta_opcionList.Pregunta.IdPregunta;
                        ////Aqui elimina los que no pertencen
                        //result = await dataOpcion.DeleteOpcion(ultimoIdOpcion, idPregunta);
                    }
                }
            }
            else if (resultPregunta.Error > 0)
            {
                result.Error = 1;
                result.Info = resultPregunta.Info;
                result.Campo = resultPregunta.Campo;
            }
            else if (resultOpcion.Error > 0)
            {
                result.Error = 1;
                result.Info = resultOpcion.Info;
                result.Campo = resultOpcion.Campo;
            }

            return StatusCode(StatusCodes.Status200OK, new { result });
        }

        [HttpDelete]
        [Route("delete/{idPregunta}")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> Delete([FromRoute] Guid idPregunta)
        {
            Response response = await dataPregunta.DeletePregunta(idPregunta);
            return StatusCode(StatusCodes.Status200OK, new { response });
        }
    }
}
