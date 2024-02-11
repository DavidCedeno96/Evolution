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

        [HttpGet]
        [Route("jugador")]
        [Authorize]
        public async Task<IActionResult> Jugador()
        {
            string rol = "Jugador";
            return StatusCode(StatusCodes.Status200OK, new { rol });
        }

        [HttpGet]
        [Route("admin")]
        //[Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> Admin()
        {
            Usuario usuario = new();
            Claim userClaim = User.FindFirst("id");
            UsuarioList usuariosActivosList = await dataUsuario.GetUsuarioList(new Guid(userClaim.Value));

            ChartPuntosList chartList = await dataChartPuntos.GetChartPuntosList();
            DatasetPuntosList datasetList = new() { Lista = new()};
            Random random = new();

            var gruposPorAño = chartList.Lista.GroupBy(ob => ob.Año).ToList();            
            int r = random.Next(256);
            int g = random.Next(256);
            int b = random.Next(256);

            foreach (var item in gruposPorAño)
            {
                List<int> dataList = new();                
                for (int i = 0; i < 12; i++)
                {
                    dataList.Add(0);
                }

                foreach (var objeto in item)
                {
                    dataList[objeto.Mes - 1] += objeto.Puntos;
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

            //sp_B_Usuario_fechaLogin

            //sp_B_ResumenGeneral

            //sp_B_Noticia_enTendencia

            string rol = "Administrador";
            return StatusCode(StatusCodes.Status200OK, new { datasetList, usuariosActivosList });
        }

    }
}
