using MathNet.Numerics.Distributions;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using NPOI.POIFS.Crypt.Dsig;
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
            PreguntaList_opciones response = await dataPregunta.GetPreguntaList_opciones(estado, idReto);                        
            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpGet]
        [Route("buscar/{texto}/{idReto}")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> Buscar([FromRoute] string texto, [FromRoute] Guid idReto)
        {
            PreguntaList_opciones response = await dataPregunta.GetPreguntaList_opciones(texto, idReto);
            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpGet]
        [Route("item/{estado}/{idPregunta}")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> GetById([FromRoute] int estado, [FromRoute] Guid idPregunta)
        {
            Pregunta_OpcionList response = await dataPregunta.GetPregunta_OpcionList(estado, idPregunta);
            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpPost]
        [Route("create")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> CreateItem([FromBody] Pregunta_OpcionList pregunta_opcionList)
        {

            Response resultPregunta = VF.ValidarPregunta(pregunta_opcionList.Pregunta);
            Response resultOpcion = new();
            Response response = new();
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
                response = await dataPregunta.CreatePregunta(pregunta_opcionList.Pregunta);
                if (response.Error == 0)
                {
                    Guid idPregunta = new(response.Id);
                    foreach (var item in pregunta_opcionList.OpcionList)
                    {
                        item.IdPregunta = idPregunta;
                        response = await dataOpcion.CreateOpcion(item);
                    }
                }
            }
            else if (resultPregunta.Error > 0)
            {
                response.Error = 1;
                response.Info = resultPregunta.Info;
                response.Campo = resultPregunta.Campo;
            }
            else if (resultOpcion.Error > 0)
            {
                response.Error = 1;
                response.Info = resultOpcion.Info;
                response.Campo = resultOpcion.Campo;
            }

            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpPut]
        [Route("update")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> Update([FromBody] Pregunta_OpcionList pregunta_opcionList)
        {

            Response resultPregunta = VF.ValidarPregunta(pregunta_opcionList.Pregunta);
            Response resultOpcion = new();
            Response response = new();
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
                response = await dataPregunta.UpdatePregunta(pregunta_opcionList.Pregunta);
                if (response.Error == 0)
                {
                    Guid idPregunta = pregunta_opcionList.Pregunta.IdPregunta;
                    string idsOpcion = "";
                    List<Opcion> list = pregunta_opcionList.OpcionList;
                    for (int i = 0; i < list.Count; i++)
                    {
                        response = await dataOpcion.UpdateOpcion(list[i]);
                        if (i == list.Count - 1)
                        {
                            // Es el último valor
                            idsOpcion += response.Id;
                        }
                        else
                        {
                            idsOpcion += response.Id + "|";
                        }
                    }
                    if (response.Error == 0)
                    {
                        //Aqui elimina los que no pertencen                        
                        response = await dataOpcion.DeleteOpcionByNoIds(idsOpcion, idPregunta);
                    }
                }
            }
            else if (resultPregunta.Error > 0)
            {
                response.Error = 1;
                response.Info = resultPregunta.Info;
                response.Campo = resultPregunta.Campo;
            }
            else if (resultOpcion.Error > 0)
            {
                response.Error = 1;
                response.Info = resultOpcion.Info;
                response.Campo = resultOpcion.Campo;
            }

            return StatusCode(StatusCodes.Status200OK, new { response });
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
