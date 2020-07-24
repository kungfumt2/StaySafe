using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;

namespace APIIS.Models
{
    public class RelFact
    {
        public int IdF { get; set; }

        public int IdP { get; set; }

        public string Tempo { get; set; }

        public RelFact()
        {
            IdF = 0;
            IdP = 0;
            Tempo = string.Empty;
        }

        private RelFact ReadItem(SqlDataReader reader)
        {
            RelFact relFact = new RelFact();

            relFact.IdF = Convert.ToInt32(reader["IdF"]);
            relFact.IdP = Convert.ToInt32(reader["IdP"]);
            relFact.Tempo = Convert.ToString(reader["Tempo"]);

            return relFact;
        }

        private void WriteItem(SqlCommand cmd, RelFact relFact)
        {
            cmd.Parameters.Add("@idf", System.Data.SqlDbType.Int).Value = relFact.IdF;
            cmd.Parameters.Add("@idp", System.Data.SqlDbType.Int).Value = relFact.IdP;
            cmd.Parameters.Add("@time", System.Data.SqlDbType.VarChar).Value = relFact.Tempo;
        }

        public List<RelFact> GetRelFacts(string strc, int idp)
        {
            List<RelFact> lista = new List<RelFact>();

            using (SqlConnection con = new SqlConnection(strc))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.CommandText = "stp_GetRelFact";
                    cmd.Connection = con;
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    cmd.Parameters.Add("@idp", System.Data.SqlDbType.Int).Value = idp;

                    con.Open();

                    SqlDataReader reader = cmd.ExecuteReader();

                    while(reader.Read())
                    {
                        RelFact relFact = new RelFact();

                        relFact = ReadItem(reader);

                        lista.Add(relFact);
                    }

                    con.Close();
                }
            }

            return lista;
        }

        public void CreateRelFact(string strc, RelFact relFact)
        {
            using (SqlConnection con = new SqlConnection(strc))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.CommandText = "stp_CreateRelFact";
                    cmd.Connection = con;
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    WriteItem(cmd, relFact);
                    con.Open();

                    cmd.ExecuteNonQuery();

                    con.Close();
                }
            }
        }
    }
}
