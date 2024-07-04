using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;
using WebApiRest.Data;
using WebApiRest.Models;

namespace WebApiRest.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class NovedadController : ControllerBase
    {
        readonly NovedadData data = new();
        readonly UsuarioData dataUser = new();

        [HttpGet]
        [Route("list")]
        [Authorize]
        public async Task<IActionResult> GetList()
        {
            Claim userClaim = User.FindFirst("id");
            NovedadList response = await data.GetNovedadList(new Guid(userClaim.Value));
            Response userPtsCrts = await dataUser.GetUsuario(new Guid(userClaim.Value));
            return StatusCode(StatusCodes.Status200OK, new { response, userPtsCrts });
        }

        [HttpPut]
        [Route("updateEstado")]
        [Authorize]
        public async Task<IActionResult> Update([FromBody] Novedad novedad)
        {
            Claim userClaim = User.FindFirst("id");
            novedad.IdUsuario = new Guid(userClaim.Value);
            Response response = await data.UpdateNovedadByEstado(novedad);
            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpDelete]
        [Route("delete")]
        [Authorize]
        public async Task<IActionResult> Delete([FromQuery] Guid idNovedad)
        {
            Claim userClaim = User.FindFirst("id");
            Response response = await data.DeleteNovedad(idNovedad, new Guid(userClaim.Value));
            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpDelete]
        [Route("deleteByUsuario")]
        [Authorize]
        public async Task<IActionResult> DeleteByUsuario()
        {
            Claim userClaim = User.FindFirst("id");
            Response response = await data.DeleteNovedadByUsuario(new Guid(userClaim.Value));
            return StatusCode(StatusCodes.Status200OK, new { response });
        }
    }
}
