using System.Data.SqlClient;
using System.Data;
using WebApiRest.Models;
using WebApiRest.Utilities;

namespace WebApiRest.Data
{
    public class NotificacionData
    {
        private readonly Conexion conexion = new();

        public async Task<NotificacionList> GetNotificacionList(int estado)
        {
            NotificacionList list = new()
            {
                Lista = new()
            };

            SqlConnection sqlConnection = new(conexion.GetConnectionSqlServer());

            SqlCommand cmd = new("sp_B_Notificacion", sqlConnection)
            {
                CommandType = CommandType.StoredProcedure
            };

            cmd.Parameters.AddWithValue("@estado", estado);

            cmd.Parameters.Add("@error", SqlDbType.Int).Direction = ParameterDirection.Output;
            cmd.Parameters.Add("@info", SqlDbType.VarChar, int.MaxValue).Direction = ParameterDirection.Output;
            cmd.Parameters.Add("@id", SqlDbType.VarChar, int.MaxValue).Direction = ParameterDirection.Output;

            try
            {
                await sqlConnection.OpenAsync();
                SqlDataReader dr = await cmd.ExecuteReaderAsync();
                while (await dr.ReadAsync())
                {
                    list.Lista.Add(new Notificacion()
                    {
                        IdNotificacion = new Guid(dr["idNotificacion"].ToString()),
                        Nombre = dr["nombre"].ToString(),
                        Estado = Convert.ToInt32(dr["estado"].ToString()),
                        MsgPersonalizado = dr["msgPersonalizado"].ToString(),
                        Descripcion = dr["descripcion"].ToString(),
                        NumDesc = Convert.ToInt32(dr["numDesc"].ToString()),
                        EnviarCorreo = Convert.ToInt32(dr["enviarCorreo"].ToString()),
                        FechaCreacion = Convert.ToDateTime(dr["fechaCreacion"].ToString()),
                        FechaModificacion = Convert.ToDateTime(dr["fechaModificacion"].ToString())
                    });
                }

                list.Info = WC.GetSatisfactorio();
                list.Error = 0;
            }
            catch (Exception ex)
            {
                list.Info = conexion.GetSettings().Production ? WC.GetError() : ex.Message;
                list.Error = 1;
                list.Lista = null;
            }
            finally
            {
                await sqlConnection.CloseAsync();
            }

            return list;
        }

        public async Task<NotificacionItem> GetNotificacion(Guid idNotificacion)
        {
            NotificacionItem item = new();

            SqlConnection sqlConnection = new(conexion.GetConnectionSqlServer());

            SqlCommand cmd = new("sp_B_NotificacionById", sqlConnection)
            {
                CommandType = CommandType.StoredProcedure
            };

            cmd.Parameters.AddWithValue("@idNotificacion", idNotificacion);            

            cmd.Parameters.Add("@error", SqlDbType.Int).Direction = ParameterDirection.Output;
            cmd.Parameters.Add("@info", SqlDbType.VarChar, int.MaxValue).Direction = ParameterDirection.Output;
            cmd.Parameters.Add("@id", SqlDbType.VarChar, int.MaxValue).Direction = ParameterDirection.Output;

            try
            {
                await sqlConnection.OpenAsync();
                SqlDataReader dr = await cmd.ExecuteReaderAsync();
                if (await dr.ReadAsync())
                {
                    item.Notificacion = new Notificacion()
                    {
                        IdNotificacion = new Guid(dr["idNotificacion"].ToString()),
                        Nombre = dr["nombre"].ToString(),
                        Estado = Convert.ToInt32(dr["estado"].ToString()),
                        MsgPersonalizado = dr["msgPersonalizado"].ToString(),
                        Descripcion = dr["descripcion"].ToString(),
                        NumDesc = Convert.ToInt32(dr["numDesc"].ToString()),
                        EnviarCorreo = Convert.ToInt32(dr["enviarCorreo"].ToString()),
                        FechaCreacion = Convert.ToDateTime(dr["fechaCreacion"].ToString()),
                        FechaModificacion = Convert.ToDateTime(dr["fechaModificacion"].ToString())
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
                item.Notificacion = null;
            }
            finally
            {
                await sqlConnection.CloseAsync();
            }

            return item;
        }

        public async Task<NotificacionItem> GetNotificacion(string nombre)
        {
            NotificacionItem item = new();

            SqlConnection sqlConnection = new(conexion.GetConnectionSqlServer());

            SqlCommand cmd = new("sp_B_NotificacionByNombre", sqlConnection)
            {
                CommandType = CommandType.StoredProcedure
            };

            cmd.Parameters.AddWithValue("@nombre", WC.GetTrim(nombre));

            cmd.Parameters.Add("@error", SqlDbType.Int).Direction = ParameterDirection.Output;
            cmd.Parameters.Add("@info", SqlDbType.VarChar, int.MaxValue).Direction = ParameterDirection.Output;
            cmd.Parameters.Add("@id", SqlDbType.VarChar, int.MaxValue).Direction = ParameterDirection.Output;

            try
            {
                await sqlConnection.OpenAsync();
                SqlDataReader dr = await cmd.ExecuteReaderAsync();
                if (await dr.ReadAsync())
                {
                    item.Notificacion = new Notificacion()
                    {
                        IdNotificacion = new Guid(dr["idNotificacion"].ToString()),
                        Nombre = dr["nombre"].ToString(),
                        Estado = Convert.ToInt32(dr["estado"].ToString()),
                        MsgPersonalizado = dr["msgPersonalizado"].ToString(),
                        Descripcion = dr["descripcion"].ToString(),
                        NumDesc = Convert.ToInt32(dr["numDesc"].ToString()),
                        EnviarCorreo = Convert.ToInt32(dr["enviarCorreo"].ToString()),
                        FechaCreacion = Convert.ToDateTime(dr["fechaCreacion"].ToString()),
                        FechaModificacion = Convert.ToDateTime(dr["fechaModificacion"].ToString())
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
                item.Notificacion = null;
            }
            finally
            {
                await sqlConnection.CloseAsync();
            }

            return item;
        }

        public async Task<Response> UpdateNotificacion(Notificacion notificacion)
        {
            Response response = new();

            SqlConnection sqlConnection = new(conexion.GetConnectionSqlServer());
            SqlCommand cmd = new("sp_U_Notificacion", sqlConnection)
            {
                CommandType = CommandType.StoredProcedure
            };

            cmd.Parameters.AddWithValue("@idNotificacion", notificacion.IdNotificacion);
            cmd.Parameters.AddWithValue("@estado", notificacion.Estado);
            cmd.Parameters.AddWithValue("@msgPers", WC.GetTrim(notificacion.MsgPersonalizado));
            cmd.Parameters.AddWithValue("@numDesc ", notificacion.NumDesc);

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

        public async Task<Response> UpdateNotificacionByEstado(Notificacion notificacion)
        {
            Response response = new();

            SqlConnection sqlConnection = new(conexion.GetConnectionSqlServer());
            SqlCommand cmd = new("sp_U_NotificacionByEstado", sqlConnection)
            {
                CommandType = CommandType.StoredProcedure
            };

            cmd.Parameters.AddWithValue("@idNotificacion", notificacion.IdNotificacion);
            cmd.Parameters.AddWithValue("@estado", notificacion.Estado);            

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
