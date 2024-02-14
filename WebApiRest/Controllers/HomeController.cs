using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using NPOI.POIFS.Crypt.Dsig;
using System.Security.Claims;
using WebApiRest.Data;
using WebApiRest.Models;

namespace WebApiRest.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class HomeController : ControllerBase
    {
        readonly ChartPuntosData dataChartPuntos = new();
        readonly UsuarioData dataUsuario = new();
        readonly ResumenGeneralData dataResumenGeneral = new();
        readonly NoticiaData dataNoticia = new();
        readonly MedallaData dataMedalla  = new();
        readonly RetoData dataReto = new();
        readonly NivelData dataNivel = new();

        [HttpGet]
        [Route("jugador")]
        [Authorize]
        public async Task<IActionResult> Jugador()
        {            
            Claim userClaim = User.FindFirst("id");
            ResumenGeneralItem resumenGeneral = await dataResumenGeneral.GetResumenGeneral(new Guid(userClaim.Value));
            NoticiaList noticiasEnTendencia = await dataNoticia.GetNoticiaTendenciaList(-1);
            Usuario_MedallaList misMedallas = await dataMedalla.GetUsuarioMedallaList(4, new Guid(userClaim.Value));
            Usuario_RetoList misRetosTerminados = await dataReto.GetUsuarioRetoList(10, new Guid(userClaim.Value));
            Usuario_NivelList miNivel = await dataNivel.GetUsuarioNivelList(1, new Guid(userClaim.Value));

            return StatusCode(StatusCodes.Status200OK, new { resumenGeneral, noticiasEnTendencia, misMedallas, misRetosTerminados, miNivel });
        }

        [HttpGet]
        [Route("admin")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> Admin()
        {            
            Claim userClaim = User.FindFirst("id");
            UsuarioList usuariosMasActivos = await dataUsuario.GetUsuarioList(new Guid(userClaim.Value));
            NoticiaList noticiasEnTendencia = await dataNoticia.GetNoticiaTendenciaList(-1);
            ResumenGeneralItem resumenGeneral = await dataResumenGeneral.GetResumenGeneral(new Guid(userClaim.Value));
            ChartPuntosList chartList = await dataChartPuntos.GetChartPuntosList();

            DatasetPuntosList datasetList = new() { Lista = new()};            
            Random random = new();
                        
            var gruposPorAño = chartList.Lista.GroupBy(ob => ob.Año).ToList();            

            foreach (var item in gruposPorAño)
            {
                int r = random.Next(256);
                int g = random.Next(256);
                int b = random.Next(256);

                List<int> dataList = new();                
                for (int i = 0; i < 12; i++)
                {
                    dataList.Add(0);
                }

                foreach (var ob in item)
                {
                    dataList[ob.Mes - 1] += ob.Puntos;
                }

                datasetList.Lista.Add(new DatasetPuntos()
                {
                    Label = $"año {item.Key}",
                    Data = dataList,
                    Fill = false,
                    BorderColor = $"rgb({r}, {g}, {b})",
                    Tension = 0.1
                });
            }
            datasetList.Error = chartList.Error;
            datasetList.Info = chartList.Info;

            return StatusCode(StatusCodes.Status200OK, new { datasetList, usuariosMasActivos, resumenGeneral, noticiasEnTendencia });
        }

    }
}
