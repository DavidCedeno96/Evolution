using System.Data.SqlClient;
using System.Data;
using WebApiRest.Models;
using WebApiRest.Utilities;

namespace WebApiRest.Data
{
    public class CategoriaRecompensaData
    {
        private readonly Conexion conexion = new();

        public async Task<CategoriaList> GetCategoriaRecompensaList(int estado)
        {
            CategoriaList list = new()
            {
                Lista = new()
            };

            SqlConnection sqlConnection = new(conexion.GetConnectionSqlServer());

            SqlCommand cmd = new("sp_B_CategoriaRecompensa", sqlConnection)
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
                    list.Lista.Add(new Categoria()
                    {
                        IdCategoria = new Guid(dr["idCategoria"].ToString()),
                        Nombre = dr["nombre"].ToString(),
                        Descripcion = dr["descripcion"].ToString(),
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

        public async Task<CategoriaList> GetCategoriaRecompensaList(string buscar)
        {
            CategoriaList list = new()
            {
                Lista = new()
            };

            SqlConnection sqlConnection = new(conexion.GetConnectionSqlServer());

            SqlCommand cmd = new("sp_B_CategoriaRecompensaByAll", sqlConnection)
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
                    list.Lista.Add(new Categoria()
                    {
                        IdCategoria = new Guid(dr["idCategoria"].ToString()),
                        Nombre = dr["nombre"].ToString(),
                        Descripcion = dr["descripcion"].ToString(),
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

        public async Task<CategoriaItem> GetCategoriaRecompensa(int estado, Guid idCategoria)
        {
            CategoriaItem item = new();

            SqlConnection sqlConnection = new(conexion.GetConnectionSqlServer());

            SqlCommand cmd = new("sp_B_CategoriaRecompensaById", sqlConnection)
            {
                CommandType = CommandType.StoredProcedure
            };

            cmd.Parameters.AddWithValue("@idCategoria", idCategoria);
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
                    item.CategoriaNoticia = new Categoria()
                    {
                        IdCategoria = new Guid(dr["idCategoria"].ToString()),
                        Nombre = dr["nombre"].ToString(),
                        Descripcion = dr["descripcion"].ToString(),
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
                item.CategoriaNoticia = null;
            }
            finally
            {
                await sqlConnection.CloseAsync();
            }

            return item;
        }

        public async Task<Response> CreateCategoriaRecompensa(Categoria categoriaRecopmensa)
        {
            Response response = new();

            SqlConnection sqlConnection = new(conexion.GetConnectionSqlServer());
            SqlCommand cmd = new("sp_C_CategoriaRecompensa", sqlConnection)
            {
                CommandType = CommandType.StoredProcedure
            };

            cmd.Parameters.AddWithValue("@nombre", WC.GetTrim(categoriaRecopmensa.Nombre));
            cmd.Parameters.AddWithValue("@descripcion", WC.GetTrim(categoriaRecopmensa.Descripcion));

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

        public async Task<Response> UpdateCategoriaRecompensa(Categoria categoriaRecompensa)
        {
            Response response = new();

            SqlConnection sqlConnection = new(conexion.GetConnectionSqlServer());
            SqlCommand cmd = new("sp_U_CategoriaRecompensa", sqlConnection)
            {
                CommandType = CommandType.StoredProcedure
            };

            cmd.Parameters.AddWithValue("@idCategoria", categoriaRecompensa.IdCategoria);
            cmd.Parameters.AddWithValue("@nombre", WC.GetTrim(categoriaRecompensa.Nombre));
            cmd.Parameters.AddWithValue("@descripcion", WC.GetTrim(categoriaRecompensa.Descripcion));

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
