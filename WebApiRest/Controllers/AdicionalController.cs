using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using WebApiRest.Data;
using WebApiRest.Models;

namespace WebApiRest.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AdicionalController : ControllerBase
    {
        readonly PaisData paisData = new();
        readonly CiudadData ciudadData = new();
        readonly EmpresaData empresaData = new();
        readonly AreaData areaData = new();
        readonly TipoRetoData tipoRetoData = new();
        readonly TipoEncuestaData tipoEncuestaData = new();
        readonly ComportPreguntaData comportPreguntaData = new();
        readonly CategoriaNoticiaData categoriaNoticiaData = new();
        readonly CategoriaRecompensaData categoriaRecompensaData = new();
        readonly CondicionData condicionData = new();

        [HttpGet]
        [Route("usuario/{estado}")]
        [Authorize]
        public async Task<IActionResult> Usuario([FromRoute] int estado)
        {
            Adicional response = new()
            {
                PaisList = await paisData.GetPaisList(estado),
                CiudadList = await ciudadData.GetCiudadList(estado),
                EmpresaList = await empresaData.GetEmpresaList(estado),
                AreaList = await areaData.GetAreaList(estado)
            };

            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpGet]
        [Route("reto/{estado}")]
        [Authorize]
        public async Task<IActionResult> Reto([FromRoute] int estado)
        {
            Adicional response = new()
            {
                TipoRetoList = await tipoRetoData.GetTipoRetoList(estado),
                TipoEncuestaList = await tipoEncuestaData.GetTipoEncuestaList(estado),
                ComportPreguntaList = await comportPreguntaData.GetComportPreguntaList(estado),
            };

            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpGet]
        [Route("noticia/{estado}")]
        [Authorize]
        public async Task<IActionResult> Noticia([FromRoute] int estado)
        {
            Adicional response = new()
            {
                CategoriaNoticiaList = await categoriaNoticiaData.GetCategoriaNoticiaList(estado),
            };

            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpGet]
        [Route("recompensa/{estado}")]
        [Authorize]
        public async Task<IActionResult> Recompensa([FromRoute] int estado)
        {
            Adicional response = new()
            {
                CategoriaRecompensaList = await categoriaRecompensaData.GetCategoriaRecompensaList(estado),
            };

            return StatusCode(StatusCodes.Status200OK, new { response });
        }


        [HttpGet]
        [Route("medalla/{estado}")]
        [Authorize]
        public async Task<IActionResult> Medalla([FromRoute] int estado)
        {
            Adicional response = new()
            {
                CondicionList = await condicionData.GetCondicionList(estado),
            };

            return StatusCode(StatusCodes.Status200OK, new { response });
        }
    }
}
