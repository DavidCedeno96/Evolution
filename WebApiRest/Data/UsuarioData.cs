﻿using System.Data.SqlClient;
using System.Data;
using WebApiRest.Models;
using WebApiRest.Utilities;
using System.Text;

namespace WebApiRest.Data
{
    public class UsuarioData
    {
        private readonly Conexion conexion = new();

        public async Task<UsuarioList> GetUsuarioList(int estado)
        {
            UsuarioList list = new()
            {
                Lista = new()
            };

            SqlConnection sqlConnection = new(conexion.GetConnectionSqlServer());

            SqlCommand cmd = new("sp_B_Usuario", sqlConnection)
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
                    list.Lista.Add(new Usuario()
                    {
                        IdUsuario = new Guid(dr["idUsuario"].ToString()),
                        Nombre = dr["nombre"].ToString(),
                        Apellido = dr["apellido"].ToString(),
                        Correo = dr["correo"].ToString(),
                        Id = dr["id"].ToString(),
                        Celular = dr["celular"].ToString(),
                        Foto = dr["foto"].ToString(),
                        IdRol = dr["idRol"].ToString(),
                        Rol = dr["rol"].ToString(),
                        IdPais = dr["idPais"].ToString(),
                        Pais = dr["pais"].ToString(),
                        IdCiudad = dr["idCiudad"].ToString(),
                        Ciudad = dr["ciudad"].ToString(),
                        IdArea = dr["idArea"].ToString(),
                        Area = dr["area"].ToString(),
                        IdEmpresa = dr["idEmpresa"].ToString(),
                        Empresa = dr["empresa"].ToString(),
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

        public async Task<UsuarioList> GetUsuarioList(string buscar)
        {
            UsuarioList list = new()
            {
                Lista = new()
            };

            SqlConnection sqlConnection = new(conexion.GetConnectionSqlServer());

            SqlCommand cmd = new("sp_B_UsuarioByAll", sqlConnection)
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
                    list.Lista.Add(new Usuario()
                    {
                        IdUsuario = new Guid(dr["idUsuario"].ToString()),
                        Nombre = dr["nombre"].ToString(),
                        Apellido = dr["apellido"].ToString(),
                        Correo = dr["correo"].ToString(),
                        Id = dr["id"].ToString(),
                        Celular = dr["celular"].ToString(),
                        Foto = dr["foto"].ToString(),
                        IdRol = dr["idRol"].ToString(),
                        Rol = dr["rol"].ToString(),
                        IdPais = dr["idPais"].ToString(),
                        Pais = dr["pais"].ToString(),
                        IdCiudad = dr["idCiudad"].ToString(),
                        Ciudad = dr["ciudad"].ToString(),
                        IdArea = dr["idArea"].ToString(),
                        Area = dr["area"].ToString(),
                        IdEmpresa = dr["idEmpresa"].ToString(),
                        Empresa = dr["empresa"].ToString(),
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

        public async Task<UsuarioList> GetUsuarioList(Guid idUsuario)
        {
            UsuarioList list = new()
            {
                Lista = new()
            };

            SqlConnection sqlConnection = new(conexion.GetConnectionSqlServer());

            SqlCommand cmd = new("sp_B_Usuario_fechaLogin", sqlConnection)
            {
                CommandType = CommandType.StoredProcedure
            };

            cmd.Parameters.AddWithValue("@idUsuario", idUsuario);

            cmd.Parameters.Add("@error", SqlDbType.Int).Direction = ParameterDirection.Output;
            cmd.Parameters.Add("@info", SqlDbType.VarChar, int.MaxValue).Direction = ParameterDirection.Output;
            cmd.Parameters.Add("@id", SqlDbType.VarChar, int.MaxValue).Direction = ParameterDirection.Output;

            try
            {
                await sqlConnection.OpenAsync();
                SqlDataReader dr = await cmd.ExecuteReaderAsync();
                while (await dr.ReadAsync())
                {
                    list.Lista.Add(new Usuario()
                    {
                        IdUsuario = new Guid(dr["idUsuario"].ToString()),
                        Nombre = dr["nombre"].ToString(),
                        Apellido = dr["apellido"].ToString(),
                        Correo = dr["correo"].ToString(),
                        Id = dr["id"].ToString(),
                        Celular = dr["celular"].ToString(),
                        Foto = dr["foto"].ToString(),
                        IdRol = dr["idRol"].ToString(),
                        Rol = dr["rol"].ToString(),
                        IdPais = dr["idPais"].ToString(),
                        Pais = dr["pais"].ToString(),
                        IdCiudad = dr["idCiudad"].ToString(),
                        Ciudad = dr["ciudad"].ToString(),
                        IdArea = dr["idArea"].ToString(),
                        Area = dr["area"].ToString(),
                        IdEmpresa = dr["idEmpresa"].ToString(),
                        Empresa = dr["empresa"].ToString(),
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

        public async Task<UsuarioItem> GetUsuario(string correo)
        {
            UsuarioItem item = new();

            SqlConnection sqlConnection = new(conexion.GetConnectionSqlServer());

            SqlCommand cmd = new("sp_B_UsuarioByCorreo", sqlConnection)
            {
                CommandType = CommandType.StoredProcedure
            };
            cmd.Parameters.AddWithValue("@correo", correo);

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

                    item.Usuario = new Usuario()
                    {
                        IdUsuario = new Guid(dr["IdUsuario"].ToString()),
                        Nombre = dr["nombre"].ToString(),
                        Apellido = dr["apellido"].ToString(),
                        Correo = dr["correo"].ToString(),
                        Id = dr["id"].ToString(),
                        Contrasena = decryptedText,
                        Celular = dr["celular"].ToString(),
                        Foto = dr["foto"].ToString(),
                        IdRol = dr["idRol"].ToString(),
                        Rol = dr["rol"].ToString(),                        
                        Ciudad = dr["ciudad"].ToString(),                        
                        IdArea = dr["idArea"].ToString(),
                        Area = dr["area"].ToString(),
                        Puntos = Convert.ToInt32(dr["puntos"].ToString()),
                        Creditos = Convert.ToInt32(dr["creditos"].ToString()),
                        Estado = Convert.ToInt32(dr["estado"].ToString()),
                        FechaCreacion = Convert.ToDateTime(dr["fechaCreacion"].ToString()),
                        FechaModificacion = Convert.ToDateTime(dr["fechaModificacion"].ToString()),
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
                item.Usuario = null;
            }
            finally
            {
                await sqlConnection.CloseAsync();
            }

            return item;
        }

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
                        IdUsuario = new Guid(dr["idUsuario"].ToString()),
                        Nombre = dr["nombre"].ToString(),
                        Apellido = dr["apellido"].ToString(),
                        Correo = dr["correo"].ToString(),
                        Id = dr["id"].ToString(),
                        Celular = dr["celular"].ToString(),
                        Foto = dr["foto"].ToString(),
                        IdRol = dr["idRol"].ToString(),
                        Rol = dr["rol"].ToString(),
                        IdPais = dr["idPais"].ToString(),
                        Pais = dr["pais"].ToString(),
                        IdCiudad = dr["idCiudad"].ToString(),
                        Ciudad = dr["ciudad"].ToString(),
                        IdArea = dr["idArea"].ToString(),
                        Area = dr["area"].ToString(),
                        IdEmpresa = dr["idEmpresa"].ToString(),
                        Empresa = dr["empresa"].ToString(),
                        Estado = Convert.ToInt32(dr["estado"].ToString()),
                        Puntos = Convert.ToInt32(dr["puntos"].ToString()),
                        Creditos = Convert.ToInt32(dr["creditos"].ToString()),
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
                item.Usuario = null;
            }
            finally
            {
                await sqlConnection.CloseAsync();
            }

            return item;
        }

        public async Task<Response> GetUsuario(Usuario usuario, string codigoRegistro)
        {
            Response response = new();

            SqlConnection sqlConnection = new(conexion.GetConnectionSqlServer());
            SqlCommand cmd = new("sp_B_UsuarioByRegister", sqlConnection)
            {
                CommandType = CommandType.StoredProcedure
            };

            
            cmd.Parameters.AddWithValue("@idU", WC.GetTrim(usuario.Id));
            cmd.Parameters.AddWithValue("@correo", WC.GetTrim(usuario.Correo));
            cmd.Parameters.AddWithValue("@codRegistro", codigoRegistro);            

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

        public async Task<Response> CreateUsuario(Usuario usuario)
        {
            Response response = new();

            SqlConnection sqlConnection = new(conexion.GetConnectionSqlServer());
            SqlCommand cmd = new("sp_C_Usuario", sqlConnection)
            {
                CommandType = CommandType.StoredProcedure
            };

            cmd.Parameters.AddWithValue("@nombre", WC.GetTrim(usuario.Nombre));
            cmd.Parameters.AddWithValue("@apellido", WC.GetTrim(usuario.Apellido));
            cmd.Parameters.AddWithValue("@correo", WC.GetTrim(usuario.Correo));
            cmd.Parameters.AddWithValue("@idU", WC.GetTrim(usuario.Id));
            cmd.Parameters.AddWithValue("@celular", WC.GetTrim(usuario.Celular));
            cmd.Parameters.AddWithValue("@foto", WC.GetTrim(usuario.Foto));
            cmd.Parameters.AddWithValue("@idRol", WC.GetTrim(usuario.IdRol));
            cmd.Parameters.AddWithValue("@idCiudad", WC.GetTrim(usuario.IdCiudad));
            cmd.Parameters.AddWithValue("@idArea", WC.GetTrim(usuario.IdArea));
            cmd.Parameters.AddWithValue("@clave", WC.GetBytes(await Hasher.Encrypt(WC.GetTrim(usuario.Contrasena))));

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

        public async Task<Response> UpdateUsuario(Usuario usuario)
        {
            Response response = new();

            SqlConnection sqlConnection = new(conexion.GetConnectionSqlServer());
            SqlCommand cmd = new("sp_U_Usuario", sqlConnection)
            {
                CommandType = CommandType.StoredProcedure
            };            

            cmd.Parameters.AddWithValue("@idUsuario", usuario.IdUsuario);
            cmd.Parameters.AddWithValue("@nombre", WC.GetTrim(usuario.Nombre));
            cmd.Parameters.AddWithValue("@apellido", WC.GetTrim(usuario.Apellido));
            cmd.Parameters.AddWithValue("@correo", WC.GetTrim(usuario.Correo));
            cmd.Parameters.AddWithValue("@idU", WC.GetTrim(usuario.Id));
            cmd.Parameters.AddWithValue("@celular", WC.GetTrim(usuario.Celular));
            cmd.Parameters.AddWithValue("@foto", WC.GetTrim(usuario.Foto));
            cmd.Parameters.AddWithValue("@idRol", WC.GetTrim(usuario.IdRol));
            cmd.Parameters.AddWithValue("@idCiudad", WC.GetTrim(usuario.IdCiudad));
            cmd.Parameters.AddWithValue("@idArea", WC.GetTrim(usuario.IdArea));
            if (WC.GetTrim(usuario.Contrasena).Equals(""))
            {
                cmd.Parameters.AddWithValue("@clave", Array.Empty<byte>());
            }
            else
            {
                cmd.Parameters.AddWithValue("@clave", WC.GetBytes(await Hasher.Encrypt(WC.GetTrim(usuario.Contrasena))));
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

        public async Task<Response> UpdateUsuarioByFoto(Usuario usuario)
        {
            Response response = new();

            SqlConnection sqlConnection = new(conexion.GetConnectionSqlServer());
            SqlCommand cmd = new("sp_U_UsuarioByFoto", sqlConnection)
            {
                CommandType = CommandType.StoredProcedure
            };

            cmd.Parameters.AddWithValue("@idUsuario", usuario.IdUsuario);            
            cmd.Parameters.AddWithValue("@foto", WC.GetTrim(usuario.Foto));            

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

        public async Task<Response> UpdateUsuarioByEstado(Usuario usuario)
        {
            Response response = new();

            SqlConnection sqlConnection = new(conexion.GetConnectionSqlServer());
            SqlCommand cmd = new("sp_U_UsuarioByEstado", sqlConnection)
            {
                CommandType = CommandType.StoredProcedure
            };

            cmd.Parameters.AddWithValue("@idUsuario", usuario.IdUsuario);
            cmd.Parameters.AddWithValue("@estado", usuario.Estado);            

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

        public async Task<Response> UpdateUsuarioByEstado(int estado, string correo_id)
        {
            Response response = new();

            SqlConnection sqlConnection = new(conexion.GetConnectionSqlServer());
            SqlCommand cmd = new("sp_U_UsuarioEstadoByCorreoIds", sqlConnection)
            {
                CommandType = CommandType.StoredProcedure
            };

            cmd.Parameters.AddWithValue("@correo_id", correo_id);
            cmd.Parameters.AddWithValue("@estado", estado);

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
                response.Id = null;
            }
            finally
            {
                await sqlConnection.CloseAsync();
            }

            return response;

        }
    }
}
