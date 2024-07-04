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
    public class CorreoEnvioController : ControllerBase
    {
        private EmailService emailService;
        readonly CorreoEnvioData data = new();

        [HttpGet]
        [Route("list")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> GetList()
        {
            CorreoEnvioItem response = await data.GetCorreoEnvio(false);
            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpPut]
        [Route("update")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> Update([FromBody] CorreoEnvio correoEnvio)
        {
            Response response = VF.ValidarCorreoEnvio(correoEnvio);

            if(response.Error == 0)                        
            {
                if (WC.GetTrim(correoEnvio.Password).Equals(""))
                {
                    CorreoEnvioItem item = await data.GetCorreoEnvio(true);
                    if (item.Error == 0)
                    {
                        correoEnvio.Password = item.CorreoEnvio.Password;
                    }
                }

                emailService = new(correoEnvio);
                response = await emailService.ConnectAsync();

                if(response.Error == 0)
                {
                    response = await data.UpdateCorreo(correoEnvio);
                }

                await emailService.DisconnectAsync();
            }

            return StatusCode(StatusCodes.Status200OK, new { response });
        }
    }
}
