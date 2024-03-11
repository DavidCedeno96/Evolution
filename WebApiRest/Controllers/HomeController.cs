using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;
using WebApiRest.Data;
using WebApiRest.Models;
using WebApiRest.Utilities;

namespace WebApiRest.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class HomeController : ControllerBase
    {
        readonly HomeData data = new();
        readonly ChartPuntosData dataChartPuntos = new();
        readonly UsuarioData dataUsuario = new();
        readonly ResumenGeneralData dataResumenGeneral = new();
        readonly NoticiaData dataNoticia = new();
        readonly MedallaData dataMedalla  = new();
        readonly RetoData dataReto = new();
        readonly NivelData dataNivel = new();
        readonly RecompensaData dataRecompensa = new();

        [HttpGet]
        [Route("list")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> GetList()
        {
            HomeList response = await data.GetHomeList();
            return StatusCode(StatusCodes.Status200OK, new { response });
        }        

        [HttpGet]
        [Route("user")]
        [Authorize]
        public async Task<IActionResult> Usuario()
        {
            ResponseObjects response = new() { Lista = new() };
            string userId = User.FindFirst("id").Value;            
            string userIdRol = User.FindFirst(ClaimTypes.Role).Value;

            bool hayError = false;
            string errorInfo = "Error";
            int posicionNivel;
            int puntosNecesarios = 100;
            int porcentajeNivel;

            HomeList homeList = await data.GetHomeList(userIdRol);
            UsuarioItem miInfo = await dataUsuario.GetUsuario(-1, new Guid(userId));
            ResumenGeneralItem resumenGeneral = await dataResumenGeneral.GetResumenGeneral(new Guid(userId));
            NoticiaList noticiasEnTendencia = await dataNoticia.GetNoticiaTendenciaList(-1);
            Usuario_MedallaList misMedallas = await dataMedalla.GetUsuarioMedallaList(4, new Guid(userId));
            ChartPuntosList chartList = await dataChartPuntos.GetChartPuntosList();
            UsuarioList usuariosMasActivos = await dataUsuario.GetUsuarioList(new Guid(userId));
            Usuario_RetoList misRetosTerminados = await dataReto.GetUsuarioRetoList(10, new Guid(userId), 1);
            Usuario_NivelList miNivel = await dataNivel.GetUsuarioNivelList(1, new Guid(userId));
            Usuario_RecompensalList recompensasMasReclamadas = await dataRecompensa.GetUsuarioRecompensaList();
            Usuario_RetoList rankingPorPuntos = await dataReto.GetUsuarioRetoList();
            Usuario_RetoList misRetosAsignados = await dataReto.GetUsuarioRetoList(10, new Guid(userId), 0);

            if (miNivel.Lista.Count == 0)
            {
                posicionNivel = 0;
            }
            else
            {
                posicionNivel = miNivel.Lista[0].Posicion;
            }
            NivelItem proximoNivel = await dataNivel.GetNivel(posicionNivel);
            DatasetPuntosList datasetList = Charts.ChartPuntos(chartList);

            if (proximoNivel.Nivel != null)
            {
                puntosNecesarios = proximoNivel.Nivel.PuntosNecesarios;
            }

            double totalPorcentaje = (miInfo.Usuario.Puntos * 100) / puntosNecesarios;
            if(totalPorcentaje >= 100)
            {                
                porcentajeNivel = 100;
            }
            else
            {
                porcentajeNivel = (int)totalPorcentaje;
            }

            response.Lista.Add(homeList.Lista);
            response.Lista.Add(miInfo.Usuario);
            response.Lista.Add(resumenGeneral.ResumenGeneral);
            response.Lista.Add(noticiasEnTendencia.Lista);
            response.Lista.Add(misMedallas.Lista);
            response.Lista.Add(datasetList.Lista);
            response.Lista.Add(usuariosMasActivos.Lista);
            response.Lista.Add(misRetosTerminados.Lista);
            response.Lista.Add(miNivel.Lista);
            response.Lista.Add(proximoNivel.Nivel);
            response.Lista.Add(recompensasMasReclamadas.Lista);
            response.Lista.Add(rankingPorPuntos.Lista);
            response.Lista.Add(misRetosAsignados.Lista);
            response.Lista.Add(porcentajeNivel);


            if (homeList.Error > 0)
            {
                hayError = true;
                errorInfo += ", Lista Vistas: " + homeList.Info;
            }
            if (resumenGeneral.Error > 0)
            {
                hayError = true;
                errorInfo += ", Resumen General: " + resumenGeneral.Info;
            }
            if (noticiasEnTendencia.Error > 0)
            {
                hayError = true;
                errorInfo += ", Noticias: " + noticiasEnTendencia.Info;
            }
            if (misMedallas.Error > 0)
            {
                hayError = true;
                errorInfo += ", Medallas: " + misMedallas.Info;
            }
            if (datasetList.Error > 0)
            {
                hayError = true;
                errorInfo += ", Chart Puntos: " + datasetList.Info;
            }
            if (usuariosMasActivos.Error > 0)
            {
                hayError = true;
                errorInfo += ", Usuarios más activos: " + usuariosMasActivos.Info;
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
            if(recompensasMasReclamadas.Error > 0)
            {
                hayError = true;
                errorInfo += ", Recompensas más reclamadas: " + recompensasMasReclamadas.Info;
            }
            if (rankingPorPuntos.Error > 0)
            {
                hayError = true;
                errorInfo += ", Ranking por puntos: " + rankingPorPuntos.Info;
            }
            if (misRetosAsignados.Error > 0)
            {
                hayError = true;
                errorInfo += ", Mis retos asignados: " + misRetosAsignados.Info;
            }
            if (proximoNivel.Error > 0)
            {
                hayError = true;
                errorInfo += ", Proximo nivel: " + proximoNivel.Info;
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


            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpPut]
        [Route("update/{idRol}")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> Update([FromRoute] string idRol, [FromBody] List<Home> lista)
        {
            Response response = new();
            string idsInicio = "";

            for (int i = 0; i < lista.Count; i++)
            {
                response = await data.UpdateHome(lista[i]);
                if (response.Error == 0)
                {
                    if (i == lista.Count - 1)
                    {
                        // Es el último valor
                        idsInicio += response.Id;
                    }
                    else
                    {
                        idsInicio += response.Id + "|";
                    }
                }
            }

            if (response.Error == 0)
            {
                //Aqui elimina los que no pertencen                        
                response = await data.DeleteHomeByNoIds(idsInicio, idRol);
            }

            return StatusCode(StatusCodes.Status200OK, new { response });
        }        

    }
}
