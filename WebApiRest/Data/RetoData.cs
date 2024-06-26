﻿using System.Data.SqlClient;
using System.Data;
using WebApiRest.Models;
using WebApiRest.Utilities;
using NPOI.POIFS.Crypt.Dsig;
using MathNet.Numerics.Distributions;

namespace WebApiRest.Data
{
    public class RetoData
    {
        private readonly Conexion conexion = new();

        public async Task<RetoList> GetRetoList(int estado, Guid idUsuario)
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
                        TipoReto = dr["tipoReto"].ToString(),
                        IdTipoEncuesta = new Guid(dr["idTipoEncuesta"].ToString()),
                        TipoEncuesta = dr["tipoEncuesta"].ToString(),
                        IdComportamiento = new Guid(dr["idComportamiento"].ToString()),
                        ComportamientoPregunta = dr["comportamientoPregunta"].ToString(),
                        IdTipoValidador = new Guid(dr["idTipoValidador"].ToString()),
                        TipoValidador = dr["tipoValidador"].ToString(),
                        IdTipoArchivo = new Guid(dr["idTipoArchivo"].ToString()),
                        TipoArchivo = dr["tipoArchivo"].ToString(),
                        OpsRequeridas = Convert.ToInt32(dr["opsRequeridas"].ToString()),
                        CriterioMinimo = Convert.ToInt32(dr["criterioMinimo"].ToString()),
                        Estado = Convert.ToInt32(dr["estado"].ToString()),
                        TotalPreguntas = Convert.ToInt32(dr["totalPreguntas"].ToString()),
                        UsuariosAsignados = Convert.ToInt32(dr["usuariosAsignados"].ToString()),
                        EquiposAsignados = Convert.ToInt32(dr["equiposAsignados"].ToString()),
                        Validadores = Convert.ToInt32(dr["validadores"].ToString()),
                        PuedeValidar = Convert.ToInt32(dr["puedeValidar"].ToString()),
                        EnEquipo = Convert.ToInt32(dr["enEquipo"].ToString()),
                        Items = Convert.ToInt32(dr["items"].ToString()),                        
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

        public async Task<RetoList> GetRetoList(string buscar, Guid idUsuario)
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
                        TipoReto = dr["tipoReto"].ToString(),
                        IdTipoEncuesta = new Guid(dr["idTipoEncuesta"].ToString()),
                        TipoEncuesta = dr["tipoEncuesta"].ToString(),
                        IdComportamiento = new Guid(dr["idComportamiento"].ToString()),
                        ComportamientoPregunta = dr["comportamientoPregunta"].ToString(),
                        IdTipoValidador = new Guid(dr["idTipoValidador"].ToString()),
                        TipoValidador = dr["tipoValidador"].ToString(),
                        IdTipoArchivo = new Guid(dr["idTipoArchivo"].ToString()),
                        TipoArchivo = dr["tipoArchivo"].ToString(),
                        OpsRequeridas = Convert.ToInt32(dr["opsRequeridas"].ToString()),
                        CriterioMinimo = Convert.ToInt32(dr["criterioMinimo"].ToString()),
                        Estado = Convert.ToInt32(dr["estado"].ToString()),
                        TotalPreguntas = Convert.ToInt32(dr["totalPreguntas"].ToString()),
                        UsuariosAsignados = Convert.ToInt32(dr["usuariosAsignados"].ToString()),
                        EquiposAsignados = Convert.ToInt32(dr["equiposAsignados"].ToString()),
                        Validadores = Convert.ToInt32(dr["validadores"].ToString()),
                        PuedeValidar = Convert.ToInt32(dr["puedeValidar"].ToString()),
                        EnEquipo = Convert.ToInt32(dr["enEquipo"].ToString()),
                        Items = Convert.ToInt32(dr["items"].ToString()),                        
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

