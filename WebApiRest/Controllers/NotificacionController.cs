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
    public class NotificacionController : ControllerBase
    {
        readonly NotificacionData data = new();

        [HttpGet]
        [Route("list/{estado}")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> GetList([FromRoute] int estado)
        {
            NotificacionList response = await data.GetNotificacionList(estado);
            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpGet]
        [Route("item/{idNotificacion}")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> GetById([FromRoute] Guid idNotificacion)
        {
            NotificacionItem response = await data.GetNotificacion(idNotificacion);
            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpPut]
        [Route("update")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> Update([FromBody] Notificacion notificacion)
        {
            Response response = VF.ValidarNotificacion(notificacion);
            
            if(response.Error == 0)
            {
                response = await data.UpdateNotificacion(notificacion);
            }            

            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpPut]
        [Route("updateEstado")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> UpdateEstado([FromBody] Notificacion notificacion)
        {
            Response response = VF.ValidarNotificacion(notificacion);

            if (response.Error == 0)
            {
                response = await data.UpdateNotificacionByEstado(notificacion);
            }

            return StatusCode(StatusCodes.Status200OK, new { response });
        }
    }
}
