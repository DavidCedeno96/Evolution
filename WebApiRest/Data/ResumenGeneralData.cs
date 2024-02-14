using System.Data.SqlClient;
using System.Data;
using WebApiRest.Models;
using WebApiRest.Utilities;

namespace WebApiRest.Data
{
    public class ResumenGeneralData
    {
        private readonly Conexion conexion = new();

        public async Task<ResumenGeneralItem> GetResumenGeneral(Guid idUsuario)
        {
            ResumenGeneralItem item = new();

            SqlConnection sqlConnection = new(conexion.GetConnectionSqlServer());

            SqlCommand cmd = new("sp_B_resumenGeneral", sqlConnection)
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
                if (await dr.ReadAsync())
                {
                    item.ResumenGeneral = new ResumenGeneral()
                    {                        
                        RetosCompletados = Convert.ToInt32(dr["retosCompletados"].ToString()),
                        MedallasConseguidas = Convert.ToInt32(dr["medallasConseguidas"].ToString()),
                        RecomensasReclamadas = Convert.ToInt32(dr["recompensasReclamadas"].ToString()),                        
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
                item.ResumenGeneral = null;
            }
            finally
            {
                await sqlConnection.CloseAsync();
            }

            return item;
        }
    }
}