        public async Task<Usuario_RetoList> GetUsuarioRetoList(int top, Guid idUsuario, int completado)
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
            cmd.Parameters.AddWithValue("@completado", completado);

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
                        Reto = new Reto()
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
                            TipoReto = dr["tipoReto"].ToString(),
                            IdComportamiento = new Guid(dr["idComportamiento"].ToString()),
                            ComportamientoPregunta = dr["comportamientoPregunta"].ToString(),
                            IdTipoValidador = new Guid(dr["idTipoValidador"].ToString()),
                            TipoValidador = dr["tipoValidador"].ToString(),
                            CriterioMinimo = Convert.ToInt32(dr["criterioMinimo"].ToString()),
                            Estado = Convert.ToInt32(dr["estado"].ToString()),
                            TotalPreguntas = Convert.ToInt32(dr["totalPreguntas"].ToString()),                            
                            EnEquipo = Convert.ToInt32(dr["enEquipo"].ToString()),
                            Items = Convert.ToInt32(dr["items"].ToString()),                            
                        },
                        Usuario = new Usuario()
                        {                            
                            IdUsuario = new Guid(dr["idUsuario"].ToString()),
                        },              
                        Completado = Convert.ToInt32(dr["completado"].ToString()),
                        Puntos = Convert.ToInt32(dr["puntos"].ToString()),                        
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

