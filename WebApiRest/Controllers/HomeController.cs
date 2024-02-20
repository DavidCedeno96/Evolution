using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using System.Security.Claims;
using System.Text.RegularExpressions;
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

        [HttpGet]
        [Route("list")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> GetList()
        {
            HomeList response = await data.GetHomeList();
            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpGet]
        [Route("list/{idRol}")]
        [Authorize]
        public async Task<IActionResult> GetList([FromRoute] string idRol)
        {
            HomeList response = await data.GetHomeList(idRol);
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
                if(response.Error == 0)
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

            if(response.Error == 0)
            {
                //Aqui elimina los que no pertencen                        
                response = await data.DeleteHomeByNoIds(idsInicio, idRol);
            }
            
            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpGet]
        [Route("user")]
        [Authorize]
        public async Task<IActionResult> Usuario()
        {
            ResponseObjects response = new() { Lista = new() };
            Claim userClaim = User.FindFirst("id");
            bool hayError = false;
            string errorInfo = "Error ";

            ResumenGeneralItem resumenGeneral = await dataResumenGeneral.GetResumenGeneral(new Guid(userClaim.Value));
            NoticiaList noticiasEnTendencia = await dataNoticia.GetNoticiaTendenciaList(-1);
            Usuario_MedallaList misMedallas = await dataMedalla.GetUsuarioMedallaList(4, new Guid(userClaim.Value));
            ChartPuntosList chartList = await dataChartPuntos.GetChartPuntosList();
            UsuarioList usuariosMasActivos = await dataUsuario.GetUsuarioList(new Guid(userClaim.Value));
            Usuario_RetoList misRetosTerminados = await dataReto.GetUsuarioRetoList(10, new Guid(userClaim.Value));
            Usuario_NivelList miNivel = await dataNivel.GetUsuarioNivelList(1, new Guid(userClaim.Value));

            DatasetPuntosList datasetList = Charts.ChartPuntos(chartList);

            response.Lista.Add(resumenGeneral.ResumenGeneral);
            response.Lista.Add(noticiasEnTendencia.Lista);
            response.Lista.Add(misMedallas.Lista);
            response.Lista.Add(datasetList.Lista);
            response.Lista.Add(usuariosMasActivos.Lista);
            response.Lista.Add(misRetosTerminados.Lista);
            response.Lista.Add(miNivel.Lista);


            if (resumenGeneral.Error > 0)
            {
                hayError = true;
                errorInfo += "Resumen General: " + resumenGeneral.Info;
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


        //[HttpGet]
        //[Route("jugador")]
        //[Authorize]
        //public async Task<IActionResult> Jugador()
        //{            
        //    Claim userClaim = User.FindFirst("id");
        //    ResumenGeneralItem resumenGeneral = await dataResumenGeneral.GetResumenGeneral(new Guid(userClaim.Value));
        //    NoticiaList noticiasEnTendencia = await dataNoticia.GetNoticiaTendenciaList(-1);
        //    Usuario_MedallaList misMedallas = await dataMedalla.GetUsuarioMedallaList(4, new Guid(userClaim.Value));
        //    Usuario_RetoList misRetosTerminados = await dataReto.GetUsuarioRetoList(10, new Guid(userClaim.Value));
        //    Usuario_NivelList miNivel = await dataNivel.GetUsuarioNivelList(1, new Guid(userClaim.Value));

        //    return StatusCode(StatusCodes.Status200OK, new { resumenGeneral, noticiasEnTendencia, misMedallas, misRetosTerminados, miNivel });
        //}

        //[HttpGet]
        //[Route("admin")]
        //[Authorize(Roles = "adm,sadm")]
        //public async Task<IActionResult> Admin()
        //{            
        //    Claim userClaim = User.FindFirst("id");
        //    UsuarioList usuariosMasActivos = await dataUsuario.GetUsuarioList(new Guid(userClaim.Value));
        //    NoticiaList noticiasEnTendencia = await dataNoticia.GetNoticiaTendenciaList(-1);
        //    ResumenGeneralItem resumenGeneral = await dataResumenGeneral.GetResumenGeneral(new Guid(userClaim.Value));
        //    ChartPuntosList chartList = await dataChartPuntos.GetChartPuntosList();

        //    DatasetPuntosList datasetList = new() { Lista = new()};            
        //    Random random = new();
                        
        //    var gruposPorAño = chartList.Lista.GroupBy(ob => ob.Año).ToList();            

        //    foreach (var item in gruposPorAño)
        //    {
        //        int r = random.Next(256);
        //        int g = random.Next(256);
        //        int b = random.Next(256);
        //        int index = 0;

        //        var j = item;

        //        List<int> dataList = new();                
        //        for (int i = 0; i < 12; i++)
        //        {
        //            dataList.Add(0);
        //        }

        //        foreach (var ob in item)
        //        {
        //            index = ob.Mes - 1;
        //            dataList[index] += ob.Puntos;
        //        }

        //        for (int i = 0; i < dataList.Count; i++)
        //        {
        //            if(i > index)
        //            {
        //                dataList[i] = -1;
        //            }
        //        }

        //        dataList.RemoveAll(x => x == -1);

        //        datasetList.Lista.Add(new DatasetPuntos()
        //        {
        //            Label = $"año {item.Key}",
        //            Data = dataList,
        //            Fill = false,
        //            BorderColor = $"rgb({r}, {g}, {b})",
        //            Tension = 0.1
        //        });
        //    }
        //    datasetList.Error = chartList.Error;
        //    datasetList.Info = chartList.Info;

        //    return StatusCode(StatusCodes.Status200OK, new { datasetList, usuariosMasActivos, resumenGeneral, noticiasEnTendencia });
        //}

    }
}
