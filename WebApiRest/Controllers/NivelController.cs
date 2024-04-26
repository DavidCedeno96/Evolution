using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using NPOI.HSSF.UserModel;
using NPOI.SS.UserModel;
using NPOI.XSSF.UserModel;
using System.Data;
using System.Security.Claims;
using WebApiRest.Data;
using WebApiRest.Models;
using WebApiRest.Utilities;

namespace WebApiRest.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class NivelController : ControllerBase
    {
        readonly NivelData data = new();

        private readonly IWebHostEnvironment _env;
        private readonly string nombreCarpeta = "Nivel";

        public NivelController(IWebHostEnvironment env)
        {
            _env = env;
        }

        [HttpGet]
        [Route("list/{estado}")]
        [Authorize]
        public async Task<IActionResult> GetList([FromRoute] int estado)
        {
            NivelList response = await data.GetNivelList(estado);
            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpGet]
        [Route("list")]
        [Authorize]
        public async Task<IActionResult> GetByIdUsuario()
        {
            Claim userClaim = User.FindFirst("id");
            Usuario_NivelList response = await data.GetUsuarioNivelList(-1, new Guid(userClaim.Value));

            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpGet]
        [Route("buscar/{texto}")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> Buscar([FromRoute] string texto)
        {
            NivelList response = await data.GetNivelList(texto);
            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpGet]
        [Route("item/{estado}/{idNivel}")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> GetById([FromRoute] int estado, [FromRoute] Guid idNivel)
        {
            NivelItem response = await data.GetNivel(estado, idNivel);
            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpGet]
        [Route("reporte/nivel/{estado}")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> Report([FromRoute] int estado)
        {
            Response response = new();
            DataTable dt = new();

            string hora = WC.GetHoraActual(DateTime.Now);
            string nombreArchivo = $"Niveles{hora}.xls";
            string rutaArchivo = WC.GetRutaArchivo(_env, nombreArchivo, nombreCarpeta);

            WC.EliminarArchivosAntiguos(_env, nombreCarpeta, "Niveles");

            dt.Columns.Add("NOMBRE", typeof(string));
            dt.Columns.Add("DESCRIPCIÓN", typeof(string));
            dt.Columns.Add("PUNTOS NECESARIOS", typeof(int));            
            dt.Columns.Add("CANTIDAD DE USUARIOS", typeof(int));
            dt.Columns.Add("FECHA DE CREACIÓN", typeof(DateTime));

            NivelList responseNiveles = await data.GetNivelList(estado);

            if (responseNiveles.Error == 0)
            {
                if (responseNiveles.Lista.Count > 0)
                {
                    foreach (var item in responseNiveles.Lista)
                    {
                        DataRow row = dt.NewRow();
                        row[0] = item.Nombre;
                        row[1] = item.Descripcion;
                        row[2] = item.PuntosNecesarios;                        
                        row[3] = item.TotalUsuarios;
                        row[4] = item.FechaCreacion;
                        dt.Rows.Add(row);
                    }

                    HSSFWorkbook workbook = new();
                    ISheet hoja = workbook.CreateSheet("Salas");
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
            else
            {
                response.Info = response.Info;
                response.Error = 1;
            }

            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpPost]
        [Route("create")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> Create([FromForm] IFormFile archivo, [FromForm] Nivel nivel)
        {
            Response response = VF.ValidarNivel(nivel);
            string rutaArchivo = "";

            if (archivo != null && response.Error == 0)
            {
                response = VF.ValidarArchivo(_env, archivo, "jpg/jpeg/png/gif", nombreCarpeta);
                rutaArchivo = WC.GetRutaImagen(_env, archivo.FileName, nombreCarpeta);

                nivel.Imagen = archivo.FileName.Trim();
            }
            else
            {
                nivel.Imagen = "";
            }

            if (response.Error == 0)
            {
                response = await data.CreateNivel(nivel);
                if (response.Error == 0 && !rutaArchivo.Equals(""))
                {
                    //Aqui creamos una nueva imagen
                    FileStream fileStream = new(rutaArchivo, FileMode.Create);
                    await archivo.CopyToAsync(fileStream);
                    await fileStream.DisposeAsync();
                }
            }

            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpPut]
        [Route("update")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> Update([FromForm] IFormFile archivo, [FromForm] Nivel nivel)
        {
            Response response = VF.ValidarNivel(nivel);
            string rutaArchivo = "";

            if (archivo != null && response.Error == 0)
            {
                response = VF.ValidarArchivo(_env, archivo, "jpg/jpeg/png/gif", nombreCarpeta);
                rutaArchivo = WC.GetRutaImagen(_env, archivo.FileName, nombreCarpeta);

                nivel.Imagen = archivo.FileName.Trim();
            }
            else
            {
                nivel.Imagen = "";
            }

            if (response.Error == 0)
            {
                response = await data.UpdateNivel(nivel);
                if (response.Error == 0 && !rutaArchivo.Equals(""))
                {
                    string imagenAnterior = response.Info.Split(":")[1];

                    //Aqui eliminamos el archivo anterior
                    string rutaArchivoAnterior = WC.GetRutaImagen(_env, imagenAnterior, nombreCarpeta);
                    if (System.IO.File.Exists(rutaArchivoAnterior))
                    {
                        System.IO.File.Delete(rutaArchivoAnterior);
                    }

                    //Aqui creamos una nueva imagen
                    FileStream fileStream = new(rutaArchivo, FileMode.Create);
                    await archivo.CopyToAsync(fileStream);
                    await fileStream.DisposeAsync();
                }
                if (response.Info.Contains("old_image"))
                {
                    response.Info = response.Info.Split(',')[0];
                }
            }

            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpDelete]
        [Route("delete")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> Delete([FromQuery] Guid idNivel)
        {
            Response response = await data.DeleteNivel(idNivel);

            if (response.Error == 0)
            {
                string imagen = response.Info.Split(":")[1];

                //Aqui eliminamos el archivo
                string rutaArchivo = WC.GetRutaImagen(_env, imagen, nombreCarpeta);
                if (System.IO.File.Exists(rutaArchivo))
                {
                    System.IO.File.Delete(rutaArchivo);
                }

                if (response.Info.Contains("image"))
                {
                    response.Info = response.Info.Split(',')[0];
                }
            }

            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpPost]
        [Route("createUsuarioNivel")]
        [Authorize]
        public async Task<IActionResult> CreateUsuarioNivel([FromBody] Usuario_Nivel usuarioNivel)
        {
            string userId = User.FindFirst("id").Value;
            usuarioNivel.IdUsuario = new Guid(userId);

            Response response = await data.CreateUsuario_Nivel(usuarioNivel);
            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpPost]
        [Route("import")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> ImportList([FromForm] IFormFile archivo)
        {
            Response response = new();

            List<Nivel> lista = new();

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
                            Nivel nivel = new();
                            for (int j = 0; j < 3; j++)
                            {
                                try
                                {
                                    if (filaEncabezado.GetCell(j).ToString().ToLower().Contains("nombre"))
                                    {
                                        nivel.Nombre = WC.GetTrim(filaData.GetCell(j, MissingCellPolicy.CREATE_NULL_AS_BLANK).ToString());
                                    }
                                    else if (filaEncabezado.GetCell(j).ToString().ToLower().Contains("puntos necesarios"))
                                    {
                                        nivel.PuntosNecesarios = Convert.ToInt32(WC.GetTrim(filaData.GetCell(j, MissingCellPolicy.CREATE_NULL_AS_BLANK).ToString()));
                                    }
                                    else if (filaEncabezado.GetCell(j).ToString().ToLower().Contains("descripción"))
                                    {
                                        nivel.Descripcion = WC.GetTrim(filaData.GetCell(j, MissingCellPolicy.CREATE_NULL_AS_BLANK).ToString());
                                    }                                    
                                }
                                catch (Exception) { }
                            }

                            if (!string.IsNullOrEmpty(nivel.Nombre.Trim()) && nivel.PuntosNecesarios > 0)
                            {
                                nivel.Imagen = "";
                                lista.Add(nivel);
                            }
                        }
                    }

                    if (lista.Count > 0)
                    {
                        foreach (var item in lista)
                        {
                            response = VF.ValidarNivel(item);
                            if (response.Error == 0)
                            {
                                response = await data.CreateNivel(item);
                            }
                        }
                    }
                    else
                    {
                        response.Error = 1;
                        response.Info = "el Archivo no tiene registros válidos";
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
