using Microsoft.AspNetCore.Mvc;
using Microsoft.IdentityModel.Tokens;
using System.Collections;
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
        readonly Hasher hasher = new();

        public UsuarioController(IConfiguration configuration)
        {
            settings = configuration.GetSection("settings").Get<Settings>();
        }

        [HttpGet]
        [Route("item/{estado}/{idUsuario}")]
        public async Task<IActionResult> GetUsuarioById([FromRoute] int estado, [FromRoute] Guid idUsuario)
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
                string clave = hasher.Decrypt(response.Usuario.Contrasena);

                if (usuario.Contrasena.Equals(clave))
                {
                    var keyBytes = Encoding.ASCII.GetBytes(settings.SecretKey);
                    var claims = new ClaimsIdentity();
                    claims.AddClaim(new Claim("correo", response.Usuario.Correo));
                    claims.AddClaim(new Claim("id", response.Usuario.IdUsuario.ToString()));
                    claims.AddClaim(new Claim("nombre", response.Usuario.Nombre));
                    claims.AddClaim(new Claim("idRol", response.Usuario.IdRol));
                    claims.AddClaim(new Claim(ClaimTypes.Role, response.Usuario.Rol));
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
        public async Task<IActionResult> Create([FromBody] Usuario usuario)
        {

            Response response = await data.CreateUsuario(usuario);

            return StatusCode(StatusCodes.Status200OK, new { response });
        }
    }
}
