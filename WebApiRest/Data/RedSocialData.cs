using System.Data.SqlClient;
using System.Data;
using WebApiRest.Models;
using WebApiRest.Utilities;

namespace WebApiRest.Data
{
    public class RedSocialData
    {
        private readonly Conexion conexion = new();

        public async Task<RedSocialList> GetRedSocialList(int estado)
        {
            RedSocialList list = new()
            {
                Lista = new()
            };

            SqlConnection sqlConnection = new(conexion.GetConnectionSqlServer());

            SqlCommand cmd = new("sp_B_RedSocial", sqlConnection)
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
                    list.Lista.Add(new RedSocial()
                    {
                        IdRed = new Guid(dr["idRed"].ToString()),                                                
                        Descripcion = dr["descripcion"].ToString(),
                        Imagen = dr["imagen"].ToString(),
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

        public async Task<RedSocialList_comentarios> GetRedSocialList_comentarios(int estado)
        {

            RedSocialList_comentarios list = new()
            {
                Lista = new()
            };

            SqlConnection sqlConnection = new(conexion.GetConnectionSqlServer());

            SqlCommand cmd = new("sp_B_RedSocial", sqlConnection)
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
                    Usuario_RedSocialList comentarioList = await GetUsuario_RedSocialList(new Guid(dr["idRed"].ToString()));

                    list.Lista.Add(new RedSocial_ComentarioList()
                    {
                        RedSocial = new RedSocial()
                        {
                            IdRed = new Guid(dr["idRed"].ToString()),                            
                            Descripcion = dr["descripcion"].ToString(),                            
                            Imagen = dr["imagen"].ToString(),                            
                            FechaPublicacion = Convert.ToDateTime(dr["fechaPublicacion"].ToString()),
                            TotalLikes = Convert.ToInt32(dr["totalLikes"].ToString()),
                            TotalComents = Convert.ToInt32(dr["totalComents"].ToString()),
                            Estado = Convert.ToInt32(dr["estado"].ToString()),
                            FechaCreacion = Convert.ToDateTime(dr["fechaCreacion"].ToString()),
                            FechaModificacion = Convert.ToDateTime(dr["fechaModificacion"].ToString())
                        },
                        ComentarioList = comentarioList.Lista
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

        public async Task<Usuario_RedSocialList> GetUsuario_RedSocialList(Guid idRedSocial)
        {
            Usuario_RedSocialList list = new()
            {
                Lista = new()
            };

            SqlConnection sqlConnection = new(conexion.GetConnectionSqlServer());

            SqlCommand cmd = new("sp_B_Usuario_RedSocialByIdRed", sqlConnection)
            {
                CommandType = CommandType.StoredProcedure
            };
            cmd.Parameters.AddWithValue("@idRed", idRedSocial);

            cmd.Parameters.Add("@error", SqlDbType.Int).Direction = ParameterDirection.Output;
            cmd.Parameters.Add("@info", SqlDbType.VarChar, int.MaxValue).Direction = ParameterDirection.Output;
            cmd.Parameters.Add("@id", SqlDbType.VarChar, int.MaxValue).Direction = ParameterDirection.Output;

            try
            {
                await sqlConnection.OpenAsync();
                SqlDataReader dr = await cmd.ExecuteReaderAsync();
                while (await dr.ReadAsync())
                {
                    list.Lista.Add(new Usuario_RedSocial()
                    {
                        IdRed = new Guid(dr["idRed"].ToString()),
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

        public async Task<Response> CreateRedSocial(RedSocial redSocial)
        {
            Response response = new();

            SqlConnection sqlConnection = new(conexion.GetConnectionSqlServer());
            SqlCommand cmd = new("sp_C_RedSocial", sqlConnection)
            {
                CommandType = CommandType.StoredProcedure
            };
            
            cmd.Parameters.AddWithValue("@descripcion", WC.GetTrim(redSocial.Descripcion));
            cmd.Parameters.AddWithValue("@imagen", WC.GetTrim(redSocial.Imagen));
            cmd.Parameters.AddWithValue("@fechaPublicacion", redSocial.FechaPublicacion.ToString("yyyy-MM-dd"));            

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

        public async Task<Response> CreateUsuario_RedSocial(Usuario_RedSocial usuario_redSocial)
        {
            Response response = new();

            SqlConnection sqlConnection = new(conexion.GetConnectionSqlServer());
            SqlCommand cmd = new("sp_C_Usuario_RedSocial", sqlConnection)
            {
                CommandType = CommandType.StoredProcedure
            };

            cmd.Parameters.AddWithValue("@idUsuario", usuario_redSocial.IdUsuario);
            cmd.Parameters.AddWithValue("@idRed", usuario_redSocial.IdRed);
            cmd.Parameters.AddWithValue("@likes", usuario_redSocial.Likes);
            cmd.Parameters.AddWithValue("@comentario", WC.GetTrim(usuario_redSocial.Comentario));

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