        public async Task<Usuario_RetoItem> GetUsuarioRetoList(Guid idReto, Guid idUsuario, int completado)
        {
            Usuario_RetoItem item = new();            

            SqlConnection sqlConnection = new(conexion.GetConnectionSqlServer());

            SqlCommand cmd = new("sp_B_Usuario_RetoByIdUsuarioYIdReto", sqlConnection)
            {
                CommandType = CommandType.StoredProcedure
            };

            cmd.Parameters.AddWithValue("@idUsuario", idUsuario);
            cmd.Parameters.AddWithValue("@idReto", idReto);
            cmd.Parameters.AddWithValue("@completado", completado);

            cmd.Parameters.Add("@error", SqlDbType.Int).Direction = ParameterDirection.Output;
            cmd.Parameters.Add("@info", SqlDbType.VarChar, int.MaxValue).Direction = ParameterDirection.Output;
            cmd.Parameters.Add("@id", SqlDbType.VarChar, int.MaxValue).Direction = ParameterDirection.Output;

            try
            {
                await sqlConnection.OpenAsync();
                SqlDataReader dr = await cmd.ExecuteReaderAsync();
                if (await dr.ReadAsync())
                {
                    item.Ur = new Usuario_Reto()
                    {
                        Reto = new Reto()
                        {
                            IdReto = new Guid(dr["idReto"].ToString()),
                            Nombre = dr["nombre"].ToString(),
                            FechaApertura = Convert.ToDateTime(dr["fechaApetura"].ToString()),
                            FechaCierre = Convert.ToDateTime(dr["fechaCierre"].ToString()),
                            Vidas = Convert.ToInt32(dr["retoVidas"].ToString()),
                            Tiempo_ms = Convert.ToInt32(dr["tiempo_ms"].ToString()),
                            PuntosRecompensa = Convert.ToInt32(dr["puntosRecompensa"].ToString()),
                            CreditosObtenidos = Convert.ToInt32(dr["creditosObtenidos"].ToString()),
                            Instrucciones = dr["instrucciones"].ToString(),
                            Imagen = dr["imagen"].ToString(),
                            IdTipoReto = new Guid(dr["idTipoReto"].ToString()),
                            TipoReto = dr["tipoReto"].ToString(),
                            IdTipoEncuesta = new Guid(dr["idTipoEncuesta"].ToString()),
                            TipoEncuesta = dr["tipoEncuesta"].ToString(),
                            IdComportamiento = new Guid(dr["idComportamiento"].ToString()),
                            ComportamientoPregunta = dr["comportamientoPregunta"].ToString(),
                            IdTipoValidador = new Guid(dr["idTipoValidador"].ToString()),
                            TipoValidador = dr["tipoValidador"].ToString(),
                            IdTipoArchivo = new Guid(dr["idTipoArchivo"].ToString()),
                            TipoArchivo = dr["tipoArchivo"].ToString(),
                            OpsRequeridas = Convert.ToInt32(dr["opsRequeridas"].ToString()),
                            CriterioMinimo = Convert.ToInt32(dr["criterioMinimo"].ToString()),
                            Estado = Convert.ToInt32(dr["estado"].ToString()),
                            TotalPreguntas = Convert.ToInt32(dr["totalPreguntas"].ToString()),                            
                            EnEquipo = Convert.ToInt32(dr["enEquipo"].ToString()),
                            Items = Convert.ToInt32(dr["items"].ToString()),                            
                        },
                        Usuario = new Usuario()
                        {
                            IdUsuario = new Guid(dr["idUsuario"].ToString()),
                        },
                        TotalOpsValidaciones = Convert.ToInt32(dr["totalOpsValidaciones"].ToString()),
                        Completado = Convert.ToInt32(dr["completado"].ToString()),
                        Puntos = Convert.ToInt32(dr["puntos"].ToString()),
                        Tiempo = Convert.ToInt32(dr["tiempo"].ToString()),
                        Vidas = Convert.ToInt32(dr["vidas"].ToString()),
                        Correctas = Convert.ToInt32(dr["correctas"].ToString()),
                        Incorrectas = Convert.ToInt32(dr["incorrectas"].ToString()),
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
                item.Ur = null;
            }
            finally
            {
                await sqlConnection.CloseAsync();
            }

            return item;
        }

        public async Task<Usuario_RetoList> GetUsuarioRetoList(string buscar, Guid idUsuario, int completado)
        {
            Usuario_RetoList list = new()
            {
                Lista = new()
            };

            SqlConnection sqlConnection = new(conexion.GetConnectionSqlServer());

            SqlCommand cmd = new("sp_B_Usuario_RetoByIdUsuarioByAll", sqlConnection)
            {
                CommandType = CommandType.StoredProcedure
            };

            cmd.Parameters.AddWithValue("@buscar", WC.GetTrim(buscar));
            cmd.Parameters.AddWithValue("@idUsuario", idUsuario);
            cmd.Parameters.AddWithValue("@completado", completado);

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
                        Reto = new Reto()
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
                            TipoReto = dr["tipoReto"].ToString(),
                            IdComportamiento = new Guid(dr["idComportamiento"].ToString()),
                            ComportamientoPregunta = dr["comportamientoPregunta"].ToString(),
                            IdTipoValidador = new Guid(dr["idTipoValidador"].ToString()),
                            TipoValidador = dr["tipoValidador"].ToString(),
                            CriterioMinimo = Convert.ToInt32(dr["criterioMinimo"].ToString()),
                            Estado = Convert.ToInt32(dr["estado"].ToString()),
                            TotalPreguntas = Convert.ToInt32(dr["totalPreguntas"].ToString()),                            
                            EnEquipo = Convert.ToInt32(dr["enEquipo"].ToString()),
                            Items = Convert.ToInt32(dr["items"].ToString()),                            
                        },
                        Usuario = new Usuario()
                        {
                            IdUsuario = new Guid(dr["idUsuario"].ToString()),
                        },
                        Completado = Convert.ToInt32(dr["completado"].ToString()),
                        Puntos = Convert.ToInt32(dr["puntos"].ToString()),
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

        public async Task<Usuario_RetoList> GetUsuarioRetoPuntosList(Guid idUsuario, int top)
        {
            Usuario_RetoList list = new()
            {
                Lista = new()
            };

            SqlConnection sqlConnection = new(conexion.GetConnectionSqlServer());

            SqlCommand cmd = new("sp_B_Usuario_RetoSumaPuntos", sqlConnection)
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
                        TotalRetos = Convert.ToInt32(dr["totalRetos"].ToString()),
                        Usuario = new Usuario()
                        {                            
                            IdUsuario = new Guid(dr["idUsuario"].ToString()),
                            Nombre = dr["nombre"].ToString(),
                            Apellido = dr["apellido"].ToString(),
                            IdArea = dr["idArea"].ToString(),
                            Area = dr["area"].ToString(),
                            IdCiudad = dr["idCiudad"].ToString(),
                            Ciudad = dr["ciudad"].ToString(),
                            Foto = dr["foto"].ToString(),
                        },
                        Puntos = Convert.ToInt32(dr["puntos"].ToString()),
                        Tiempo = Convert.ToInt32(dr["tiempo"].ToString()),
                        Posicion = Convert.ToInt32(dr["posicion"].ToString()),
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

        public async Task<ChartPuntosList> GetUsuarioRetoPuntosChartList(Guid idUsuario)
        {
            ChartPuntosList list = new()
            {
                Lista = new()
            };

            SqlConnection sqlConnection = new(conexion.GetConnectionSqlServer());

            SqlCommand cmd = new("sp_B_Usuario_RetoPtosMesesAños", sqlConnection)
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
                    list.Lista.Add(new ChartPuntos()
                    {
                        Puntos = Convert.ToInt32(dr["puntos"].ToString()),
                        Mes = Convert.ToInt32(dr["mes"].ToString()),
                        Año = Convert.ToInt32(dr["año"].ToString()),
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

        public async Task<Usuario_RetoList> GetUsuarioRetoList(Guid idReto, int validador) 
        {
            Usuario_RetoList list = new()
            {
                Lista = new()
            };

            SqlConnection sqlConnection = new(conexion.GetConnectionSqlServer());

            SqlCommand cmd = new("sp_B_Usuario_RetoByIdReto", sqlConnection)
            {
                CommandType = CommandType.StoredProcedure
            };

            cmd.Parameters.AddWithValue("@idReto", idReto);
            cmd.Parameters.AddWithValue("@validador", validador);

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
                        Usuario = new Usuario()
                        {
                            IdUsuario = new Guid(dr["idUsuario"].ToString()),
                            Foto = dr["foto"].ToString(),
                            Nombre = dr["nombre"].ToString(),
                            Apellido = dr["apellido"].ToString(),
                            Correo = dr["correo"].ToString(),
                            IdRol = dr["idRol"].ToString(),
                            Rol = dr["rol"].ToString(),
                            Estado = Convert.ToInt32(dr["estado"].ToString()),
                        },
                        Reto = new Reto()
                        {
                            IdReto = new Guid(dr["idReto"].ToString()),
                            IdTipoReto = new Guid(dr["idTipoReto"].ToString()),                            
                            TipoReto = dr["tipoReto"].ToString(),
                        },                              
                        Completado = Convert.ToInt32(dr["completado"].ToString()),
                        Validador = Convert.ToInt32(dr["validador"].ToString()),
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

        public async Task<Equipo_RetoList> GetEquiposByReto(int estado, Guid idReto)
        {
            Equipo_RetoList list = new()
            {
                Lista = new()
            };

            SqlConnection sqlConnection = new(conexion.GetConnectionSqlServer());

            SqlCommand cmd = new("sp_B_Equipo_RetoByIdReto", sqlConnection)
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
                while (await dr.ReadAsync())
                {
                    list.Lista.Add(new Equipo_Reto()
                    {
                        Equipo = new Equipo()
                        {
                            IdEquipo = new Guid(dr["idEquipo"].ToString()),
                            Nombre = dr["nombre"].ToString(),
                            Imagen = dr["imagen"].ToString(),
                            Estado = Convert.ToInt32(dr["estado"].ToString()),
                        },
                        Reto = new Reto()
                        {
                            IdReto = new Guid(dr["idReto"].ToString()),
                        },
                        TotalUsuarios = Convert.ToInt32(dr["totalUsuarios"].ToString()),
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
                        TipoReto = dr["tipoReto"].ToString(),
                        IdTipoEncuesta = new Guid(dr["idTipoEncuesta"].ToString()),
                        TipoEncuesta = dr["tipoEncuesta"].ToString(),
                        IdComportamiento = new Guid(dr["idComportamiento"].ToString()),
                        ComportamientoPregunta = dr["comportamientoPregunta"].ToString(),
                        IdTipoValidador = new Guid(dr["idTipoValidador"].ToString()),
                        TipoValidador = dr["tipoValidador"].ToString(),
                        IdTipoArchivo = new Guid(dr["idTipoArchivo"].ToString()),
                        TipoArchivo = dr["tipoArchivo"].ToString(),
                        Extension = dr["extensionArchivo"].ToString(),
                        OpsRequeridas = Convert.ToInt32(dr["opsRequeridas"].ToString()),
                        CriterioMinimo = Convert.ToInt32(dr["criterioMinimo"].ToString()),
                        TotalPreguntas = Convert.ToInt32(dr["totalPreguntas"].ToString()),
                        Estado = Convert.ToInt32(dr["estado"].ToString()), 
                        EnEquipo = Convert.ToInt32(dr["enEquipo"].ToString()),
                        Items = Convert.ToInt32(dr["items"].ToString()),                        
                        FechaCreacion = Convert.ToDateTime(dr["fechaCreacion"].ToString()),
                        FechaModificacion = Convert.ToDateTime(dr["fechaModificacion"].ToString())
                    };
                }
                await dr.NextResultAsync();

                item.Info = cmd.Parameters["@info"].Value.ToString();
                item.Error = Convert.ToInt32(cmd.Parameters["@error"].Value.ToString());

                item.UserValidadorLista = await GetUsuarioRetoList(idReto, 1);
            }
            catch (Exception ex)
            {
                item.Info = conexion.GetSettings().Production ? WC.GetError() : ex.Message;
                item.Error = 1;
                item.Reto = null;
                item.UserValidadorLista = null;
            }
            finally
            {
                await sqlConnection.CloseAsync();
            }

            return item;
        }

        public async Task<Response> GetUsuario_RetoValidador(Guid idReto, Guid idUsuario)
        {
            Response response = new();

            SqlConnection sqlConnection = new(conexion.GetConnectionSqlServer());
            SqlCommand cmd = new("sp_B_Usuario_RetoValidador", sqlConnection)
            {
                CommandType = CommandType.StoredProcedure
            };

            cmd.Parameters.AddWithValue("@idReto", idReto);
            cmd.Parameters.AddWithValue("@idUsuario", idUsuario);

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

        public async Task<Usuario_RetoList> GetUsuario_RetoxValidarByValidador(Guid idUsuario, int top)
        {
            Usuario_RetoList list = new()
            {
                Lista = new()
            };

            SqlConnection sqlConnection = new(conexion.GetConnectionSqlServer());

            SqlCommand cmd = new("sp_B_Usuario_RetoxValidarByValidador", sqlConnection)
            {
                CommandType = CommandType.StoredProcedure
            };
            
            cmd.Parameters.AddWithValue("@idUserValidador", idUsuario);
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
                        Usuario = new Usuario()
                        {
                            IdUsuario = new Guid(dr["idUsuario"].ToString()),                            
                        },
                        Reto = new Reto()
                        {
                            IdReto = new Guid(dr["idReto"].ToString()),
                            Imagen = dr["imagen"].ToString(),
                            Nombre = dr["nombre"].ToString(),
                            TipoReto = dr["tipoReto"].ToString(),
                            Estado = Convert.ToInt32(dr["estado"].ToString()),
                            UsuariosAsignados = Convert.ToInt32(dr["usuariosXvalidar"].ToString())
                        },                        
                        FechaCreacion = Convert.ToDateTime(dr["fechaCreacion"].ToString()),
                        FechaModificacion = Convert.ToDateTime(dr["fechaModificacion"].ToString()),                        
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

        public async Task<Usuario_RetoList> GetUsuario_RetoxValidarByReto(Guid idReto, Guid idUserValidador)
        {
            Usuario_RetoList list = new()
            {
                Lista = new()
            };

            SqlConnection sqlConnection = new(conexion.GetConnectionSqlServer());

            SqlCommand cmd = new("sp_B_Usuario_RetoxValidarByReto", sqlConnection)
            {
                CommandType = CommandType.StoredProcedure
            };

            cmd.Parameters.AddWithValue("@idReto", idReto);
            cmd.Parameters.AddWithValue("@idUserValidador", idUserValidador);

            cmd.Parameters.Add("@error", SqlDbType.Int).Direction = ParameterDirection.Output;
            cmd.Parameters.Add("@info", SqlDbType.VarChar, int.MaxValue).Direction = ParameterDirection.Output;
            cmd.Parameters.Add("@id", SqlDbType.VarChar, int.MaxValue).Direction = ParameterDirection.Output;

            try
            {
                await sqlConnection.OpenAsync();
                SqlDataReader dr = await cmd.ExecuteReaderAsync();
                while (await dr.ReadAsync())
                {
                    UsuarioxArchivoList archivos = await GetUsuarioXarchivos(new Guid(dr["idReto"].ToString()), new Guid(dr["idUsuario"].ToString()));

                    list.Lista.Add(new Usuario_Reto()
                    {
                        Usuario = new Usuario()
                        {
                            IdUsuario = new Guid(dr["idUsuario"].ToString()),
                            Foto = dr["foto"].ToString(),
                            Nombre = dr["nombre"].ToString(),
                            Apellido = dr["apellido"].ToString(),
                            Correo = dr["correo"].ToString(),                            
                        },
                        Reto = new Reto()
                        {
                            IdReto = new Guid(dr["idReto"].ToString()),
                            EnEquipo = Convert.ToInt32(dr["enEquipo"].ToString()),
                            Items = Convert.ToInt32(dr["itemsRecogidos"].ToString()),
                            TipoArchivo = dr["tipoArchivo"].ToString(),
                            IdTipoReto = new Guid(dr["idTipoReto"].ToString()),
                            TipoReto = dr["tipoReto"].ToString(),
                        },
                        TotalOpsValidador = Convert.ToInt32(dr["totalOpsValidador"].ToString()),
                        Completado = Convert.ToInt32(dr["completado"].ToString()),
                        FechaCreacion = Convert.ToDateTime(dr["fechaCreacion"].ToString()),
                        FechaModificacion = Convert.ToDateTime(dr["fechaModificacion"].ToString()),
                        Archivos = archivos.Lista
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

        public async Task<UsuarioxArchivoList> GetUsuarioXarchivos(Guid idReto, Guid idUsuario)
        {
            UsuarioxArchivoList list = new()
            {
                Lista = new()
            };

            SqlConnection sqlConnection = new(conexion.GetConnectionSqlServer());

            SqlCommand cmd = new("sp_B_UsuarioxArchivoByIdRetoYIdUser", sqlConnection)
            {
                CommandType = CommandType.StoredProcedure
            };

            cmd.Parameters.AddWithValue("@idReto", idReto);
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
                    list.Lista.Add(new UsuarioxArchivo()
                    {
                        IdReto = new Guid(dr["idReto"].ToString()),
                        IdUsuario = new Guid(dr["idUsuario"].ToString()),
                        Archivo = dr["archivo"].ToString(),
                        Url = dr["url"].ToString(),
                        FechaCreacion = Convert.ToDateTime(dr["fechaCreacion"].ToString()),
                        FechaModificacion = Convert.ToDateTime(dr["fechaModificacion"].ToString()),                        
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

        public async Task<Response> CreateReto(Reto reto)
        {
            Response response = new();

            SqlConnection sqlConnection = new(conexion.GetConnectionSqlServer());
            SqlCommand cmd = new("sp_C_Reto", sqlConnection)
            {
                CommandType = CommandType.StoredProcedure
            };

            cmd.Parameters.AddWithValue("@nombre", WC.GetTrim(reto.Nombre));
            cmd.Parameters.AddWithValue("@fechaApertura", reto.FechaApertura);
            cmd.Parameters.AddWithValue("@fechaCierre", reto.FechaCierre);
            cmd.Parameters.AddWithValue("@vidas", reto.Vidas);
            cmd.Parameters.AddWithValue("@tiempo", reto.Tiempo_ms);
            cmd.Parameters.AddWithValue("@puntosRecompensa", reto.PuntosRecompensa);
            cmd.Parameters.AddWithValue("@creditosObtenidos", reto.CreditosObtenidos);
            cmd.Parameters.AddWithValue("@criterioMin", reto.CriterioMinimo);
            cmd.Parameters.AddWithValue("@instrucciones", WC.GetTrim(reto.Instrucciones));
            cmd.Parameters.AddWithValue("@imagen", WC.GetTrim(reto.Imagen));
            cmd.Parameters.AddWithValue("@idTipoReto", reto.IdTipoReto);
            cmd.Parameters.AddWithValue("@idTipoEncuesta", reto.IdTipoEncuesta);
            cmd.Parameters.AddWithValue("@idComportamiento", reto.IdComportamiento);
            cmd.Parameters.AddWithValue("@idTipoValidador", reto.IdTipoValidador);
            cmd.Parameters.AddWithValue("@idTipoArchivo", reto.IdTipoArchivo);
            cmd.Parameters.AddWithValue("@items", reto.Items);            
            cmd.Parameters.AddWithValue("@opsRequeridas", reto.OpsRequeridas);
            cmd.Parameters.AddWithValue("@enEquipo", reto.EnEquipo);

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
                response.Id = "0";
            }
            finally
            {
                await sqlConnection.CloseAsync();
            }

            return response;
        }

        public async Task<Response> CreateEquipoReto(Guid idReto, Guid idEquipo)
        {
            Response response = new();

            SqlConnection sqlConnection = new(conexion.GetConnectionSqlServer());
            SqlCommand cmd = new("sp_C_Equipo_Reto", sqlConnection)
            {
                CommandType = CommandType.StoredProcedure
            };

            cmd.Parameters.AddWithValue("@idEquipo", idEquipo);
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

        public async Task<Response> CreateUsuarioxArchivo(UsuarioxArchivo usuarioxArchivo)
        {
            Response response = new();

            SqlConnection sqlConnection = new(conexion.GetConnectionSqlServer());
            SqlCommand cmd = new("sp_C_UsuarioxArchivo", sqlConnection)
            {
                CommandType = CommandType.StoredProcedure
            };

            cmd.Parameters.AddWithValue("@idReto", usuarioxArchivo.IdReto);
            cmd.Parameters.AddWithValue("@idUsuario", usuarioxArchivo.IdUsuario);
            cmd.Parameters.AddWithValue("@archivo", WC.GetTrim(usuarioxArchivo.Archivo));
            cmd.Parameters.AddWithValue("@url", WC.GetTrim(usuarioxArchivo.Url));

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
            cmd.Parameters.AddWithValue("@criterioMin", reto.CriterioMinimo);
            cmd.Parameters.AddWithValue("@instrucciones", WC.GetTrim(reto.Instrucciones));
            cmd.Parameters.AddWithValue("@imagen", WC.GetTrim(reto.Imagen));
            cmd.Parameters.AddWithValue("@idTipoReto", reto.IdTipoReto);
            cmd.Parameters.AddWithValue("@idComportamiento", reto.IdComportamiento);
            cmd.Parameters.AddWithValue("@opsRequeridas", reto.OpsRequeridas);

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

        public async Task<Response> UpdateUsuario_Reto(Usuario_Reto ur)
        {
            Response response = new();

            SqlConnection sqlConnection = new(conexion.GetConnectionSqlServer());
            SqlCommand cmd = new("sp_U_Usuario_Reto", sqlConnection)
            {
                CommandType = CommandType.StoredProcedure
            };

            cmd.Parameters.AddWithValue("@idUsuario", ur.Usuario.IdUsuario);
            cmd.Parameters.AddWithValue("@idReto", ur.Reto.IdReto);
            cmd.Parameters.AddWithValue("@puntos", ur.Puntos);
            cmd.Parameters.AddWithValue("@tiempo", ur.Tiempo);
            cmd.Parameters.AddWithValue("@vidas", ur.Vidas);
            cmd.Parameters.AddWithValue("@completado", ur.Completado);
            cmd.Parameters.AddWithValue("@correctas", ur.Correctas);
            cmd.Parameters.AddWithValue("@incorrectas", ur.Incorrectas);

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

        public async Task<Response> UpdateRetoByEstado(Reto reto)
        {
            Response response = new();

            SqlConnection sqlConnection = new(conexion.GetConnectionSqlServer());
            SqlCommand cmd = new("sp_U_RetoByEstado", sqlConnection)
            {
                CommandType = CommandType.StoredProcedure
            };

            cmd.Parameters.AddWithValue("@idReto", reto.IdReto);
            cmd.Parameters.AddWithValue("@estado", reto.Estado);

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

            cmd.Parameters.AddWithValue("@correo", WC.GetTrim(usuarioReto.Usuario.Correo));
            cmd.Parameters.AddWithValue("@idReto", usuarioReto.Reto.IdReto);
            cmd.Parameters.AddWithValue("@puntos", usuarioReto.Puntos);
            cmd.Parameters.AddWithValue("@tiempo", usuarioReto.Tiempo);
            cmd.Parameters.AddWithValue("@vidas", usuarioReto.Vidas);
            cmd.Parameters.AddWithValue("@tieneEquipo", usuarioReto.TieneEquipo);
            cmd.Parameters.AddWithValue("@validador", usuarioReto.Validador);

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

        public async Task<Response> CreateUsuarioReto(Guid idReto, string correo_id)
        {
            Response response = new();

            SqlConnection sqlConnection = new(conexion.GetConnectionSqlServer());
            SqlCommand cmd = new("sp_C_Usuario_RetoByCorreoIds", sqlConnection)
            {
                CommandType = CommandType.StoredProcedure
            };

            cmd.Parameters.AddWithValue("@correo_id", WC.GetTrim(correo_id));
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

        public async Task<Response> DeleteUsuarioReto(Guid idReto, Guid idUsuario)
        {
            Response response = new();

            SqlConnection sqlConnection = new(conexion.GetConnectionSqlServer());
            SqlCommand cmd = new("sp_D_Usuario_Reto", sqlConnection)
            {
                CommandType = CommandType.StoredProcedure
            };

            cmd.Parameters.AddWithValue("@idReto", idReto);
            cmd.Parameters.AddWithValue("@idUsuario", idUsuario);

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

        public async Task<Response> DeleteEquipoReto(Guid idReto, Guid idEquipo) 
        {
            Response response = new();

            SqlConnection sqlConnection = new(conexion.GetConnectionSqlServer());
            SqlCommand cmd = new("sp_D_Equipo_Reto", sqlConnection)
            {
                CommandType = CommandType.StoredProcedure
            };

            cmd.Parameters.AddWithValue("@idReto", idReto);
            cmd.Parameters.AddWithValue("@idEquipo", idEquipo);

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
