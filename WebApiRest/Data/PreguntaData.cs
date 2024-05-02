using System.Data.SqlClient;
using System.Data;
using WebApiRest.Models;
using WebApiRest.Utilities;
using Microsoft.Extensions.Options;
using NPOI.POIFS.Crypt.Dsig;

namespace WebApiRest.Data
{
    public class PreguntaData
    {
        private readonly Conexion conexion = new();
        private readonly OpcionData opcionData = new();
        private readonly RetoData retoData = new();

        public async Task<PreguntaList> GetPreguntaList(int estado, Guid idReto)
        {
            PreguntaList list = new()
            {
                Lista = new()
            };

            SqlConnection sqlConnection = new(conexion.GetConnectionSqlServer());

            SqlCommand cmd = new("sp_B_PreguntaByIdReto", sqlConnection)
            {
                CommandType = CommandType.StoredProcedure
            };

            cmd.Parameters.AddWithValue("@estado", estado);
            cmd.Parameters.AddWithValue("@idReto", idReto);

            cmd.Parameters.Add("@error", SqlDbType.Int).Direction = ParameterDirection.Output;
            cmd.Parameters.Add("@info", SqlDbType.VarChar, int.MaxValue).Direction = ParameterDirection.Output;
            cmd.Parameters.Add("@id", SqlDbType.VarChar, int.MaxValue).Direction = ParameterDirection.Output;

            try
            {
                await sqlConnection.OpenAsync();
                SqlDataReader dr = await cmd.ExecuteReaderAsync();
                while (await dr.ReadAsync())
                {
                    list.Lista.Add(new Pregunta()
                    {
                        IdPregunta = new Guid(dr["idPregunta"].ToString()),                        
                        Nombre = dr["nombre"].ToString(),
                        IdReto = new Guid(dr["idReto"].ToString()),
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

        public async Task<PreguntaList_opciones> GetPreguntaList_opciones(int estado, Guid idReto)
        {

            PreguntaList_opciones list = new() 
            { 
                List = new() 
            };

            SqlConnection sqlConnection = new(conexion.GetConnectionSqlServer());

            SqlCommand cmd = new("sp_B_PreguntaByIdReto", sqlConnection)
            {
                CommandType = CommandType.StoredProcedure
            };

            cmd.Parameters.AddWithValue("@estado", estado);
            cmd.Parameters.AddWithValue("@idReto", idReto);

            cmd.Parameters.Add("@error", SqlDbType.Int).Direction = ParameterDirection.Output;
            cmd.Parameters.Add("@info", SqlDbType.VarChar, int.MaxValue).Direction = ParameterDirection.Output;
            cmd.Parameters.Add("@id", SqlDbType.VarChar, int.MaxValue).Direction = ParameterDirection.Output;

            try
            {
                await sqlConnection.OpenAsync();
                SqlDataReader dr = await cmd.ExecuteReaderAsync();
                while (await dr.ReadAsync())
                {
                    OpcionList opcionList = await opcionData.GetOpcionList(estado, new Guid(dr["idPregunta"].ToString()));
                    RetoItem retoItem = await retoData.GetReto(estado, idReto);

                    list.List.Add(new Pregunta_OpcionList()
                    {
                        Reto = retoItem.Reto,
                        Pregunta = new Pregunta()
                        {
                            IdPregunta = new Guid(dr["idPregunta"].ToString()),
                            Nombre = dr["nombre"].ToString(),
                            IdReto = new Guid(dr["idReto"].ToString()),
                            Estado = Convert.ToInt32(dr["estado"].ToString()),
                            FechaCreacion = Convert.ToDateTime(dr["fechaCreacion"].ToString()),
                            FechaModificacion = Convert.ToDateTime(dr["fechaModificacion"].ToString())
                        },
                        OpcionList = opcionList.Lista
                    });
                }

                list.Info = WC.GetSatisfactorio();
                list.Error = 0;
            }
            catch (Exception ex)
            {
                list.Info = conexion.GetSettings().Production ? WC.GetError() : ex.Message;
                list.Error = 1;
                list.List = null;
            }
            finally
            {
                await sqlConnection.CloseAsync();
            }

            return list;

        }

        public async Task<PreguntaList_opciones> GetPreguntaList_opciones(string buscar, Guid idReto)
        {

            PreguntaList_opciones list = new()
            {
                List = new()
            };

            SqlConnection sqlConnection = new(conexion.GetConnectionSqlServer());

            SqlCommand cmd = new("sp_B_PreguntaByAll", sqlConnection)
            {
                CommandType = CommandType.StoredProcedure
            };

            cmd.Parameters.AddWithValue("@buscar", WC.GetTrim(buscar));
            cmd.Parameters.AddWithValue("@idReto", idReto);

            cmd.Parameters.Add("@error", SqlDbType.Int).Direction = ParameterDirection.Output;
            cmd.Parameters.Add("@info", SqlDbType.VarChar, int.MaxValue).Direction = ParameterDirection.Output;
            cmd.Parameters.Add("@id", SqlDbType.VarChar, int.MaxValue).Direction = ParameterDirection.Output;

            try
            {
                await sqlConnection.OpenAsync();
                SqlDataReader dr = await cmd.ExecuteReaderAsync();
                while (await dr.ReadAsync())
                {
                    OpcionList opcionList = await opcionData.GetOpcionList(-1, new Guid(dr["idPregunta"].ToString()));

                    list.List.Add(new Pregunta_OpcionList()
                    {
                        Pregunta = new Pregunta()
                        {
                            IdPregunta = new Guid(dr["idPregunta"].ToString()),
                            Nombre = dr["nombre"].ToString(),
                            IdReto = new Guid(dr["idReto"].ToString()),
                            Estado = Convert.ToInt32(dr["estado"].ToString()),
                            FechaCreacion = Convert.ToDateTime(dr["fechaCreacion"].ToString()),
                            FechaModificacion = Convert.ToDateTime(dr["fechaModificacion"].ToString())
                        },
                        OpcionList = opcionList.Lista
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
                list.List = null;
            }
            finally
            {
                await sqlConnection.CloseAsync();
            }

            return list;

        }

        public async Task<Pregunta_OpcionList> GetPregunta_OpcionList(int estado, Guid idPregunta)
        {
            Pregunta_OpcionList item = new();

            SqlConnection sqlConnection = new(conexion.GetConnectionSqlServer());

            SqlCommand cmd = new("sp_B_PreguntaById", sqlConnection)
            {
                CommandType = CommandType.StoredProcedure
            };

            cmd.Parameters.AddWithValue("@idPregunta", idPregunta);
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
                    item.Pregunta = new Pregunta()
                    {
                        IdPregunta = new Guid(dr["idPregunta"].ToString()),
                        Nombre = dr["nombre"].ToString(),
                        IdReto = new Guid(dr["idReto"].ToString()),
                        Estado = Convert.ToInt32(dr["estado"].ToString()),
                        FechaCreacion = Convert.ToDateTime(dr["fechaCreacion"].ToString()),
                        FechaModificacion = Convert.ToDateTime(dr["fechaModificacion"].ToString())
                    };
                    OpcionList opcionList = await opcionData.GetOpcionList(estado, idPregunta);
                    item.OpcionList = opcionList.Lista;
                }
                await dr.NextResultAsync();

                item.Info = cmd.Parameters["@info"].Value.ToString();
                item.Error = Convert.ToInt32(cmd.Parameters["@error"].Value.ToString());
            }
            catch (Exception ex)
            {
                item.Info = conexion.GetSettings().Production ? WC.GetError() : ex.Message;
                item.Error = 1;
                item.Pregunta = null;
                item.OpcionList = null;
            }
            finally
            {
                await sqlConnection.CloseAsync();
            }

            return item;
        }

        public async Task<Response> CreatePregunta(Pregunta pregunta)
        {
            Response response = new();

            SqlConnection sqlConnection = new(conexion.GetConnectionSqlServer());
            SqlCommand cmd = new("sp_C_Pregunta", sqlConnection)
            {
                CommandType = CommandType.StoredProcedure
            };

            cmd.Parameters.AddWithValue("@nombre", WC.GetTrim(pregunta.Nombre));
            cmd.Parameters.AddWithValue("@idReto", pregunta.IdReto);            

            cmd.Parameters.Add("@error", SqlDbType.Int).Direction = ParameterDirection.Output;
            cmd.Parameters.Add("@info", SqlDbType.VarChar, int.MaxValue).Direction = ParameterDirection.Output;
            cmd.Parameters.Add("@id", SqlDbType.VarChar, int.MaxValue).Direction = ParameterDirection.Output;

            try
            {
                await sqlConnection.OpenAsync();
                await cmd.ExecuteNonQueryAsync();

                response.Info = cmd.Parameters["@info"].Value.ToString();
                response.Error = Convert.ToInt32(cmd.Parameters["@error"].Value.ToString());                
                response.Id = cmd.Parameters["@id"].Value.ToString();
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

        public async Task<Response> UpdatePregunta(Pregunta pregunta)
        {
            Response response = new();

            SqlConnection sqlConnection = new(conexion.GetConnectionSqlServer());
            SqlCommand cmd = new("sp_U_Pregunta", sqlConnection)
            {
                CommandType = CommandType.StoredProcedure
            };

            cmd.Parameters.AddWithValue("@idPregunta", pregunta.IdPregunta);
            cmd.Parameters.AddWithValue("@nombre", WC.GetTrim(pregunta.Nombre));
            cmd.Parameters.AddWithValue("@idReto", pregunta.IdReto);

            cmd.Parameters.Add("@error", SqlDbType.Int).Direction = ParameterDirection.Output;
            cmd.Parameters.Add("@info", SqlDbType.VarChar, int.MaxValue).Direction = ParameterDirection.Output;
            cmd.Parameters.Add("@id", SqlDbType.VarChar, int.MaxValue).Direction = ParameterDirection.Output;

            try
            {
                await sqlConnection.OpenAsync();
                await cmd.ExecuteNonQueryAsync();

                response.Info = cmd.Parameters["@info"].Value.ToString();
                response.Error = Convert.ToInt32(cmd.Parameters["@error"].Value.ToString());
                response.Id = cmd.Parameters["@id"].Value.ToString();
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

        public async Task<Response> DeletePregunta(Guid IdPregunta)
        {
            Response response = new();

            SqlConnection sqlConnection = new(conexion.GetConnectionSqlServer());
            SqlCommand cmd = new("sp_D_Pregunta", sqlConnection)
            {
                CommandType = CommandType.StoredProcedure
            };

            cmd.Parameters.AddWithValue("@idPregunta", IdPregunta);
            
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
