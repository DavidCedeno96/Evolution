using System.Data.SqlClient;
using System.Data;
using WebApiRest.Models;
using WebApiRest.Utilities;

namespace WebApiRest.Data
{
    public class RetoData
    {
        private readonly Conexion conexion = new();

        public async Task<RetoList> GetRetoList(int estado)
        {
            RetoList list = new()
            {
                Lista = new()
            };

            SqlConnection sqlConnection = new(conexion.GetConnectionSqlServer());

            SqlCommand cmd = new("sp_B_Reto", sqlConnection)
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
                    list.Lista.Add(new Reto()
                    {
                        IdReto = new Guid(dr["idReto"].ToString()),
                        Nombre = dr["nombre"].ToString(),
                        FechaApertura = Convert.ToDateTime(dr["fechaApetura"].ToString()),
                        FechaCierre = Convert.ToDateTime(dr["fechaCierre"].ToString()),                        
                        Vidas = Convert.ToInt32(dr["vidas"].ToString()),
                        Tiempo_ms = Convert.ToInt32(dr["tiempo_ms"].ToString()),
                        PuntosRecompensa = Convert.ToInt32(dr["puntosRecompensa"].ToString()),
                        CreditosObtenidos = Convert.ToInt32(dr["creditosObtenidos"].ToString()),
                        Instrucciones = dr["instrucciones"].ToString(),
                        Imagen = dr["imagen"].ToString(),
                        IdTipoReto = new Guid(dr["idTipoReto"].ToString()),
                        TipoReto = dr["TipoReto"].ToString(),
                        IdComportamiento = new Guid(dr["idComportamiento"].ToString()),
                        ComportamientoPregunta = dr["ComportamientoPregunta"].ToString(),
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

        public async Task<RetoList> GetRetoList(string buscar)
        {
            RetoList list = new()
            {
                Lista = new()
            };

            SqlConnection sqlConnection = new(conexion.GetConnectionSqlServer());

            SqlCommand cmd = new("sp_B_RetoByAll", sqlConnection)
            {
                CommandType = CommandType.StoredProcedure
            };

            cmd.Parameters.AddWithValue("@buscar", WC.GetTrim(buscar));

            cmd.Parameters.Add("@error", SqlDbType.Int).Direction = ParameterDirection.Output;
            cmd.Parameters.Add("@info", SqlDbType.VarChar, int.MaxValue).Direction = ParameterDirection.Output;
            cmd.Parameters.Add("@id", SqlDbType.VarChar, int.MaxValue).Direction = ParameterDirection.Output;

            try
            {
                await sqlConnection.OpenAsync();
                SqlDataReader dr = await cmd.ExecuteReaderAsync();
                while (await dr.ReadAsync())
                {
                    list.Lista.Add(new Reto()
                    {
                        IdReto = new Guid(dr["idReto"].ToString()),
                        Nombre = dr["nombre"].ToString(),
                        FechaApertura = Convert.ToDateTime(dr["fechaApetura"].ToString()),
                        FechaCierre = Convert.ToDateTime(dr["fechaCierre"].ToString()),
                        Vidas = Convert.ToInt32(dr["vidas"].ToString()),
                        Tiempo_ms = Convert.ToInt32(dr["tiempo_ms"].ToString()),
                        PuntosRecompensa = Convert.ToInt32(dr["puntosRecompensa"].ToString()),
                        CreditosObtenidos = Convert.ToInt32(dr["creditosObtenidos"].ToString()),
                        Instrucciones = dr["instrucciones"].ToString(),
                        Imagen = dr["imagen"].ToString(),
                        IdTipoReto = new Guid(dr["idTipoReto"].ToString()),
                        TipoReto = dr["TipoReto"].ToString(),
                        IdComportamiento = new Guid(dr["idComportamiento"].ToString()),
                        ComportamientoPregunta = dr["ComportamientoPregunta"].ToString(),
                        Estado = Convert.ToInt32(dr["estado"].ToString()),
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

        public async Task<Usuario_RetoList> GetUsuarioRetoList(int top, Guid idUsuario)
        {
            Usuario_RetoList list = new()
            {
                Lista = new()
            };

            SqlConnection sqlConnection = new(conexion.GetConnectionSqlServer());

            SqlCommand cmd = new("sp_B_Usuario_RetoByIdUsuario", sqlConnection)
            {
                CommandType = CommandType.StoredProcedure
            };

            cmd.Parameters.AddWithValue("@idUsuario", idUsuario);
            cmd.Parameters.AddWithValue("@top", top);

            cmd.Parameters.Add("@error", SqlDbType.Int).Direction = ParameterDirection.Output;
            cmd.Parameters.Add("@info", SqlDbType.VarChar, int.MaxValue).Direction = ParameterDirection.Output;
            cmd.Parameters.Add("@id", SqlDbType.VarChar, int.MaxValue).Direction = ParameterDirection.Output;

            try
            {
                await sqlConnection.OpenAsync();
                SqlDataReader dr = await cmd.ExecuteReaderAsync();
                while (await dr.ReadAsync())
                {
                    list.Lista.Add(new Usuario_Reto()
                    {
                        IdReto = new Guid(dr["idReto"].ToString()),
                        Nombre = dr["nombre"].ToString(),
                        Imagen = dr["imagen"].ToString(),
                        TipoReto = dr["tipoReto"].ToString(),
                        IdUsuario = new Guid(dr["idUsuario"].ToString()),
                        PuntosRecompensa = Convert.ToInt32(dr["puntos"].ToString()),                        
                        Tiempo = Convert.ToInt32(dr["tiempo"].ToString()),                        
                        Vidas = Convert.ToInt32(dr["vidas"].ToString()),                        
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

        public async Task<RetoItem> GetReto(int estado, Guid idReto)
        {
            RetoItem item = new();

            SqlConnection sqlConnection = new(conexion.GetConnectionSqlServer());

            SqlCommand cmd = new("sp_B_RetoById", sqlConnection)
            {
                CommandType = CommandType.StoredProcedure
            };

            cmd.Parameters.AddWithValue("@idReto", idReto);
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
                    item.Reto = new Reto()
                    {
                        IdReto = new Guid(dr["idReto"].ToString()),
                        Nombre = dr["nombre"].ToString(),
                        FechaApertura = Convert.ToDateTime(dr["fechaApetura"].ToString()),
                        FechaCierre = Convert.ToDateTime(dr["fechaCierre"].ToString()),
                        Vidas = Convert.ToInt32(dr["vidas"].ToString()),
                        Tiempo_ms = Convert.ToInt32(dr["tiempo_ms"].ToString()),
                        PuntosRecompensa = Convert.ToInt32(dr["puntosRecompensa"].ToString()),
                        CreditosObtenidos = Convert.ToInt32(dr["creditosObtenidos"].ToString()),
                        Instrucciones = dr["instrucciones"].ToString(),
                        Imagen = dr["imagen"].ToString(),
                        IdTipoReto = new Guid(dr["idTipoReto"].ToString()),
                        TipoReto = dr["TipoReto"].ToString(),
                        IdComportamiento = new Guid(dr["idComportamiento"].ToString()),
                        ComportamientoPregunta = dr["ComportamientoPregunta"].ToString(),
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
                item.Reto = null;
            }
            finally
            {
                await sqlConnection.CloseAsync();
            }

            return item;
        }

        public async Task<Response> CreateReto(Reto reto)
        {
            Response response = new();

            SqlConnection sqlConnection = new(conexion.GetConnectionSqlServer());
            SqlCommand cmd = new("sp_C_Reto", sqlConnection)
            {
                CommandType = CommandType.StoredProcedure
            };

            cmd.Parameters.AddWithValue("@nombre", WC.GetTrim(reto.Nombre));
            cmd.Parameters.AddWithValue("@fechaApertura", reto.FechaApertura.ToString("yyyy-MM-dd"));
            cmd.Parameters.AddWithValue("@fechaCierre", reto.FechaCierre.ToString("yyyy-MM-dd"));
            cmd.Parameters.AddWithValue("@vidas", reto.Vidas);
            cmd.Parameters.AddWithValue("@tiempo", reto.Tiempo_ms);
            cmd.Parameters.AddWithValue("@puntosRecompensa", reto.PuntosRecompensa);
            cmd.Parameters.AddWithValue("@creditosObtenidos", reto.CreditosObtenidos);
            cmd.Parameters.AddWithValue("@instrucciones", WC.GetTrim(reto.Instrucciones));
            cmd.Parameters.AddWithValue("@imagen", WC.GetTrim(reto.Imagen));
            cmd.Parameters.AddWithValue("@idTipoReto", reto.IdTipoReto);
            cmd.Parameters.AddWithValue("@idComportamiento", reto.IdComportamiento);

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

        public async Task<Response> UpdateReto(Reto reto)
        {
            Response response = new();

            SqlConnection sqlConnection = new(conexion.GetConnectionSqlServer());
            SqlCommand cmd = new("sp_U_Reto", sqlConnection)
            {
                CommandType = CommandType.StoredProcedure
            };

            cmd.Parameters.AddWithValue("@idReto", reto.IdReto);
            cmd.Parameters.AddWithValue("@nombre", WC.GetTrim(reto.Nombre));
            cmd.Parameters.AddWithValue("@fechaApertura", reto.FechaApertura.ToString("yyyy-MM-dd"));
            cmd.Parameters.AddWithValue("@fechaCierre", reto.FechaCierre.ToString("yyyy-MM-dd"));
            cmd.Parameters.AddWithValue("@vidas", reto.Vidas);
            cmd.Parameters.AddWithValue("@tiempo", reto.Tiempo_ms);
            cmd.Parameters.AddWithValue("@puntosRecompensa", reto.PuntosRecompensa);
            cmd.Parameters.AddWithValue("@creditosObtenidos", reto.CreditosObtenidos);
            cmd.Parameters.AddWithValue("@instrucciones", WC.GetTrim(reto.Instrucciones));
            cmd.Parameters.AddWithValue("@imagen", WC.GetTrim(reto.Imagen));
            cmd.Parameters.AddWithValue("@idTipoReto", reto.IdTipoReto);
            cmd.Parameters.AddWithValue("@idComportamiento", reto.IdComportamiento);

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

        public async Task<Response> CreateUsuarioReto(Usuario_Reto usuarioReto)
        {
            Response response = new();

            SqlConnection sqlConnection = new(conexion.GetConnectionSqlServer());
            SqlCommand cmd = new("sp_C_Usuario_Reto", sqlConnection)
            {
                CommandType = CommandType.StoredProcedure
            };

            cmd.Parameters.AddWithValue("@idUsuario", usuarioReto.IdUsuario);
            cmd.Parameters.AddWithValue("@idReto", usuarioReto.IdReto);
            cmd.Parameters.AddWithValue("@puntos", usuarioReto.PuntosRecompensa);
            cmd.Parameters.AddWithValue("@tiempo", usuarioReto.Tiempo);
            cmd.Parameters.AddWithValue("@vidas", usuarioReto.Vidas);

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

        public async Task<Response> DeleteReto(Guid idReto)
        {
            Response response = new();

            SqlConnection sqlConnection = new(conexion.GetConnectionSqlServer());
            SqlCommand cmd = new("sp_D_Reto", sqlConnection)
            {
                CommandType = CommandType.StoredProcedure
            };

            cmd.Parameters.AddWithValue("@idReto", idReto);            

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
