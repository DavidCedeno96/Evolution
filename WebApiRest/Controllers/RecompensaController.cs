using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using NPOI.HSSF.UserModel;
using NPOI.SS.Formula.Functions;
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
    public class RecompensaController : ControllerBase
    {
        readonly RecompensaData data = new();
        readonly UsuarioData dataUser = new();
        readonly CorreoEnvioData dataCorreoEnvio = new();
        readonly NotificacionData dataNotificacion = new();

        private readonly IWebHostEnvironment _env;
        private readonly string nombreCarpeta = "Recompensa";

        public RecompensaController(IWebHostEnvironment env)
        {
            _env = env;
        }

        [HttpGet]
        [Route("list/{estado}")]
        [Authorize]
        public async Task<IActionResult> GetList([FromRoute] int estado)
        {
            Claim userClaim = User.FindFirst("id");
            RecompensaList response = await data.GetRecompensaList(estado);
            UsuarioItem responseUser = await dataUser.GetUsuario(estado, new Guid(userClaim.Value));

            return StatusCode(StatusCodes.Status200OK, new { response, responseUser });
        }

        [HttpGet]
        [Route("buscar")]
        [Authorize]
        public async Task<IActionResult> Buscar([FromQuery] string texto, [FromQuery] string idCategoria)
        {
            RecompensaList response = await data.GetRecompensaList(texto, idCategoria);
            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpGet]
        [Route("item/{estado}/{idRecompensa}")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> GetById([FromRoute] int estado, [FromRoute] Guid idRecompensa)
        {
            RecompensaItem response = await data.GetRecompensa(estado, idRecompensa);            
            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpGet]
        [Route("reporte/recompensa/{estado}")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> Report([FromRoute] int estado)
        {
            Response response = new();
            DataTable dt = new();

            string hora = WC.GetHoraActual(DateTime.Now);
            string nombreArchivo = $"Recompensas{hora}.xls";
            string rutaArchivo = WC.GetRutaArchivo(_env, nombreArchivo, nombreCarpeta);

            WC.EliminarArchivosAntiguos(_env, nombreCarpeta, "Recompensas");

            dt.Columns.Add("NOMBRE", typeof(string));
            dt.Columns.Add("DESCRIPCIÓN", typeof(string));
            dt.Columns.Add("CANTIDAD DISPONIBLE", typeof(int));
            dt.Columns.Add("CRÉDITOS REQUERIDOS", typeof(int));
            dt.Columns.Add("ENTREGADOS", typeof(int));            
            dt.Columns.Add("FECHA DE CREACIÓN", typeof(DateTime));

            RecompensaList responseRecompensas = await data.GetRecompensaList(estado);

            if (responseRecompensas.Error == 0)
            {
                if (responseRecompensas.Lista.Count > 0)
                {
                    foreach (var item in responseRecompensas.Lista)
                    {
                        DataRow row = dt.NewRow();
                        row[0] = item.Nombre;
                        row[1] = item.Descripcion;
                        row[2] = item.CantDisponible;
                        row[3] = item.CantCanje;
                        row[4] = item.TotalUsuarios;                        
                        row[5] = item.FechaCreacion;
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
        public async Task<IActionResult> Create([FromForm] IFormFile archivo, [FromForm] Recompensa recompensa)
        {
            Response response = VF.ValidarRecompensa(recompensa);
            string rutaArchivo = "";

            if (archivo != null && response.Error == 0)
            {
                response = VF.ValidarArchivo(_env, archivo, "jpg/jpeg/png", nombreCarpeta);
                rutaArchivo = WC.GetRutaImagen(_env, archivo.FileName, nombreCarpeta);

                recompensa.Imagen = archivo.FileName.Trim();
            }
            else
            {
                recompensa.Imagen = "";
            }

            if (response.Error == 0)
            {
                response = await data.CreateRecompensa(recompensa);
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
        public async Task<IActionResult> Update([FromForm] IFormFile archivo, [FromForm] Recompensa recompensa)
        {
            Response response = VF.ValidarRecompensa(recompensa);
            string rutaArchivo = "";

            if (archivo != null && response.Error == 0)
            {
                response = VF.ValidarArchivo(_env, archivo, "jpg/jpeg/png", nombreCarpeta);
                rutaArchivo = WC.GetRutaImagen(_env, archivo.FileName, nombreCarpeta);

                recompensa.Imagen = archivo.FileName.Trim();
            }
            else
            {
                recompensa.Imagen = "";
            }

            if (response.Error == 0)
            {
                response = await data.UpdateRecompensa(recompensa);
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

        [HttpPut]
        [Route("updateEstado")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> Update([FromBody] Recompensa recompensa)
        {
            Response response = await data.UpdateRecompensaByEstado(recompensa);
            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpDelete]
        [Route("delete")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> Delete([FromQuery] Guid idRecompensa)
        {
            Response response = await data.DeleteRecompensa(idRecompensa);

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
        [Route("createUsuarioRecompensa")]
        [Authorize]
        public async Task<IActionResult> CreateUsuarioRecompensa([FromBody] Usuario_Recompensa usuarioRecompensa)
        {
            Response response = new();
            CorreoEnvioItem responseCorreoEnvio = await dataCorreoEnvio.GetCorreoEnvio();
            NotificacionItem resNotificacion = await dataNotificacion.GetNotificacion("Notificar a los usuarios cuando canjean una recompensa");

            Claim userClaim = User.FindFirst("id");

            usuarioRecompensa.IdUsuario = new Guid(userClaim.Value);

            UsuarioItem userItem = await dataUser.GetUsuario(-1, new Guid(userClaim.Value));
            RecompensaItem recompensaItem = await data.GetRecompensa(-1, usuarioRecompensa.IdRecompensa);

            if (userItem.Usuario.Creditos < recompensaItem.Recompensa.CantCanje)
            {
                response.Error = 1;
                response.Info = "El usuario tiene créditos insuficientes";
            }
            else if (recompensaItem.Recompensa.CantDisponible < 1)
            {
                response.Error = 1;
                response.Info = "Cantidad insuficiente";
            }
            else
            {
                response = await data.CreateUsuarioRecompensa(usuarioRecompensa);

                if(response.Error == 0 && resNotificacion.Error == 0)
                {
                    if(resNotificacion.Notificacion.Estado == 1)
                    {
                        UsuarioItem responseUser = await dataUser.GetUsuario(1, new Guid(userClaim.Value));
                        RecompensaItem responseRecompensa = await data.GetRecompensa(1, usuarioRecompensa.IdRecompensa);

                        if(responseUser.Error == 0 && responseRecompensa.Error == 0 ) {
                            string imgaen = responseCorreoEnvio.CorreoEnvio.Imagen;
                            string url = responseCorreoEnvio.CorreoEnvio.Url;
                            string colorPri = responseCorreoEnvio.CorreoEnvio.ColorPrimario;
                            string colorSec = responseCorreoEnvio.CorreoEnvio.ColorSecundario;
                            string colorTer = responseCorreoEnvio.CorreoEnvio.ColorTerciario;


                            string urlImageLogo;
                            if (!imgaen.Equals("N/A"))
                            {
                                urlImageLogo = $"{url}/Content/Images/Config/{imgaen}";
                            }
                            else
                            {
                                urlImageLogo = $"{url}/Content/Images/Default/default-logoDM.png";
                            }

                            string urlImageRecompensa;
                            if (!responseRecompensa.Recompensa.Imagen.Equals("N/A"))
                            {
                                urlImageRecompensa = $"{url}/Content/Images/Recompensa/{imgaen}";
                            }
                            else
                            {
                                urlImageRecompensa = $"{url}/Content/Images/Default/default-recompensa.jpg";
                            }

                            response = await WC.EnviarMail(responseCorreoEnvio.CorreoEnvio, responseUser.Usuario.Correo, "Recompensa Canjeada", Html.GetRecompensaCanjeada(urlImageLogo, colorPri,colorSec,colorTer, responseRecompensa.Recompensa.Nombre, urlImageRecompensa, resNotificacion.Notificacion.MsgPersonalizado));
                        } else
                        {
                            response.Info = "Ha ocurrido un error con el usuario o la recompensa al enviar el correo de confirmación";
                            response.Error = 1;
                        }
                    }
                }
            }


            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpPost]
        [Route("import")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> ImportList([FromForm] IFormFile archivo)
        {            
            Response response = new();

            List<Recompensa> lista = new();

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
                            Recompensa recompensa = new();                            
                            for (int j = 0; j < 4; j++)
                            {
                                try
                                {
                                    if (filaEncabezado.GetCell(j).ToString().ToLower().Contains("nombre"))
                                    {
                                        recompensa.Nombre = WC.GetTrim(filaData.GetCell(j, MissingCellPolicy.CREATE_NULL_AS_BLANK).ToString());
                                    }
                                    else if (filaEncabezado.GetCell(j).ToString().ToLower().Contains("cantidad disponible"))
                                    {
                                        recompensa.CantDisponible = Convert.ToInt32(WC.GetTrim(filaData.GetCell(j, MissingCellPolicy.CREATE_NULL_AS_BLANK).ToString()));
                                    }
                                    else if (filaEncabezado.GetCell(j).ToString().ToLower().Contains("cantidad de canje"))
                                    {
                                        recompensa.CantCanje = Convert.ToInt32(WC.GetTrim(filaData.GetCell(j, MissingCellPolicy.CREATE_NULL_AS_BLANK).ToString()));
                                    }
                                    else if (filaEncabezado.GetCell(j).ToString().ToLower().Contains("descripción"))
                                    {
                                        recompensa.Descripcion = WC.GetTrim(filaData.GetCell(j, MissingCellPolicy.CREATE_NULL_AS_BLANK).ToString());
                                    }
                                }
                                catch (Exception) { }
                            }

                            if (!string.IsNullOrEmpty(recompensa.Nombre.Trim()) && recompensa.CantDisponible > 0 && recompensa.CantCanje > 0)
                            {
                                recompensa.Imagen = "";
                                lista.Add(recompensa);
                            }
                        }
                    }

                    if (lista.Count > 0)
                    {
                        foreach (var item in lista)
                        {
                            response = VF.ValidarRecompensa(item);
                            if (response.Error == 0)
                            {
                                response = await data.CreateRecompensa(item);
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
