using System.Data.SqlClient;
using System.Data;
using WebApiRest.Models;
using WebApiRest.Utilities;

namespace WebApiRest.Data
{
    public class NivelData
    {
        private readonly Conexion conexion = new();

        public async Task<NivelList> GetNivelList(int estado)
        {
            NivelList list = new()
            {
                Lista = new()
            };

            SqlConnection sqlConnection = new(conexion.GetConnectionSqlServer());

            SqlCommand cmd = new("sp_B_Nivel", sqlConnection)
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
                    list.Lista.Add(new Nivel()
                    {
                        IdNivel = new Guid(dr["idNivel"].ToString()),
                        Nombre = dr["nombre"].ToString(),
                        Descripcion = dr["descripcion"].ToString(),
                        PuntosNecesarios = Convert.ToInt32(dr["puntosNecesarios"].ToString()),                        
                        Imagen = dr["imagen"].ToString(),
                        TotalUsuarios = Convert.ToInt32(dr["totalUsuarios"].ToString()),
                        Estado = Convert.ToInt32(dr["estado"].ToString()),
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

        public async Task<NivelList> GetNivelList(string buscar)
        {
            NivelList list = new()
            {
                Lista = new()
            };

            SqlConnection sqlConnection = new(conexion.GetConnectionSqlServer());

            SqlCommand cmd = new("sp_B_NivelByAll", sqlConnection)
            {
                CommandType = CommandType.StoredProcedure
            };
            cmd.Parameters.AddWithValue("@buscar", buscar);

            cmd.Parameters.Add("@error", SqlDbType.Int).Direction = ParameterDirection.Output;
            cmd.Parameters.Add("@info", SqlDbType.VarChar, int.MaxValue).Direction = ParameterDirection.Output;
            cmd.Parameters.Add("@id", SqlDbType.VarChar, int.MaxValue).Direction = ParameterDirection.Output;

            try
            {
                await sqlConnection.OpenAsync();
                SqlDataReader dr = await cmd.ExecuteReaderAsync();
                while (await dr.ReadAsync())
                {
                    list.Lista.Add(new Nivel()
                    {
                        IdNivel = new Guid(dr["idNivel"].ToString()),
                        Nombre = dr["nombre"].ToString(),
                        Descripcion = dr["descripcion"].ToString(),
                        PuntosNecesarios = Convert.ToInt32(dr["puntosNecesarios"].ToString()),
                        Imagen = dr["imagen"].ToString(),
                        TotalUsuarios = Convert.ToInt32(dr["totalUsuarios"].ToString()),
                        Estado = Convert.ToInt32(dr["estado"].ToString()),
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

        public async Task<NivelItem> GetNivel(int estado, Guid idNivel)
        {
            NivelItem item = new();

            SqlConnection sqlConnection = new(conexion.GetConnectionSqlServer());

            SqlCommand cmd = new("sp_B_NivelById", sqlConnection)
            {
                CommandType = CommandType.StoredProcedure
            };

            cmd.Parameters.AddWithValue("@idNivel", idNivel);
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
                    item.Nivel = new Nivel()
                    {
                        IdNivel = new Guid(dr["idNivel"].ToString()),
                        Nombre = dr["nombre"].ToString(),
                        Descripcion = dr["descripcion"].ToString(),
                        PuntosNecesarios = Convert.ToInt32(dr["puntosNecesarios"].ToString()),
                        Imagen = dr["imagen"].ToString(),
                        TotalUsuarios = Convert.ToInt32(dr["totalUsuarios"].ToString()),
                        Estado = Convert.ToInt32(dr["estado"].ToString()),
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
                item.Nivel = null;
            }
            finally
            {
                await sqlConnection.CloseAsync();
            }

            return item;
        }

        public async Task<Response> CreateNivel(Nivel nivel)
        {
            Response response = new();

            SqlConnection sqlConnection = new(conexion.GetConnectionSqlServer());
            SqlCommand cmd = new("sp_C_Nivel", sqlConnection)
            {
                CommandType = CommandType.StoredProcedure
            };

            cmd.Parameters.AddWithValue("@nombre", WC.GetTrim(nivel.Nombre));
            cmd.Parameters.AddWithValue("@descripcion", WC.GetTrim(nivel.Descripcion));
            cmd.Parameters.AddWithValue("@puntosNecesarios", nivel.PuntosNecesarios);
            cmd.Parameters.AddWithValue("@imagen", WC.GetTrim(nivel.Imagen));

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

        public async Task<Response> UpdateNivel(Nivel nivel)
        {
            Response response = new();

            SqlConnection sqlConnection = new(conexion.GetConnectionSqlServer());
            SqlCommand cmd = new("sp_U_Nivel", sqlConnection)
            {
                CommandType = CommandType.StoredProcedure
            };

            cmd.Parameters.AddWithValue("@idNivel", nivel.IdNivel);
            cmd.Parameters.AddWithValue("@nombre", WC.GetTrim(nivel.Nombre));
            cmd.Parameters.AddWithValue("@descripcion", WC.GetTrim(nivel.Descripcion));
            cmd.Parameters.AddWithValue("@puntosNecesarios", nivel.PuntosNecesarios);
            cmd.Parameters.AddWithValue("@imagen", WC.GetTrim(nivel.Imagen));

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

        public async Task<Response> DeleteNivel(Guid idNivel)
        {
            Response response = new();

            SqlConnection sqlConnection = new(conexion.GetConnectionSqlServer());
            SqlCommand cmd = new("sp_D_Nivel", sqlConnection)
            {
                CommandType = CommandType.StoredProcedure
            };
            
            cmd.Parameters.AddWithValue("@idNivel", idNivel);

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

        public async Task<Response> CreateUsuario_Nivel(Usuario_Nivel usuario_nivel)
        {
            Response response = new();

            SqlConnection sqlConnection = new(conexion.GetConnectionSqlServer());
            SqlCommand cmd = new("sp_C_Usuario_Nivel", sqlConnection)
            {
                CommandType = CommandType.StoredProcedure
            };

            cmd.Parameters.AddWithValue("@idUsuario", usuario_nivel.IdUsuario);
            cmd.Parameters.AddWithValue("@idNivel", usuario_nivel.IdNivel);

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
