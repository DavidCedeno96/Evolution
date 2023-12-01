using System.Data.SqlClient;
using System.Data;
using WebApiRest.Models;
using WebApiRest.Utilities;

namespace WebApiRest.Data
{
    public class UsuarioData
    {
        private readonly Conexion conexion = new();        

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

        public async Task<UsuarioItem> Login(Usuario usuario)
        {
            UsuarioItem item = new();

            SqlConnection sqlConnection = new(conexion.GetConnectionSqlServer());

            SqlCommand cmd = new("sp_B_UsuarioLogin", sqlConnection)
            {
                CommandType = CommandType.StoredProcedure
            };

            cmd.Parameters.AddWithValue("@correo", WC.GetTrim(usuario.Correo));
            cmd.Parameters.AddWithValue("@clave", WC.GetTrim(usuario.Contrasena));

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
                        IdUsuario = new Guid(dr["idUsuario"].ToString()),
                        Nombre = dr["nombre"].ToString(),
                        Correo = dr["correo"].ToString(),
                        IdRol = dr["idRol"].ToString(),
                        Rol = dr["rol"].ToString(),
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
    }
}
