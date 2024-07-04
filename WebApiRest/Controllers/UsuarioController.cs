using MathNet.Numerics.Distributions;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.IdentityModel.Tokens;
using Newtonsoft.Json;
using NPOI.HSSF.UserModel;
using NPOI.SS.UserModel;
using NPOI.XSSF.UserModel;
using System.Data;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using WebApiRest.Data;
using WebApiRest.Models;
using WebApiRest.Utilities;

namespace WebApiRest.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UsuarioController : ControllerBase
    {
        readonly UsuarioData data = new();

        readonly NivelData dataNivel = new();
        readonly MedallaData dataMedalla = new();
        readonly RetoData dataReto = new();
        readonly RecompensaData dataRecompensa = new();

        readonly CiudadData dataCiudad = new();
        readonly AreaData dataArea = new();
        readonly ConfiguracionData dataConfig = new();
        readonly CorreoEnvioData dataCorreoEnvio = new();
        readonly NotificacionData dataNotificacion = new();

        readonly Settings settings = new();

        private EmailService emailService;
        private readonly IWebHostEnvironment _env;
        private readonly string nombreCarpeta = "Usuario";

        public UsuarioController(IConfiguration configuration, IWebHostEnvironment env)
        {
            settings = configuration.GetSection("settings").Get<Settings>();
            _env = env;
        }

        [HttpGet]
        [Route("list/{estado}")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> List([FromRoute] int estado)
        {
            UsuarioList response = await data.GetUsuarioList(estado);
            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpGet]
        [Route("buscar")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> List([FromQuery] string texto, [FromQuery] int incluirAdmins)
        {
            UsuarioList response = await data.GetUsuarioList(texto, incluirAdmins);
            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpGet]
        [Route("item/{estado}/{idUsuario}")]
        [Authorize]
        public async Task<IActionResult> GetById([FromRoute] int estado, [FromRoute] Guid idUsuario)
        {
            UsuarioItem response = await data.GetUsuario(estado, idUsuario);
            return StatusCode(StatusCodes.Status200OK, new { response});
        }        

        [HttpGet]
        [Route("registerView")]
        public async Task<IActionResult> RegisterView()
        {
            Response response = new();
            ConfiguracionItem config = await dataConfig.GetConfiguracion("registro");

            if(config.Error == 0)
            {
                if(config.Configuracion.Valor == "1")
                {
                    string date = DateTime.Now.ToString();

                    var keyBytes = Encoding.ASCII.GetBytes(settings.SecretKey);
                    var claims = new ClaimsIdentity();                        
                    claims.AddClaim(new Claim("exp_date", date));
                    claims.AddClaim(new Claim("defaultUser", "jugador"));
                    var tokenDescriptor = new SecurityTokenDescriptor
                    {
                        Subject = claims,
                        Expires = DateTime.UtcNow.AddMinutes(10), //Tiempo de expiracion del token en minutos
                        SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(keyBytes), SecurityAlgorithms.HmacSha256Signature)
                    };

                    var tokenHandler = new JwtSecurityTokenHandler();
                    var tokenConfig = tokenHandler.CreateToken(tokenDescriptor);
                    string tokenCreado = tokenHandler.WriteToken(tokenConfig);
                    response.Info = tokenCreado;
                    response.Error = 0;
                }
                else
                {
                    response.Info = "No se permite el registro por que el administrador lo tiene deshabilitado";
                    response.Error = 1;
                }
            } 
            else
            {
                response.Info = config.Info; 
                response.Error = 1;
            }


            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpGet]
        [Route("reporte/usuario/{estado}")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> Report([FromRoute] int estado)
        {
            Response response = new();
            DataTable dt = new();

            //string hora = WC.GetHoraActual(DateTime.Now);
            //string nombreArchivo = $"Usuarios{hora}.xls";
            //string rutaArchivo = WC.GetRutaArchivo(_env, nombreArchivo, nombreCarpeta);

            //WC.EliminarArchivosAntiguos(_env, nombreCarpeta, "Usuarios");

            dt.Columns.Add("NOMBRE", typeof(string));
            dt.Columns.Add("APELLIDO", typeof(string));
            dt.Columns.Add("CORREO ELECTRÓNICO", typeof(string));
            dt.Columns.Add("ID ÚNICO", typeof(string));
            dt.Columns.Add("CELULAR", typeof(string));
            dt.Columns.Add("ROL", typeof(string));
            dt.Columns.Add("PAIS", typeof(string));
            dt.Columns.Add("CIUDAD", typeof(string));
            dt.Columns.Add("EMPRESA", typeof(string));
            dt.Columns.Add("ÁREA", typeof(string));
            dt.Columns.Add("FECHA DE CREACIÓN", typeof(DateTime));

            UsuarioList responseUsers = await data.GetUsuarioList(estado);

            if (responseUsers.Error == 0)
            {
                if (responseUsers.Lista.Count > 0)
                {
                    foreach (var item in responseUsers.Lista)
                    {
                        DataRow row = dt.NewRow();
                        row[0] = item.Nombre;
                        row[1] = item.Apellido;
                        row[2] = item.Correo;
                        row[3] = item.Id;
                        row[4] = item.Celular;
                        row[5] = item.Rol;
                        row[6] = item.Pais;
                        row[7] = item.Ciudad;
                        row[8] = item.Empresa;
                        row[9] = item.Area;
                        row[10] = item.FechaCreacion;
                        dt.Rows.Add(row);
                    }

                    HSSFWorkbook workbook = new();
                    ISheet hoja = workbook.CreateSheet("Usuarios");
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
                    //FileStream fileStream = new(rutaArchivo, FileMode.Create);
                    //workbook.Write(fileStream);
                    //fileStream.Dispose();

                    response.Info = WC.GetSatisfactorio();
                    response.File = WC.GetBytesExcel(workbook);
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

        [HttpGet]
        [Route("logros/{idUsuario}")]
        [Authorize]
        public async Task<IActionResult> GetLogros([FromRoute] Guid idUsuario)
        {
            ResponseObjects response = new() { Lista = new() };

            bool hayError = false;
            string errorInfo = "Error";
            int puntosMiNivel;
            int puntosNecesarios = 100;
            int porcentajeNivel;

            UsuarioItem miInfo = await data.GetUsuario(-1, idUsuario);
            Usuario_NivelList miNivel = await dataNivel.GetUsuarioNivelList(1, idUsuario);
            Usuario_MedallaList misMedallas = await dataMedalla.GetUsuarioMedallaList(5, idUsuario);
            Usuario_RetoList misRetosTerminados = await dataReto.GetUsuarioRetoList(5, idUsuario, 1);
            Usuario_RecompensalList misRecompensasReclamadas = await dataRecompensa.GetUsuarioRecompensaList(idUsuario);

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

            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpPost]
        [Route("auth")]
        public async Task<IActionResult> Login([FromBody] Usuario usuario)
        {
            UsuarioItem response = await data.GetUsuario(usuario.Correo);                        

            if (response.Error == 0)
            {                                
                if (WC.GetTrim(usuario.Contrasena).Equals(response.Usuario.Contrasena))
                {
                    var keyBytes = Encoding.ASCII.GetBytes(settings.SecretKey);
                    var claims = new ClaimsIdentity();
                    //claims.AddClaim(new Claim("puntos", response.Usuario.Puntos.ToString()));
                    //claims.AddClaim(new Claim("creditos", response.Usuario.Creditos.ToString()));
                    claims.AddClaim(new Claim("correo", response.Usuario.Correo));
                    claims.AddClaim(new Claim("id", response.Usuario.IdUsuario.ToString()));
                    claims.AddClaim(new Claim("nombre", $"{response.Usuario.Nombre} {response.Usuario.Apellido}"));
                    claims.AddClaim(new Claim("foto", response.Usuario.Foto));
                    claims.AddClaim(new Claim("rol", response.Usuario.Rol));
                    claims.AddClaim(new Claim(ClaimTypes.Role, response.Usuario.IdRol));
                    var tokenDescriptor = new SecurityTokenDescriptor
                    {
                        Subject = claims,
                        Expires = DateTime.UtcNow.AddMinutes(settings.TimeExpTokenMin), //Tiempo de expiracion del token en minutos
                        SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(keyBytes), SecurityAlgorithms.HmacSha256Signature)
                    };

                    var tokenHandler = new JwtSecurityTokenHandler();
                    var tokenConfig = tokenHandler.CreateToken(tokenDescriptor);
                    string tokenCreado = tokenHandler.WriteToken(tokenConfig);
                    response.Info = tokenCreado;
                    response.Usuario = null;
                }
                else
                {
                    response.Info = WC.GetErrorLogin();
                    response.Error = 1;
                    response.Usuario = null;
                }
            }

            return StatusCode(StatusCodes.Status200OK, new { response });
        }
       
        [HttpPost]
        [Route("create")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> Create([FromForm] IFormFile archivo, [FromForm] Usuario usuario)
        {
            Response response = VF.ValidarUsuario(usuario);
            string rutaArchivo = "";

            if (archivo != null && response.Error == 0)
            {
                string fileName = WC.GetUniqueFileName(archivo, "usr");
                response = VF.ValidarArchivo(_env, archivo, "jpg/jpeg/png", nombreCarpeta);
                rutaArchivo = WC.GetRutaImagen(_env, fileName, nombreCarpeta);

                usuario.Foto = fileName;
            }
            else
            {
                usuario.Foto = "";
            }

            if (string.IsNullOrEmpty(usuario.Contrasena))
            {
                usuario.Contrasena = WC.GenerarContrasena();
            }

            if (response.Error == 0)
            {
                response = await data.CreateUsuario(usuario);
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

        [HttpPost]
        [Route("sendEmail/register")]
        [Authorize]
        public async Task<IActionResult> SendEmail([FromForm] Usuario usuario, [FromForm] string codigoRegistro, [FromForm] string urlVistaActivarUsuario)
        {
            Response response = VF.ValidarUsuario(usuario);
            Response responseUser = await data.GetUsuario(usuario, codigoRegistro);
            CorreoEnvioItem responseCorreoEnvio = await dataCorreoEnvio.GetCorreoEnvio(true);

            if (responseUser.Error > 0)
            {
                response = responseUser;                
            }

            if (responseCorreoEnvio.Error > 0)
            {
                response.Info = responseCorreoEnvio.Info;
                response.Error = 1;
                response.Campo = "correo de envio (admin)";
            }

            if (string.IsNullOrEmpty(usuario.Contrasena))
            {
                usuario.Contrasena = WC.GenerarContrasena();
            }

            if (response.Error == 0)
            {
                usuario.IdRol = "jug";
                string jsonUser = JsonConvert.SerializeObject(usuario);

                string date = DateTime.Now.ToString();

                var keyBytes = Encoding.ASCII.GetBytes(settings.SecretKey);
                var claims = new ClaimsIdentity();
                claims.AddClaim(new Claim("exp_date", date));
                claims.AddClaim(new Claim("tempUser", jsonUser));
                var tokenDescriptor = new SecurityTokenDescriptor
                {
                    Subject = claims,
                    Expires = DateTime.UtcNow.AddMinutes(5), //Tiempo de expiracion del token en minutos
                    SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(keyBytes), SecurityAlgorithms.HmacSha256Signature)
                };

                var tokenHandler = new JwtSecurityTokenHandler();
                var tokenConfig = tokenHandler.CreateToken(tokenDescriptor);
                string tokenCreado = tokenHandler.WriteToken(tokenConfig);

                string imgaen = responseCorreoEnvio.CorreoEnvio.Imagen;
                string url = responseCorreoEnvio.CorreoEnvio.Url;
                string colorPri = responseCorreoEnvio.CorreoEnvio.ColorPrimario;
                string colorSec = responseCorreoEnvio.CorreoEnvio.ColorSecundario;
                string colorTer = responseCorreoEnvio.CorreoEnvio.ColorTerciario;

                if (!imgaen.Equals("N/A"))
                {
                    url += $"/Content/Images/Config/{imgaen}";
                }
                else
                {
                    url += "/Content/Images/Default/default-logoDM.png";
                }

                string urlActivacion = urlVistaActivarUsuario + tokenCreado;

                List<EmailMessage> emailMessages = new()
                {
                    new EmailMessage
                    {
                        Email = usuario.Correo,
                        Subject = "Bienvenido a Play Move",
                        Body = Html.GetRegisterUser(url, colorPri, colorSec, colorTer, urlActivacion, usuario.Correo, usuario.Contrasena)
                    }                    
                };

                emailService = new(responseCorreoEnvio.CorreoEnvio);
                await emailService.SendEmailsInBatches(emailMessages);

                //response = await WC.EnviarMail(responseCorreoEnvio.CorreoEnvio, usuario.Correo, "Bienvenido a Play Move", Html.GetRegisterUser(url, colorPri, colorSec, colorTer, urlActivacion, usuario.Correo, usuario.Contrasena));

                //if(response.Error > 0)
                //{
                //    response.Info = "El correo electrónico de envio del administrador esta incorrecto, contactate con el administrador";
                //}
            }

            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpPost]
        [Route("ActivateUser")]
        [Authorize]
        public async Task<IActionResult> ActivarUsuario()
        {
            string tempUser = User.FindFirst("tempUser").Value;

            Usuario usuario = JsonConvert.DeserializeObject<Usuario>(tempUser);

            usuario.IdRol = "jug";
            Response response = VF.ValidarUsuario(usuario);

            if(response.Error == 0)
            {
                response = await data.CreateUsuario(usuario);
            }

            return StatusCode(StatusCodes.Status200OK, new { response });
        }


        [HttpPut]
        [Route("update")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> Update([FromForm] IFormFile archivo, [FromForm] Usuario usuario)
        {
            Response response = VF.ValidarUsuario(usuario);
            string rutaArchivo = "";

            if (archivo != null && response.Error == 0)
            {
                string fileName = WC.GetUniqueFileName(archivo, "usr");
                response = VF.ValidarArchivo(_env, archivo, "jpg/jpeg/png", nombreCarpeta);
                rutaArchivo = WC.GetRutaImagen(_env, fileName, nombreCarpeta);

                usuario.Foto = fileName;
            }
            else
            {
                usuario.Foto = "";
            }

            if (response.Error == 0)
            {
                response = await data.UpdateUsuario(usuario);
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
        [Route("updateUser")]
        [Authorize]
        public async Task<IActionResult> UpdateUser([FromForm] IFormFile archivo, [FromForm] Usuario usuario)
        {

            Response response = VF.ValidarUsuario(usuario);
            string rutaArchivo = "";
            string userId = User.FindFirst("id").Value;
            string userIdRol = User.FindFirst(ClaimTypes.Role).Value;

            if (archivo != null && response.Error == 0)
            {
                response = VF.ValidarArchivo(_env, archivo, "jpg/jpeg/png", nombreCarpeta);
                rutaArchivo = WC.GetRutaImagen(_env, archivo.FileName, nombreCarpeta);

                usuario.Foto = archivo.FileName.Trim();
            }
            else
            {
                usuario.Foto = "";
            }

            if (response.Error == 0)
            {
                usuario.IdUsuario = new Guid(userId);
                usuario.IdRol = userIdRol;
                response = await data.UpdateUsuario(usuario);
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
        [Route("updateFoto")]
        [Authorize]
        public async Task<IActionResult> UpdateFoto([FromForm] IFormFile archivo)
        {
            Response response = new();
            Usuario usuario = new();
            Claim userClaim = User.FindFirst("id");

            usuario.IdUsuario = new Guid(userClaim.Value);
            response.Error = 0;

            string rutaArchivo = "";

            if (archivo != null && response.Error == 0)
            {
                response = VF.ValidarArchivo(_env, archivo, "jpg/jpeg/png", nombreCarpeta);
                rutaArchivo = WC.GetRutaImagen(_env, archivo.FileName, nombreCarpeta);

                usuario.Foto = archivo.FileName.Trim();
            }
            else
            {
                usuario.Foto = "";
            }

            if (response.Error == 0)
            {
                response = await data.UpdateUsuarioByFoto(usuario);
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
        public async Task<IActionResult> Update([FromBody] Usuario usuario)
        {
            Response response = await data.UpdateUsuarioByEstado(usuario);
            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpPut]
        [Route("massAction/updateEstado")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> Update([FromForm] int estado, [FromForm] string jsonList)
        {
            List<string> listaCorreosIds = JsonConvert.DeserializeObject<List<string>>(jsonList);
            List<Response> response = new();

            foreach (string item in listaCorreosIds)
            {                
                response.Add(await data.UpdateUsuarioByEstado(estado, item));
            }

            return StatusCode(StatusCodes.Status200OK, new { response });
        }


        [HttpPost]
        [Route("import")]
        [Authorize(Roles = "adm,sadm")]
        public async Task<IActionResult> ImportList([FromForm] IFormFile archivo)
        {
            Response response = new();
            CorreoEnvioItem responseCorreoEnvio = await dataCorreoEnvio.GetCorreoEnvio(true);
            NotificacionItem resNotificacion = await dataNotificacion.GetNotificacion("Notificar a los usuarios cuando el administrador crea un nuevo usuario");
            List<EmailMessage> emailMessages = new();

            List<Usuario> lista = new();

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
                            Usuario usuario = new();
                            string empresa = "";

                            for (int j = 0; j < 10; j++)
                            {
                                try
                                {
                                    if (filaEncabezado.GetCell(j).ToString().ToLower().Contains("nombre"))
                                    {
                                        usuario.Nombre = WC.GetTrim(filaData.GetCell(j, MissingCellPolicy.CREATE_NULL_AS_BLANK).ToString());
                                    }
                                    else if (filaEncabezado.GetCell(j).ToString().ToLower().Contains("apellido"))
                                    {
                                        usuario.Apellido = WC.GetTrim(filaData.GetCell(j, MissingCellPolicy.CREATE_NULL_AS_BLANK).ToString());
                                    }
                                    else if (filaEncabezado.GetCell(j).ToString().ToLower().Contains("id único"))
                                    {
                                        usuario.Id = WC.GetTrim(filaData.GetCell(j, MissingCellPolicy.CREATE_NULL_AS_BLANK).ToString());
                                    }
                                    else if (filaEncabezado.GetCell(j).ToString().ToLower().Contains("celular"))
                                    {
                                        usuario.Celular = filaData.GetCell(j, MissingCellPolicy.CREATE_NULL_AS_BLANK).ToString();
                                    }
                                    else if (filaEncabezado.GetCell(j).ToString().ToLower().Contains("correo electrónico"))
                                    {
                                        usuario.Correo = filaData.GetCell(j, MissingCellPolicy.CREATE_NULL_AS_BLANK).ToString();
                                    }
                                    else if (filaEncabezado.GetCell(j).ToString().ToLower().Contains("contraseña"))
                                    {
                                        string clave = filaData.GetCell(j, MissingCellPolicy.CREATE_NULL_AS_BLANK).ToString();
                                        if(!string.IsNullOrEmpty(clave)) {
                                            usuario.Contrasena = clave;
                                        }
                                        else
                                        {
                                            usuario.Contrasena = WC.GenerarContrasena();
                                        }
                                    }
                                    else if (filaEncabezado.GetCell(j).ToString().ToLower().Contains("rol"))
                                    {
                                        string rol = filaData.GetCell(j, MissingCellPolicy.CREATE_NULL_AS_BLANK).ToString();
                                        if (rol.ToLower() == "administrador")
                                        {
                                            usuario.IdRol = "adm";
                                        }
                                        else
                                        {
                                            usuario.IdRol = "jug";
                                        }                                        
                                    }
                                    else if (filaEncabezado.GetCell(j).ToString().ToLower().Contains("ciudad"))
                                    {
                                        string ciudad = filaData.GetCell(j, MissingCellPolicy.CREATE_NULL_AS_BLANK).ToString();
                                        if (!string.IsNullOrEmpty(ciudad))
                                        {
                                            CiudadItem result = await dataCiudad.GetCiudad(ciudad);
                                            if(result.Error == 0)
                                            {
                                                usuario.IdCiudad = result.Ciudad.IdCiudad.ToString();
                                            }
                                            else
                                            {
                                                usuario.IdCiudad = "";
                                            }
                                        }
                                        else
                                        {
                                            usuario.IdCiudad = "";
                                        }

                                    }
                                    else if (filaEncabezado.GetCell(j).ToString().ToLower().Contains("empresa"))
                                    {
                                        empresa = filaData.GetCell(j, MissingCellPolicy.CREATE_NULL_AS_BLANK).ToString();
                                    }
                                    else if (filaEncabezado.GetCell(j).ToString().ToLower().Contains("area"))
                                    {
                                        string area = filaData.GetCell(j, MissingCellPolicy.CREATE_NULL_AS_BLANK).ToString();
                                        if (!string.IsNullOrEmpty(area))
                                        {
                                            AreaItem result = await dataArea.GetArea(area, empresa);
                                            if(result.Error == 0) { 
                                                usuario.IdArea = result.Area.IdArea.ToString();
                                            }
                                            else
                                            {
                                                usuario.IdArea = "";
                                            }
                                        }
                                        else
                                        {
                                            usuario.IdArea = "";
                                        }
                                    }
                                }
                                catch (Exception) { }
                            }

                            if (!string.IsNullOrEmpty(usuario.Nombre.Trim()) && !string.IsNullOrEmpty(usuario.Apellido.Trim()) && !string.IsNullOrEmpty(usuario.Id.Trim()) && !string.IsNullOrEmpty(usuario.Correo.Trim()) && !string.IsNullOrEmpty(usuario.IdRol.Trim()))
                            {
                                usuario.Foto = "";
                                lista.Add(usuario);
                            }
                        }
                    }

                    if (lista.Count > 0)
                    {
                        foreach (var item in lista)
                        {
                            response = VF.ValidarUsuario(item);
                            if (response.Error == 0)
                            {
                                response = await data.CreateUsuario(item);

                                if(response.Error == 0 && responseCorreoEnvio.Error == 0 && resNotificacion.Error == 0)
                                {
                                    string imgaen = responseCorreoEnvio.CorreoEnvio.Imagen;
                                    string url = responseCorreoEnvio.CorreoEnvio.Url;
                                    string colorPri = responseCorreoEnvio.CorreoEnvio.ColorPrimario;
                                    string colorSec = responseCorreoEnvio.CorreoEnvio.ColorSecundario;
                                    string colorTer = responseCorreoEnvio.CorreoEnvio.ColorTerciario;

                                    string urlIniciarSesion = $"{url}/login";

                                    if (!imgaen.Equals("N/A"))
                                    {
                                        url += $"/Content/Images/Config/{imgaen}";
                                    }
                                    else
                                    {
                                        url += "/Content/Images/Default/default-logoDM.png";
                                    }

                                    emailMessages.Add(new EmailMessage
                                    {
                                        Email = item.Correo,
                                        Subject = "Bienvenido a Play Move!",
                                        Body = Html.GetCreateUser(url, colorPri, colorSec, colorTer, urlIniciarSesion, item.Correo, item.Contrasena, resNotificacion.Notificacion.MsgPersonalizado)
                                    });
                                }
                            }
                        }

                        if (resNotificacion.Error == 0 && responseCorreoEnvio.Error == 0)
                        {
                            if (resNotificacion.Notificacion.Estado == 1)
                            {
                                emailService = new(responseCorreoEnvio.CorreoEnvio);
                                await emailService.SendEmailsInBatches(emailMessages);
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
