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
        readonly UsuarioData dataUsuario = new();
        readonly NivelData dataNivel = new();
        readonly MedallaData dataMedalla = new();
        readonly RetoData dataReto = new();
        readonly RecompensaData dataRecompensa = new();

        [HttpGet]
        [Route("listByComents")]
        [Authorize]
        public async Task<IActionResult> ListByComments()
        {
            string userId = User.FindFirst("id").Value;
            RedSocialList_comentarios response = await data.GetRedSocialList_comentarios(new Guid(userId));
            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpGet]
        [Route("user/{idRed}")]
        [Authorize]
        public async Task<IActionResult> GetUser([FromRoute] Guid idRed)
        {
            Response responseRedSocial = await data.GetRedSocial(idRed);
            ResponseObjects response = new() { Lista = new() };

            bool hayError = false;
            string errorInfo = "Error";
            int puntosMiNivel;
            int puntosNecesarios = 100;
            int porcentajeNivel;

            if (responseRedSocial.Error == 0)
            {
                string userId = responseRedSocial.Id;

                UsuarioItem miInfo = await dataUsuario.GetUsuario(-1, new Guid(userId));
                Usuario_NivelList miNivel = await dataNivel.GetUsuarioNivelList(1, new Guid(userId));
                Usuario_MedallaList misMedallas = await dataMedalla.GetUsuarioMedallaList(5, new Guid(userId));
                Usuario_RetoList misRetosTerminados = await dataReto.GetUsuarioRetoList(5, new Guid(userId), 1);
                Usuario_RecompensalList misRecompensasReclamadas = await dataRecompensa.GetUsuarioRecompensaList(new Guid(userId));

                if (miNivel.Lista.Count == 0)
                {
                    puntosMiNivel = 0;
                }
                else
                {
                    puntosMiNivel = miNivel.Lista[0].Puntos;
                }

                NivelItem nextNivel = await dataNivel.GetNivel(puntosMiNivel);

                if (nextNivel.Nivel != null)
                {
                    puntosNecesarios = nextNivel.Nivel.PuntosNecesarios;
                }

                double totalPorcentaje = (miInfo.Usuario.Puntos * 100) / puntosNecesarios;
                if (totalPorcentaje >= 100)
                {
                    porcentajeNivel = 100;
                }
                else
                {
                    porcentajeNivel = (int)totalPorcentaje;
                }

                response.Lista.Add(miInfo.Usuario);
                response.Lista.Add(miNivel.Lista);
                response.Lista.Add(nextNivel.Nivel);
                response.Lista.Add(porcentajeNivel);
                response.Lista.Add(misMedallas.Lista);
                response.Lista.Add(misRetosTerminados.Lista);
                response.Lista.Add(misRecompensasReclamadas.Lista);

                
                if (misMedallas.Error > 0)
                {
                    hayError = true;
                    errorInfo += ", Medallas: " + misMedallas.Info;
                }                
                if (misRetosTerminados.Error > 0)
                {
                    hayError = true;
                    errorInfo += ", Retos terminados: " + misRetosTerminados.Info;
                }
                if (miNivel.Error > 0)
                {
                    hayError = true;
                    errorInfo += ", Nivel: " + miNivel.Info;
                }
                if (misRecompensasReclamadas.Error > 0)
                {
                    hayError = true;
                    errorInfo += ", Mis recompensas reclamadas: " + misRecompensasReclamadas.Info;
                }               
                if (nextNivel.Error > 0)
                {
                    hayError = true;
                    errorInfo += ", Proximo nivel: " + nextNivel.Info;
                }                

                if (hayError)
                {
                    response.Error = 1;
                    response.Info = errorInfo;
                }
                else
                {
                    response.Error = 0;
                    response.Info = WC.GetSatisfactorio();
                }

            }
            else
            {
                response.Info = responseRedSocial.Info;
                response.Error = 1;
            }

            
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
