using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using WebApiRest.Data;
using WebApiRest.Models;
using WebApiRest.Utilities;

namespace WebApiRest.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CategoriaNoticiaController : ControllerBase
    {
        readonly CategoriaNoticiaData data = new();

        [HttpGet]
        [Route("list/{estado}")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> GetList([FromRoute] int estado)
        {
            CategoriaList response = await data.GetCategoriaNoticiaList(estado);
            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpGet]
        [Route("buscar/{texto}")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> Buscar([FromRoute] string texto)
        {
            CategoriaList response = await data.GetCategoriaNoticiaList(texto);
            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpGet]
        [Route("item/{estado}/{idCategoria}")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> GetById([FromRoute] int estado, [FromRoute] Guid idCategoria)
        {
            CategoriaItem response = await data.GetCategoriaNoticia(estado, idCategoria);
            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpPost]
        [Route("create")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> Create([FromBody] Categoria categoriaNoticia)
        {
            Response response = VF.ValidarCategoriaNoticia(categoriaNoticia);

            if (response.Error == 0)
            {
                response = await data.CreateCategoriaNoticia(categoriaNoticia);
            }

            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpPut]
        [Route("update")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> Update([FromBody] Categoria categoriaNoticia)
        {
            Response response = VF.ValidarCategoriaNoticia(categoriaNoticia);

            if (response.Error == 0)
            {
                response = await data.UpdateCategoriaNoticia(categoriaNoticia);
            }

            return StatusCode(StatusCodes.Status200OK, new { response });
        }
    }
}
