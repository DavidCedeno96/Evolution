using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using NPOI.HSSF.UserModel;
using NPOI.SS.UserModel;
using NPOI.XSSF.UserModel;
using System.Data;
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
        readonly TipoEntradaData tipoEntradaData = new();

        private readonly IWebHostEnvironment _env;
        private readonly string nombreCarpeta = "Pregunta";

        public PreguntaController(IWebHostEnvironment env)
        {
            _env = env;
        }

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
        

        [HttpGet]
        [Route("export/results/{estado}/{idReto}")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> ExportList([FromRoute] int estado, [FromRoute] Guid idReto)
        {            
            DataTable dt = new();

            string hora = WC.GetHoraActual(DateTime.Now);
            string nombreArchivo = $"Preguntas{hora}.xls";
            string rutaArchivo = WC.GetRutaArchivo(_env, nombreArchivo, nombreCarpeta);

            WC.EliminarArchivosAntiguos(_env, nombreCarpeta, "Preguntas");

            dt.Columns.Add("PREGUNTA", typeof(string));
            dt.Columns.Add("OPCION A", typeof(string));
            dt.Columns.Add("CANTIDAD DE VOTOS A", typeof(int));
            dt.Columns.Add("OPCION B", typeof(string));
            dt.Columns.Add("CANTIDAD DE VOTOS B", typeof(int));
            dt.Columns.Add("OPCION C", typeof(string));
            dt.Columns.Add("CANTIDAD DE VOTOS C", typeof(int));
            dt.Columns.Add("OPCION D", typeof(string));
            dt.Columns.Add("CANTIDAD DE VOTOS D", typeof(int));
            dt.Columns.Add("OPCION E", typeof(string));
            dt.Columns.Add("CANTIDAD DE VOTOS E", typeof(int));
            dt.Columns.Add("OPCION F", typeof(string));
            dt.Columns.Add("CANTIDAD DE VOTOS F", typeof(int));
            dt.Columns.Add("OPCION G", typeof(string));
            dt.Columns.Add("CANTIDAD DE VOTOS G", typeof(int));
            dt.Columns.Add("OPCION H", typeof(string));
            dt.Columns.Add("CANTIDAD DE VOTOS H", typeof(int));
            dt.Columns.Add("OPCION I", typeof(string));
            dt.Columns.Add("CANTIDAD DE VOTOS I", typeof(int));
            dt.Columns.Add("OPCION J", typeof(string));
            dt.Columns.Add("CANTIDAD DE VOTOS J", typeof(int));
            dt.Columns.Add("TOTAL DE VOTOS", typeof(int));

            PreguntaList_opciones response = await dataPregunta.GetPreguntaList_opciones(estado, idReto);

            if (response.Error == 0)
            {
                if (response.List.Count > 0)
                {
                    foreach (var item in response.List)
                    {
                        int totalVotos = 0;
                        DataRow row = dt.NewRow();
                        row[0] = item.Pregunta.Nombre;

                        for (int i = 0; i < item.OpcionList.Count; i++)
                        {
                            var op = item.OpcionList[i];

                            row[$"OPCION {WC.GetLetraByNumero(i + 1)}"] = op.Nombre;
                            row[$"CANTIDAD DE VOTOS {WC.GetLetraByNumero(i + 1)}"] = op.CantVotos;

                            totalVotos += op.CantVotos;                            
                        }

                        row[21] = totalVotos;
                        dt.Rows.Add(row);
                    }

                    HSSFWorkbook workbook = new();
                    ISheet hoja = workbook.CreateSheet("Resultados");
                    IRow headerRow = hoja.CreateRow(0);

                    for (int i = 0; i < dt.Columns.Count; i++)
                    {
                        headerRow.CreateCell(i).SetCellValue(dt.Columns[i].ColumnName);
                    }

                    for (int rowIndex = 0; rowIndex < dt.Rows.Count; rowIndex++)
                    {
                        IRow dataRow = hoja.CreateRow(rowIndex + 1);

                        for (int columnIndex = 0; columnIndex < dt.Columns.Count; columnIndex++)
                        {
                            dataRow.CreateCell(columnIndex).SetCellValue(dt.Rows[rowIndex][columnIndex].ToString());
                        }
                    }

                    //Aqui crea el archivo
                    FileStream fileStream = new(rutaArchivo, FileMode.Create);
                    workbook.Write(fileStream);
                    fileStream.Dispose();

                    response.Info = nombreArchivo;
                    response.Error = 0;
                }
                else
                {
                    response.Info = "La lista esta vacia";
                    response.Error = 1;
                }
            }            

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
                                        op.IdTipoEntrada = new Guid("7c8c2672-2233-486a-a184-f0b51eb4a331");
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

        [HttpPost]
        [Route("import/encuesta/voto/{idReto}")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> ImportListVoto([FromForm] IFormFile archivo, [FromRoute] Guid idReto)
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
                            for (int j = 0; j < 11; j++)
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
                                            Correcta = 0,                                            
                                        });
                                    }                                    
                                }
                                catch (Exception) { }
                            }                               
                                                    
                            if (!string.IsNullOrEmpty(pregunta.Nombre.Trim()) && listOp.Count > 1)
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
                                        op.IdTipoEntrada = new Guid("7c8c2672-2233-486a-a184-f0b51eb4a331");
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

        [HttpPost]
        [Route("import/encuesta/satisfaccion/{idReto}")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> ImportListSatisfaccion([FromForm] IFormFile archivo, [FromRoute] Guid idReto)
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
                            List<int> listValor = new();
                            for (int j = 0; j < 11; j++)
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
                                        string nombreOp = WC.GetTrim(filaData.GetCell(j, MissingCellPolicy.CREATE_NULL_AS_BLANK).ToString());

                                        if (!string.IsNullOrEmpty(nombreOp))
                                        {
                                            listOp.Add(new Opcion
                                            {
                                                Nombre = WC.GetTrim(filaData.GetCell(j, MissingCellPolicy.CREATE_NULL_AS_BLANK).ToString()),
                                                Correcta = 0,
                                                Valor = 0,
                                            });
                                        }

                                    }
                                    else if (filaEncabezado.GetCell(j).ToString().ToLower().Contains("escala"))
                                    {
                                        int valor = Convert.ToInt32(WC.GetTrim(filaData.GetCell(j, MissingCellPolicy.CREATE_NULL_AS_BLANK).ToString()));                                        
                                        if(valor > 0 && valor < 6)
                                        {
                                            listValor.Add(valor);
                                        }
                                    }
                                }
                                catch (Exception) { }
                            }

                            if (listValor.Count >= listOp.Count)
                            {
                                for (int k = 0; k < listOp.Count; k++)
                                {
                                    Opcion op = listOp[k];
                                    if (!op.Nombre.Trim().Equals(""))
                                    {
                                        op.Valor = listValor[k];
                                    }
                                }
                            }

                            if (!string.IsNullOrEmpty(pregunta.Nombre.Trim()) && listOp.Count == 5 && listValor.Count == 5)
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
                                        op.IdTipoEntrada = new Guid("7c8c2672-2233-486a-a184-f0b51eb4a331");
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

        [HttpPost]
        [Route("import/seguimiento_evaluacion/{idReto}")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> ImportListSeg_eva([FromForm] IFormFile archivo, [FromRoute] Guid idReto)
        {
            bool hayErrorlist = false;
            Response result = new();
            PreguntaList_opciones response = new()
            {
                List = new()
            };

            List<Pregunta_OpcionList> lista = new();

            TipoEntradaList tipoEntradaList = await tipoEntradaData.GetTipoEntradaList(1);

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
                            List<Guid> listEntrada = new();
                            for (int j = 0; j < 11; j++)
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
                                        string nombreOp = WC.GetTrim(filaData.GetCell(j, MissingCellPolicy.CREATE_NULL_AS_BLANK).ToString());

                                        if (!string.IsNullOrEmpty(nombreOp))
                                        {
                                            listOp.Add(new Opcion
                                            {
                                                Nombre = nombreOp,
                                                Correcta = 0,
                                                Valor = 0,
                                            });
                                        }
                                    }
                                    else if (filaEncabezado.GetCell(j).ToString().ToLower().Contains("entrada"))
                                    {
                                        string entrada = WC.GetTrim(filaData.GetCell(j, MissingCellPolicy.CREATE_NULL_AS_BLANK).ToString());                                        

                                        Guid idTipoEntrada = tipoEntradaList.Lista.Where(e => e.Nombre.Equals(entrada, StringComparison.OrdinalIgnoreCase))
                                                            .Select(e => e.IdTipoEntrada)
                                                            .FirstOrDefault();

                                        if(idTipoEntrada != Guid.Empty)
                                        {
                                            listEntrada.Add(idTipoEntrada);
                                        }

                                    }
                                }
                                catch (Exception) { }
                            }

                            if(listEntrada.Count >= listOp.Count)
                            {
                                for (int k = 0; k < listOp.Count; k++)
                                {
                                    Opcion op = listOp[k];
                                    Guid idEntrada = listEntrada[k];

                                    if (!op.Nombre.Trim().Equals(""))
                                    {
                                        op.IdTipoEntrada = idEntrada;
                                    }
                                }
                            }

                            if (!string.IsNullOrEmpty(WC.GetTrim(pregunta.Nombre)) && listOp.Count > 1 && listEntrada.Count >= listOp.Count)
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
