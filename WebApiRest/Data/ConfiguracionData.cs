using System.Data.SqlClient;
using System.Data;
using WebApiRest.Models;
using WebApiRest.Utilities;

namespace WebApiRest.Data
{
    public class ConfiguracionData
    {
        private readonly Conexion conexion = new();

        public async Task<ConfiguracionList> GetConfiguracionList()
        {
            ConfiguracionList list = new()
            {
                Lista = new()
            };

            SqlConnection sqlConnection = new(conexion.GetConnectionSqlServer());

            SqlCommand cmd = new("sp_B_Configuracion", sqlConnection)
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
                while (await dr.ReadAsync())
                {
                    list.Lista.Add(new Configuracion()
                    {
                        IdConfig = new Guid(dr["idConfig"].ToString()),
                        Tipo = dr["tipo"].ToString(),
                        Propiedad = dr["propiedad"].ToString(),
                        Nombre = dr["nombre"].ToString(),
                        Valor = dr["valor"].ToString(),
                        Descripcion = dr["descripcion"].ToString(),                        
                        Usuario = dr["usuario"].ToString(),
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

        public async Task<ConfiguracionList> GetConfiguracionList(string valor)
        {
            ConfiguracionList list = new()
            {
                Lista = new()
            };

            SqlConnection sqlConnection = new(conexion.GetConnectionSqlServer());

            SqlCommand cmd = new("sp_B_ConfiguracionByValor", sqlConnection)
            {
                CommandType = CommandType.StoredProcedure
            };

            cmd.Parameters.AddWithValue("@valor", WC.GetTrim(valor));

            cmd.Parameters.Add("@error", SqlDbType.Int).Direction = ParameterDirection.Output;
            cmd.Parameters.Add("@info", SqlDbType.VarChar, int.MaxValue).Direction = ParameterDirection.Output;
            cmd.Parameters.Add("@id", SqlDbType.VarChar, int.MaxValue).Direction = ParameterDirection.Output;

            try
            {
                await sqlConnection.OpenAsync();
                SqlDataReader dr = await cmd.ExecuteReaderAsync();
                while (await dr.ReadAsync())
                {
                    list.Lista.Add(new Configuracion()
                    {
                        IdConfig = new Guid(dr["idConfig"].ToString()),
                        Tipo = dr["tipo"].ToString(),
                        Propiedad = dr["propiedad"].ToString(),
                        Nombre = dr["nombre"].ToString(),
                        Valor = dr["valor"].ToString(),
                        Descripcion = dr["descripcion"].ToString(),
                        IdUsuario = new Guid(dr["idUsuario"].ToString()),
                        Usuario = dr["usuario"].ToString(),
                        FechaCreacion = Convert.ToDateTime(dr["fechaCreacion"].ToString()),
                        FechaModificacion = Convert.ToDateTime(dr["fechaModificacion"].ToString())
                    });
                }
                await dr.NextResultAsync();

                list.Info = cmd.Parameters["@info"].Value.ToString();
                list.Error = Convert.ToInt32(cmd.Parameters["@error"].Value.ToString());
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

        public async Task<ConfiguracionItem> GetConfiguracion(string nombre)
        {
            ConfiguracionItem item = new();

            SqlConnection sqlConnection = new(conexion.GetConnectionSqlServer());

            SqlCommand cmd = new("sp_B_ConfiguracionByNombre", sqlConnection)
            {
                CommandType = CommandType.StoredProcedure
            };

            cmd.Parameters.AddWithValue("@nombre", nombre);            

            cmd.Parameters.Add("@error", SqlDbType.Int).Direction = ParameterDirection.Output;
            cmd.Parameters.Add("@info", SqlDbType.VarChar, int.MaxValue).Direction = ParameterDirection.Output;
            cmd.Parameters.Add("@id", SqlDbType.VarChar, int.MaxValue).Direction = ParameterDirection.Output;

            try
            {
                await sqlConnection.OpenAsync();
                SqlDataReader dr = await cmd.ExecuteReaderAsync();
                if (await dr.ReadAsync())
                {
                    item.Configuracion = new Configuracion()
                    {
                        IdConfig = new Guid(dr["idConfig"].ToString()),
                        Tipo = dr["tipo"].ToString(),
                        Propiedad = dr["propiedad"].ToString(),
                        Nombre = dr["nombre"].ToString(),
                        Valor = dr["valor"].ToString(),
                        Descripcion = dr["descripcion"].ToString(),
                        IdUsuario = new Guid(dr["idUsuario"].ToString()),
                        Usuario = dr["usuario"].ToString(),
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
                item.Configuracion = null;
            }
            finally
            {
                await sqlConnection.CloseAsync();
            }

            return item;
        }

        public async Task<Response> CreateConfiguracion(Configuracion configuracion)
        {
            Response response = new();

            SqlConnection sqlConnection = new(conexion.GetConnectionSqlServer());
            SqlCommand cmd = new("sp_C_Configuracion", sqlConnection)
            {
                CommandType = CommandType.StoredProcedure
            };

            cmd.Parameters.AddWithValue("@tipo", WC.GetTrim(configuracion.Tipo));
            cmd.Parameters.AddWithValue("@propiedad", WC.GetTrim(configuracion.Propiedad));
            cmd.Parameters.AddWithValue("@nombre", WC.GetTrim(configuracion.Nombre));
            cmd.Parameters.AddWithValue("@valor", WC.GetTrim(configuracion.Valor));
            cmd.Parameters.AddWithValue("@descripcion", WC.GetTrim(configuracion.Descripcion));
            cmd.Parameters.AddWithValue("@idUsuario", configuracion.IdUsuario);            

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

        public async Task<Response> UpdateConfiguracion(Configuracion configuracion)
        {
            Response response = new();

            SqlConnection sqlConnection = new(conexion.GetConnectionSqlServer());
            SqlCommand cmd = new("sp_U_Configuracion", sqlConnection)
            {
                CommandType = CommandType.StoredProcedure
            };

            cmd.Parameters.AddWithValue("@idConfig", configuracion.IdConfig);            
            cmd.Parameters.AddWithValue("@valor", WC.GetTrim(configuracion.Valor));            
            cmd.Parameters.AddWithValue("@idUsuario", configuracion.IdUsuario);

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
