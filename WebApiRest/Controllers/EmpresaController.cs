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
    public class EmpresaController : ControllerBase
    {
        readonly EmpresaData data = new();

        [HttpGet]
        [Route("list/{estado}")]
        [Authorize]
        public async Task<IActionResult> GetList([FromRoute] int estado)
        {
            EmpresaList response = await data.GetEmpresaList(estado);
            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpPost]
        [Route("create")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> Create([FromBody] Empresa empresa)
        {
            Response response = VF.ValidarEmpresa(empresa);

            if (response.Error == 0)
            {
                response = await data.CreateEmpresa(empresa);
            }

            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpPut]
        [Route("update")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> Update([FromBody] Empresa empresa)
        {
            Response response = VF.ValidarEmpresa(empresa);

            if (response.Error == 0)
            {
                response = await data.UpdateEmpresa(empresa);
            }

            return StatusCode(StatusCodes.Status200OK, new { response });
        }
    }
}
