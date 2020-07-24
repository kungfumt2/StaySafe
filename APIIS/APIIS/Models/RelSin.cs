using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;

namespace APIIS.Models
{
    public class RelSin
    {
        public int IdP { get; set; }

        public int IdS { get; set; }

        public DateTime DataSintoma { get; set; }

        public RelSin()
        {
            IdP = 0;
            IdS = 0;
            DataSintoma = new DateTime();

        }

        private RelSin ReadItem(SqlDataReader reader)
        {
            RelSin relSin = new RelSin();

            relSin.IdP = Convert.ToInt32(reader["IdP"]);
            relSin.IdS = Convert.ToInt32(reader["IdS"]);
            relSin.DataSintoma = Convert.ToDateTime(reader["DataSintoma"]);

            return relSin;
        }

        private void WriteItem(SqlCommand cmd, RelSin relSin)
        {
            cmd.Parameters.Add("@idp", System.Data.SqlDbType.Int).Value = relSin.IdP;
            cmd.Parameters.Add("@ids", System.Data.SqlDbType.Int).Value = relSin.IdS;
            cmd.Parameters.Add("@DS", System.Data.SqlDbType.DateTime2).Value = relSin.DataSintoma;
        }

        public List<RelSin> GetRelSins(string strc, int idp)
        {
            List<RelSin> lista = new List<RelSin>();

            using (SqlConnection con = new SqlConnection(strc))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.CommandText = "stp_GetRelSin";
                    cmd.Connection = con;
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    cmd.Parameters.Add("@idp", System.Data.SqlDbType.Int).Value = idp;

                    con.Open();

                    SqlDataReader reader = cmd.ExecuteReader();

                    while(reader.Read())
                    {
                        RelSin relSin = new RelSin();

                        relSin = ReadItem(reader);

                        lista.Add(relSin);
                    }

                    con.Close();
                }
            }

            return lista;
        }

        public void CreateRelSin(string strc, RelSin relSin)
        {
            using (SqlConnection con = new SqlConnection(strc))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.CommandText = "stp_CreateRelSin";
                    cmd.Connection = con;
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    WriteItem(cmd, relSin);

                    con.Open();

                    cmd.ExecuteNonQuery();

                    con.Close();
                }
            }
        }
    }
}
