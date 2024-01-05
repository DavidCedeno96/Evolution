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
    public class AreaController : ControllerBase
    {
        readonly AreaData data = new();

        [HttpGet]
        [Route("list/{estado}")]
        [Authorize]
        public async Task<IActionResult> GetList([FromRoute] int estado)
        {
            AreaList response = await data.GetAreaList(estado);
            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpPost]
        [Route("create")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> Create([FromBody] Area area)
        {
            Response response = VF.ValidarArea(area);

            if (response.Error == 0)
            {
                response = await data.CreateArea(area);
            }

            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpPut]
        [Route("update")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> Update([FromBody] Area area)
        {
            Response response = VF.ValidarArea(area);

            if (response.Error == 0)
            {
                response = await data.UpdateArea(area);
            }

            return StatusCode(StatusCodes.Status200OK, new { response });
        }
    }
}
