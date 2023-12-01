using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using WebApiRest.Data;
using WebApiRest.Models;

namespace WebApiRest.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class RolController : ControllerBase
    {
        readonly RolData data = new();

        [HttpGet]
        [Route("list/{estado}")]
        public async Task<IActionResult> GetList([FromRoute] int estado)
        {
            RolList response = await data.GetRolList(estado);
            return StatusCode(StatusCodes.Status200OK, new { response });
        }
    }
}
