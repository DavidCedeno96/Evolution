using System.Data.SqlClient;
using System.Data;
using WebApiRest.Models;
using WebApiRest.Utilities;

namespace WebApiRest.Data
{
    public class NoticiaData
    {
        private readonly Conexion conexion = new();

        public async Task<NoticiaList> GetNoticiaList(int estado)
        {
            NoticiaList list = new()
            {
                Lista = new()
            };

            SqlConnection sqlConnection = new(conexion.GetConnectionSqlServer());

            SqlCommand cmd = new("sp_B_Noticia", sqlConnection)
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
                    list.Lista.Add(new Noticia()
                    {
                        IdNoticia = new Guid(dr["idNoticia"].ToString()),
                        Titular = dr["titular"].ToString(),
                        Descripcion = dr["descripcion"].ToString(),
                        Url = dr["url"].ToString(),
                        Imagen = dr["imagen"].ToString(),                        
                        IdCategoria = new Guid(dr["idCategoria"].ToString()),
                        Categoria = dr["categoria"].ToString(),
                        FechaPublicacion = Convert.ToDateTime(dr["fechaPublicacion"].ToString()),
                        TotalLikes = Convert.ToInt32(dr["totalLikes"].ToString()),
                        TotalComents = Convert.ToInt32(dr["totalComents"].ToString()),
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

        public async Task<NoticiaList> GetNoticiaList(string buscar)
        {
            NoticiaList list = new()
            {
                Lista = new()
            };

            SqlConnection sqlConnection = new(conexion.GetConnectionSqlServer());

            SqlCommand cmd = new("sp_B_NoticiaByAll", sqlConnection)
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
                    list.Lista.Add(new Noticia()
                    {
                        IdNoticia = new Guid(dr["idNoticia"].ToString()),
                        Titular = dr["titular"].ToString(),
                        Descripcion = dr["descripcion"].ToString(),
                        Url = dr["url"].ToString(),
                        Imagen = dr["imagen"].ToString(),
                        IdCategoria = new Guid(dr["idCategoria"].ToString()),
                        Categoria = dr["categoria"].ToString(),
                        FechaPublicacion = Convert.ToDateTime(dr["fechaPublicacion"].ToString()),
                        TotalLikes = Convert.ToInt32(dr["totalLikes"].ToString()),
                        TotalComents = Convert.ToInt32(dr["totalComents"].ToString()),
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

        public async Task<NoticiaItem> GetNoticia(int estado, Guid idNoticia)
        {
            NoticiaItem item = new();

            SqlConnection sqlConnection = new(conexion.GetConnectionSqlServer());

            SqlCommand cmd = new("sp_B_NoticiaById", sqlConnection)
            {
                CommandType = CommandType.StoredProcedure
            };

            cmd.Parameters.AddWithValue("@idNoticia", idNoticia);
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
                    item.Noticia = new Noticia()
                    {
                        IdNoticia = new Guid(dr["idNoticia"].ToString()),
                        Titular = dr["titular"].ToString(),
                        Descripcion = dr["descripcion"].ToString(),
                        Url = dr["url"].ToString(),
                        Imagen = dr["imagen"].ToString(),
                        IdCategoria = new Guid(dr["idCategoria"].ToString()),
                        Categoria = dr["categoria"].ToString(),
                        FechaPublicacion = Convert.ToDateTime(dr["fechaPublicacion"].ToString()),
                        TotalLikes = Convert.ToInt32(dr["totalLikes"].ToString()),
                        TotalComents = Convert.ToInt32(dr["totalComents"].ToString()),
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
                item.Noticia = null;
            }
            finally
            {
                await sqlConnection.CloseAsync();
            }

            return item;
        }

        public async Task<Response> CreateNoticia(Noticia noticia)
        {
            Response response = new();

            SqlConnection sqlConnection = new(conexion.GetConnectionSqlServer());
            SqlCommand cmd = new("sp_C_Noticia", sqlConnection)
            {
                CommandType = CommandType.StoredProcedure
            };

            cmd.Parameters.AddWithValue("@titular", WC.GetTrim(noticia.Titular));
            cmd.Parameters.AddWithValue("@descripcion", WC.GetTrim(noticia.Descripcion));
            cmd.Parameters.AddWithValue("@url", WC.GetTrim(noticia.Url));
            cmd.Parameters.AddWithValue("@imagen", WC.GetTrim(noticia.Imagen));
            cmd.Parameters.AddWithValue("@idCategoria", noticia.IdCategoria);
            cmd.Parameters.AddWithValue("@fechaPublicacion", noticia.FechaPublicacion.ToString("yyyy-MM-dd"));

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

        public async Task<Response> UpdateNoticia(Noticia noticia)
        {
            Response response = new();

            SqlConnection sqlConnection = new(conexion.GetConnectionSqlServer());
            SqlCommand cmd = new("sp_U_Noticia", sqlConnection)
            {
                CommandType = CommandType.StoredProcedure
            };

            cmd.Parameters.AddWithValue("@idNoticia", noticia.IdNoticia);
            cmd.Parameters.AddWithValue("@titular", WC.GetTrim(noticia.Titular));
            cmd.Parameters.AddWithValue("@descripcion", WC.GetTrim(noticia.Descripcion));
            cmd.Parameters.AddWithValue("@url", WC.GetTrim(noticia.Url));
            cmd.Parameters.AddWithValue("@imagen", WC.GetTrim(noticia.Imagen));
            cmd.Parameters.AddWithValue("@idCategoria", noticia.IdCategoria);
            cmd.Parameters.AddWithValue("@fechaPublicacion", noticia.FechaPublicacion.ToString("yyyy-MM-dd"));

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

        public async Task<Response> DeleteNoticia(Guid idNoticia)
        {
            Response response = new();

            SqlConnection sqlConnection = new(conexion.GetConnectionSqlServer());
            SqlCommand cmd = new("sp_D_Noticia", sqlConnection)
            {
                CommandType = CommandType.StoredProcedure
            };

            cmd.Parameters.AddWithValue("@idNoticia", idNoticia);

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

        public async Task<Usuario_NoticiaList> GetUsuario_NoticiaList(Guid idNoticia)
        {
            Usuario_NoticiaList list = new()
            {
                Lista = new()
            };

            SqlConnection sqlConnection = new(conexion.GetConnectionSqlServer());

            SqlCommand cmd = new("sp_B_Usuario_NoticiaByIdNoticia", sqlConnection)
            {
                CommandType = CommandType.StoredProcedure
            };
            cmd.Parameters.AddWithValue("@idNoticia", idNoticia);

            cmd.Parameters.Add("@error", SqlDbType.Int).Direction = ParameterDirection.Output;
            cmd.Parameters.Add("@info", SqlDbType.VarChar, int.MaxValue).Direction = ParameterDirection.Output;
            cmd.Parameters.Add("@id", SqlDbType.VarChar, int.MaxValue).Direction = ParameterDirection.Output;

            try
            {
                await sqlConnection.OpenAsync();
                SqlDataReader dr = await cmd.ExecuteReaderAsync();
                while (await dr.ReadAsync())
                {
                    list.Lista.Add(new Usuario_Noticia()
                    {
                        IdNoticia = new Guid(dr["idNoticia"].ToString()),
                        IdUsuario = new Guid(dr["idUsuario"].ToString()),
                        Usuario = dr["usuario"].ToString(),
                        Likes = Convert.ToInt32(dr["likes"].ToString()),
                        Comentario = dr["comentario"].ToString(),
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

        public async Task<Response> CreateUsuario_Noticia(Usuario_Noticia noticia)
        {
            Response response = new();

            SqlConnection sqlConnection = new(conexion.GetConnectionSqlServer());
            SqlCommand cmd = new("sp_C_Usuario_Noticia", sqlConnection)
            {
                CommandType = CommandType.StoredProcedure
            };

            cmd.Parameters.AddWithValue("@idUsuario", noticia.IdUsuario);
            cmd.Parameters.AddWithValue("@idNoticia", noticia.IdNoticia);            
            cmd.Parameters.AddWithValue("@likes", noticia.Likes);
            cmd.Parameters.AddWithValue("@comentario", WC.GetTrim(noticia.Comentario));

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
