using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using WebApiRest.Data;
using WebApiRest.Models;
using WebApiRest.Utilities;

namespace WebApiRest.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class RedSocialController : ControllerBase
    {
        readonly RedSocialData data = new();

        [HttpGet]
        [Route("listByComents/{estado}")]
        [Authorize]
        public async Task<IActionResult> ListByComments([FromRoute] int estado)
        {
            RedSocialList_comentarios response = await data.GetRedSocialList_comentarios(estado);
            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpPost]
        [Route("createUsuarioRedSocial")]
        [Authorize]
        public async Task<IActionResult> CreateUsuarioNoticia([FromBody] Usuario_RedSocial usuarioRedSocial)
        {
            Response response = VF.ValidarUsuarioRedSocial(usuarioRedSocial);

            if (response.Error == 0)
            {
                response = await data.CreateUsuario_RedSocial(usuarioRedSocial);
            }

            return StatusCode(StatusCodes.Status200OK, new { response });
        }
    }
}
