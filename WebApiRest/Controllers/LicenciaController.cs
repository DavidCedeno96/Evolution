using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using NPOI.POIFS.Crypt.Dsig;
using WebApiRest.Data;
using WebApiRest.Models;
using WebApiRest.Utilities;

namespace WebApiRest.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class LicenciaController : ControllerBase
    {

        readonly LicenciaData data = new();

        [HttpPost]
        [Route("create")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> Create([FromBody] Licencia licencia)
        {
            Response response = VF.ValidarLicencia(licencia);

            if (response.Error == 0)
            {
                response = await data.CreateLicencia(licencia);
            }

            return StatusCode(StatusCodes.Status200OK, new { response });
        }
    }
}
