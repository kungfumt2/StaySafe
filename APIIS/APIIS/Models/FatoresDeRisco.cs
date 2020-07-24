using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;

namespace APIIS.Models
{
    public class FatoresDeRisco
    {
        public int Id { get; set; }

        public string Fator { get; set; }

        
        public FatoresDeRisco()
        {
            Id = 0;
            Fator = string.Empty;
        }

        private FatoresDeRisco ReadItem(SqlDataReader reader)
        {
            FatoresDeRisco fatores = new FatoresDeRisco();

            fatores.Id = Convert.ToInt32(reader["Id"]);
            fatores.Fator = Convert.ToString(reader["Fator"]);

            return fatores;
        }

        private void WriteItem(SqlCommand cmd, FatoresDeRisco fatores)
        {
            cmd.Parameters.Add("@fator", System.Data.SqlDbType.VarChar).Value = fatores.Fator;
        }

        public List<FatoresDeRisco> GetFatoresDeRiscos(string strc)
        {
            List<FatoresDeRisco> fact = new List<FatoresDeRisco>();

            using (SqlConnection con = new SqlConnection(strc))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.CommandText = "stp_GetFatoresDeRisco";
                    cmd.Connection = con;
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    con.Open();

                    SqlDataReader reader = cmd.ExecuteReader();

                    while(reader.Read())
                    {
                        FatoresDeRisco risk = new FatoresDeRisco();

                        risk = ReadItem(reader);

                        fact.Add(risk);
                    }
                }
            }

            return fact;
        }

        public void CreateFatoresDeRisco(string strc, FatoresDeRisco fatores)
        {
            using (SqlConnection con = new SqlConnection(strc))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.CommandText = "stp_CreateFatoresDeRisco";
                    cmd.Connection = con;
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    WriteItem(cmd, fatores);

                    con.Open();

                    cmd.ExecuteNonQuery();

                    con.Close();
                }
            }
        }
    }
}
