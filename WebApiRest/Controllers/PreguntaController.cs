using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using NPOI.SS.UserModel;
using NPOI.XSSF.UserModel;
using WebApiRest.Data;
using WebApiRest.Models;
using WebApiRest.Utilities;

namespace WebApiRest.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PreguntaController : ControllerBase
    {        
        readonly PreguntaData dataPregunta = new();
        readonly OpcionData dataOpcion = new();        

        [HttpGet]
        [Route("listByIdReto/{estado}/{idReto}")]
        [Authorize]
        public async Task<IActionResult> GetListByIdReto([FromRoute] int estado, [FromRoute] Guid idReto)
        {
            PreguntaList_opciones response = await dataPregunta.GetPreguntaList_opciones(estado, idReto);            

            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpGet]
        [Route("buscar/{texto}/{idReto}")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> Buscar([FromRoute] string texto, [FromRoute] Guid idReto)
        {
            PreguntaList_opciones response = await dataPregunta.GetPreguntaList_opciones(texto, idReto);
            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpGet]
        [Route("item/{estado}/{idPregunta}")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> GetById([FromRoute] int estado, [FromRoute] Guid idPregunta)
        {
            Pregunta_OpcionList response = await dataPregunta.GetPregunta_OpcionList(estado, idPregunta);
            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpPost]
        [Route("create")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> CreateItem([FromBody] Pregunta_OpcionList pregunta_opcionList)
        {

            Response resultPregunta = VF.ValidarPregunta(pregunta_opcionList.Pregunta);
            Response resultOpcion = new();
            Response response = new();
            foreach (var item in pregunta_opcionList.OpcionList)
            {
                resultOpcion = VF.ValidarOpcion(item);
                if (resultOpcion.Error > 0)
                {
                    break;
                }
            }

            if (resultPregunta.Error == 0 && resultOpcion.Error == 0)
            {
                response = await dataPregunta.CreatePregunta(pregunta_opcionList.Pregunta);
                if (response.Error == 0)
                {
                    Guid idPregunta = new(response.Id);
                    foreach (var item in pregunta_opcionList.OpcionList)
                    {
                        item.IdPregunta = idPregunta;
                        response = await dataOpcion.CreateOpcion(item);
                    }
                }
            }
            else if (resultPregunta.Error > 0)
            {
                response.Error = 1;
                response.Info = resultPregunta.Info;
                response.Campo = resultPregunta.Campo;
            }
            else if (resultOpcion.Error > 0)
            {
                response.Error = 1;
                response.Info = resultOpcion.Info;
                response.Campo = resultOpcion.Campo;
            }

            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpPut]
        [Route("update")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> Update([FromBody] Pregunta_OpcionList pregunta_opcionList)
        {

            Response resultPregunta = VF.ValidarPregunta(pregunta_opcionList.Pregunta);
            Response resultOpcion = new();
            Response response = new();
            foreach (var item in pregunta_opcionList.OpcionList)
            {
                resultOpcion = VF.ValidarOpcion(item);
                if (resultOpcion.Error > 0)
                {
                    break;
                }
            }

            if (resultPregunta.Error == 0 && resultOpcion.Error == 0)
            {
                response = await dataPregunta.UpdatePregunta(pregunta_opcionList.Pregunta);
                if (response.Error == 0)
                {
                    Guid idPregunta = pregunta_opcionList.Pregunta.IdPregunta;
                    string idsOpcion = "";
                    List<Opcion> list = pregunta_opcionList.OpcionList;
                    for (int i = 0; i < list.Count; i++)
                    {
                        response = await dataOpcion.UpdateOpcion(list[i]);
                        if (i == list.Count - 1)
                        {
                            // Es el último valor
                            idsOpcion += response.Id;
                        }
                        else
                        {
                            idsOpcion += response.Id + "|";
                        }
                    }
                    if (response.Error == 0)
                    {
                        //Aqui elimina los que no pertencen                        
                        response = await dataOpcion.DeleteOpcionByNoIds(idsOpcion, idPregunta);
                    }
                }
            }
            else if (resultPregunta.Error > 0)
            {
                response.Error = 1;
                response.Info = resultPregunta.Info;
                response.Campo = resultPregunta.Campo;
            }
            else if (resultOpcion.Error > 0)
            {
                response.Error = 1;
                response.Info = resultOpcion.Info;
                response.Campo = resultOpcion.Campo;
            }

            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpDelete]
        [Route("delete/{idPregunta}")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> Delete([FromRoute] Guid idPregunta)
        {
            Response response = await dataPregunta.DeletePregunta(idPregunta);
            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpPost]
        [Route("import/trivia/{idReto}")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> ImportList([FromForm] IFormFile archivo, [FromRoute] Guid idReto)
        {
            bool hayErrorlist = false;
            Response result = new();
            PreguntaList_opciones response = new()
            {
                List = new()
            };

            List<Pregunta_OpcionList> lista = new();

            if (archivo != null)
            {
                Stream stream = archivo.OpenReadStream();
                if (Path.GetExtension(archivo.FileName).Equals(".xlsx"))
                {

                    IWorkbook archivoExcel = new XSSFWorkbook(stream);
                    ISheet hojaExcel = archivoExcel.GetSheetAt(0);
                    int cantidadFilas = hojaExcel.LastRowNum + 1;

                    for (int i = 0; i < cantidadFilas; i++)
                    {
                        if (i > 0)
                        {
                            IRow filaEncabezado = hojaExcel.GetRow(0);
                            IRow filaData = hojaExcel.GetRow(i);
                            Pregunta pregunta = new();
                            List<Opcion> listOp = new();
                            for (int j = 0; j < 6; j++)
                            {
                                try
                                {                                    
                                    if (filaEncabezado.GetCell(j).ToString().ToLower().Contains("pregunta"))
                                    {
                                        pregunta.Nombre = WC.GetTrim(filaData.GetCell(j, MissingCellPolicy.CREATE_NULL_AS_BLANK).ToString());
                                        pregunta.IdReto = idReto;
                                    }
                                    else if (filaEncabezado.GetCell(j).ToString().ToLower().Contains("opcion"))
                                    {
                                        listOp.Add(new Opcion
                                        {
                                            Nombre = WC.GetTrim(filaData.GetCell(j, MissingCellPolicy.CREATE_NULL_AS_BLANK).ToString()),
                                            Correcta = 0
                                        });
                                    }
                                    else if (filaEncabezado.GetCell(j).ToString().ToLower().Contains("correcta"))
                                    {
                                        string opcCorrecta = "opcion " + WC.GetTrim(filaData.GetCell(j, MissingCellPolicy.CREATE_NULL_AS_BLANK).ToString().ToLower());
                                        for (int k = 0; k < 4; k++)
                                        {
                                            if (filaEncabezado.GetCell(k + 1).ToString().ToLower().Trim().Equals(opcCorrecta))
                                            {
                                                listOp[k].Correcta = 1;
                                                break;
                                            }
                                        }
                                    }
                                }
                                catch (Exception) { }
                            }

                            bool tieneOpCorrecta = false;
                            foreach (var item in listOp)
                            {
                                if (item.Correcta > 0)
                                {
                                    tieneOpCorrecta = true;
                                    break;
                                }
                            }

                            if (!string.IsNullOrEmpty(pregunta.Nombre.Trim()) && listOp.Count > 1 && tieneOpCorrecta)
                            {
                                lista.Add(new Pregunta_OpcionList
                                {
                                    Pregunta = pregunta,
                                    OpcionList = listOp,
                                });
                            }
                        }
                    }                    

                    if (lista.Count > 0)
                    {
                        foreach (var item in lista)
                        {
                            Response resultPregunta = VF.ValidarPregunta(item.Pregunta);
                            Response resultOpcion = new();
                            foreach (var op in item.OpcionList)
                            {
                                resultOpcion = VF.ValidarOpcion(op);
                                if (resultOpcion.Error > 0)
                                {
                                    break;
                                }
                            }

                            if (resultPregunta.Error == 0 && resultOpcion.Error == 0)
                            {
                                result = await dataPregunta.CreatePregunta(item.Pregunta);
                                if (result.Error == 0)
                                {                               
                                    Guid idPregunta = new(result.Id);
                                    foreach (var op in item.OpcionList)
                                    {
                                        op.IdPregunta = idPregunta;
                                        op.Valor = 0;
                                        result = await dataOpcion.CreateOpcion(op);
                                    }
                                    if (result.Error == 0)
                                    {
                                        result.Info = result.Info.Split(",")[0];
                                    }
                                }
                            }
                            else if (resultPregunta.Error > 0)
                            {
                                result.Error = 1;
                                result.Info = resultPregunta.Info;
                                result.Campo = resultPregunta.Campo;
                                hayErrorlist = true;
                            }
                            else if (resultOpcion.Error > 0)
                            {
                                result.Error = 1;
                                result.Info = resultOpcion.Info;
                                result.Campo = resultOpcion.Campo;
                                hayErrorlist = true;
                            }

                            if (hayErrorlist)
                            {
                                response.Error = 1;
                                response.Info = "En las preguntas u opciones no se permiten caracteres <, > o =";
                            }

                            response.List.Add(new Pregunta_OpcionList
                            {
                                Info = result.Info,
                                Error = result.Error,
                                Pregunta = item.Pregunta,
                                OpcionList = item.OpcionList,
                            });
                        }
                    }
                    else
                    {
                        response.Error = 1;
                        response.Info = "el Archivo no tiene preguntas válidas";
                    }
                }
                else
                {
                    response.Error = 1;
                    response.Info = "Archivo no permitido";
                }
            }
            else
            {
                response.Error = 1;
                response.Info = "Falta el archivo";
            }

            return StatusCode(StatusCodes.Status200OK, new { response });
        }
    }
}
