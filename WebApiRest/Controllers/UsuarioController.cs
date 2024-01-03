using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.IdentityModel.Tokens;
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
        readonly Settings settings = new();        

        private readonly IWebHostEnvironment _env;
        private readonly string nombreCarpeta = "Usuario";

        public UsuarioController(IConfiguration configuration, IWebHostEnvironment env)
        {
            settings = configuration.GetSection("settings").Get<Settings>();
            _env = env;
        }

        [HttpGet]
        [Route("item/{estado}/{idUsuario}")]
        [Authorize]
        public async Task<IActionResult> GetById([FromRoute] int estado, [FromRoute] Guid idUsuario)
        {
            UsuarioItem response = await data.GetUsuario(estado, idUsuario);
            return StatusCode(StatusCodes.Status200OK, new { response});
        }        

        [HttpPost]
        [Route("auth")]
        public async Task<IActionResult> Login([FromBody] Usuario usuario)
        {
            UsuarioItem response = await data.GetUsuario(usuario.Correo);                        

            if (response.Error == 0)
            {                                
                if (usuario.Contrasena.Equals(response.Usuario.Contrasena))
                {
                    var keyBytes = Encoding.ASCII.GetBytes(settings.SecretKey);
                    var claims = new ClaimsIdentity();
                    claims.AddClaim(new Claim("correo", response.Usuario.Correo));
                    claims.AddClaim(new Claim("id", response.Usuario.IdUsuario.ToString()));
                    claims.AddClaim(new Claim("nombre", response.Usuario.Nombre));
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
        public async Task<IActionResult> Create([FromForm] IFormFile archivo, [FromForm] Usuario usuario)
        {
            Response response = VF.ValidarUsuario(usuario);
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

        [HttpPut]
        [Route("update")]
        [Authorize]
        public async Task<IActionResult> Update([FromForm] IFormFile archivo, [FromForm] Usuario usuario)
        {
            Response response = VF.ValidarUsuario(usuario);
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
                if (response.Info.Contains("old_image")) {
                    response.Info = response.Info.Split(',')[0];
                }
            }

            return StatusCode(StatusCodes.Status200OK, new { response });
        }

        [HttpPut]
        [Route("updateEstado")]
        [Authorize(Roles = "adm")]
        public async Task<IActionResult> Update([FromBody] Usuario usuario)
        {
            Response response = await data.UpdateUsuarioByEstado(usuario);
            return StatusCode(StatusCodes.Status200OK, new { response });
        }
    }
}
