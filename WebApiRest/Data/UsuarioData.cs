using System.Data.SqlClient;
using System.Data;
using WebApiRest.Models;
using WebApiRest.Utilities;
using System.Text;

namespace WebApiRest.Data
{
    public class UsuarioData
    {
        private readonly Conexion conexion = new();
        private readonly Hasher hasher = new();

        public async Task<UsuarioItem> GetUsuario(string correo)
        {
            UsuarioItem item = new();

            SqlConnection sqlConnection = new(conexion.GetConnectionSqlServer());

            SqlCommand cmd = new("sp_B_UsuarioByCorreo", sqlConnection)
            {
                CommandType = CommandType.StoredProcedure
            };
            cmd.Parameters.AddWithValue("@correo", correo);

            cmd.Parameters.Add("@error", SqlDbType.Int).Direction = ParameterDirection.Output;
            cmd.Parameters.Add("@info", SqlDbType.VarChar, int.MaxValue).Direction = ParameterDirection.Output;
            cmd.Parameters.Add("@id", SqlDbType.VarChar, int.MaxValue).Direction = ParameterDirection.Output;

            try
            {
                await sqlConnection.OpenAsync();
                SqlDataReader dr = await cmd.ExecuteReaderAsync();
                if (await dr.ReadAsync())
                {
                    byte[] binaryDataClave = (byte[])dr.GetValue("clave");

                    item.Usuario = new Usuario()
                    {
                        IdUsuario = new Guid(dr["IdUsuario"].ToString()),
                        Nombre = dr["nombre"].ToString(),
                        Apellido = dr["apellido"].ToString(),
                        Correo = dr["correo"].ToString(),
                        Contrasena = WC.GetStringFromBytes(binaryDataClave),
                        IdRol = dr["idRol"].ToString(),
                        Rol = dr["rol"].ToString(),
                        Estado = Convert.ToInt16(dr["estado"].ToString()),
                    };
                }
                await dr.NextResultAsync();

                item.Info = cmd.Parameters["@info"].Value.ToString();
                item.Error = Convert.ToInt16(cmd.Parameters["@error"].Value.ToString());
            }
            catch (Exception ex)
            {
                item.Info = conexion.GetSettings().Production ? WC.GetError() : ex.Message;
                item.Error = 1;
                item.Usuario = null;
            }
            finally
            {
                await sqlConnection.CloseAsync();
            }

            return item;
        }

        public async Task<UsuarioItem> GetUsuario(int estado, Guid idUsuario)
        {
            UsuarioItem item = new();

            SqlConnection sqlConnection = new(conexion.GetConnectionSqlServer());

            SqlCommand cmd = new("sp_B_UsuarioById", sqlConnection)
            {
                CommandType = CommandType.StoredProcedure
            };            
            cmd.Parameters.AddWithValue("@idUsuario", idUsuario);
            cmd.Parameters.AddWithValue("@estado", estado);

            cmd.Parameters.Add("@error", SqlDbType.Int).Direction = ParameterDirection.Output;
            cmd.Parameters.Add("@info", SqlDbType.VarChar, int.MaxValue).Direction = ParameterDirection.Output;
            cmd.Parameters.Add("@id", SqlDbType.VarChar, int.MaxValue).Direction = ParameterDirection.Output;

            try
            {
                await sqlConnection.OpenAsync();
                SqlDataReader dr = await cmd.ExecuteReaderAsync();
                if (await dr.ReadAsync())
                {
                    item.Usuario = new Usuario()
                    {
                        IdUsuario = new Guid(dr["IdUsuario"].ToString()),
                        Nombre = dr["nombre"].ToString(),
                        Correo = dr["correo"].ToString(),                        
                        IdRol = dr["idRol"].ToString(),
                        Rol = dr["rol"].ToString(),
                        Estado = Convert.ToInt16(dr["estado"].ToString()),                        
                    };
                }
                await dr.NextResultAsync();

                item.Info = cmd.Parameters["@info"].Value.ToString();
                item.Error = Convert.ToInt16(cmd.Parameters["@error"].Value.ToString());
            }
            catch (Exception ex)
            {
                item.Info = conexion.GetSettings().Production ? WC.GetError() : ex.Message;
                item.Error = 1;
                item.Usuario = null;
            }
            finally
            {
                await sqlConnection.CloseAsync();
            }

            return item;
        }

        public async Task<Response> CreateUsuario(Usuario usuario)
        {
            Response response = new();

            SqlConnection sqlConnection = new(conexion.GetConnectionSqlServer());
            SqlCommand cmd = new("sp_C_Usuario", sqlConnection)
            {
                CommandType = CommandType.StoredProcedure
            };

            cmd.Parameters.AddWithValue("@nombre", WC.GetTrim(usuario.Nombre));
            cmd.Parameters.AddWithValue("@apellido", WC.GetTrim(usuario.Apellido));
            cmd.Parameters.AddWithValue("@correo", WC.GetTrim(usuario.Correo));
            cmd.Parameters.AddWithValue("@celular", WC.GetTrim(usuario.Celular));
            cmd.Parameters.AddWithValue("@foto", WC.GetTrim(usuario.Foto));
            cmd.Parameters.AddWithValue("@idRol", WC.GetTrim(usuario.IdRol));
            cmd.Parameters.AddWithValue("@pais", WC.GetTrim(usuario.Pais));
            cmd.Parameters.AddWithValue("@ciudad", WC.GetTrim(usuario.Ciudad));
            cmd.Parameters.AddWithValue("@empresa", WC.GetTrim(usuario.Empresa));
            cmd.Parameters.AddWithValue("@idArea", WC.GetTrim(usuario.IdArea));
            cmd.Parameters.AddWithValue("@clave", WC.GetBytes(hasher.Encrypt(WC.GetTrim(usuario.Contrasena))));

            cmd.Parameters.Add("@error", SqlDbType.Int).Direction = ParameterDirection.Output;
            cmd.Parameters.Add("@info", SqlDbType.VarChar, int.MaxValue).Direction = ParameterDirection.Output;
            cmd.Parameters.Add("@id", SqlDbType.VarChar, int.MaxValue).Direction = ParameterDirection.Output;

            try
            {
                await sqlConnection.OpenAsync();
                await cmd.ExecuteNonQueryAsync();

                string info = cmd.Parameters["@info"].Value.ToString();
                int error = Convert.ToInt16(cmd.Parameters["@error"].Value.ToString());

                response.Info = info.Split(',')[0];
                response.Error = error;                

            }
            catch (Exception ex)
            {
                response.Info = ex.Message;
                response.Error = 1;
            }
            finally
            {
                await sqlConnection.CloseAsync();
            }

            return response;

        }
    }
}
