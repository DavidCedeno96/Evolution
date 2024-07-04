using System.Data.SqlClient;
using System.Data;
using WebApiRest.Utilities;
using WebApiRest.Models;

namespace WebApiRest.Data
{
    public class CorreoEnvioData
    {
        private readonly Conexion conexion = new();

        public async Task<CorreoEnvioItem> GetCorreoEnvio(bool seePassword)
        {
            CorreoEnvioItem item = new();

            SqlConnection sqlConnection = new(conexion.GetConnectionSqlServer());

            SqlCommand cmd = new("sp_B_CorreoEnvio", sqlConnection)
            {
                CommandType = CommandType.StoredProcedure
            };            

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
                    string decryptedText = await Hasher.Decrypt(WC.GetString(binaryDataClave));                    
                    item.CorreoEnvio = new CorreoEnvio()
                    {
                        IdCorreo = new Guid(dr["idCorreo"].ToString()),
                        Nombre = dr["nombre"].ToString(),
                        Correo = dr["correo"].ToString(),
                        Password = seePassword ? decryptedText : null,
                        Puerto = Convert.ToInt32(dr["puerto"].ToString()),
                        Host = dr["host"].ToString(),
                        Imagen = dr["imagen"].ToString(),
                        ColorPrimario = dr["colorPrimario"].ToString(),
                        ColorSecundario = dr["colorSecundario"].ToString(),
                        ColorTerciario = dr["colorTerciario"].ToString(),
                        Url = dr["url"].ToString(),
                    };
                }
                await dr.NextResultAsync();

                item.Info = cmd.Parameters["@info"].Value.ToString();
                item.Error = Convert.ToInt32(cmd.Parameters["@error"].Value.ToString());
            }
            catch (Exception ex)
            {
                item.Info = conexion.GetSettings().Production ? WC.GetError() : ex.Message;
                item.Error = 1;
                item.CorreoEnvio = null;
            }
            finally
            {
                await sqlConnection.CloseAsync();
            }

            return item;
        }

        public async Task<Response> UpdateCorreo(CorreoEnvio correoEnvio)
        {
            Response response = new();

            SqlConnection sqlConnection = new(conexion.GetConnectionSqlServer());
            SqlCommand cmd = new("sp_U_CorreoEnvio", sqlConnection)
            {
                CommandType = CommandType.StoredProcedure
            };

            cmd.Parameters.AddWithValue("@idCorreo", correoEnvio.IdCorreo);
            cmd.Parameters.AddWithValue("@nombre", WC.GetTrim(correoEnvio.Nombre));
            cmd.Parameters.AddWithValue("@correo", WC.GetTrim(correoEnvio.Correo));
            cmd.Parameters.AddWithValue("@puerto", correoEnvio.Puerto);
            cmd.Parameters.AddWithValue("@host", WC.GetTrim(correoEnvio.Host));

            if (WC.GetTrim(correoEnvio.Password).Equals(""))
            {
                cmd.Parameters.AddWithValue("@clave", Array.Empty<byte>());
            }
            else
            {
                cmd.Parameters.AddWithValue("@clave", WC.GetBytes(await Hasher.Encrypt(WC.GetTrim(correoEnvio.Password))));
            }

            cmd.Parameters.Add("@error", SqlDbType.Int).Direction = ParameterDirection.Output;
            cmd.Parameters.Add("@info", SqlDbType.VarChar, int.MaxValue).Direction = ParameterDirection.Output;
            cmd.Parameters.Add("@id", SqlDbType.VarChar, int.MaxValue).Direction = ParameterDirection.Output;

            try
            {
                await sqlConnection.OpenAsync();
                await cmd.ExecuteNonQueryAsync();

                response.Info = cmd.Parameters["@info"].Value.ToString();
                response.Error = Convert.ToInt32(cmd.Parameters["@error"].Value.ToString());

            }
            catch (Exception ex)
            {
                response.Info = conexion.GetSettings().Production ? WC.GetError() : ex.Message;
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
