using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;

namespace APIIS.Models
{
    public class RelCons
    {
        public DateTime DataRel { get; set; }

        public int IdU { get; set; }

        public int IdC { get; set; }

        public RelCons()
        {
            DataRel = new DateTime();
            IdU = 0;
            IdC = 0;
        }

        private RelCons ReadItem(SqlDataReader reader)
        {
            RelCons relFact = new RelCons();

            relFact.DataRel = Convert.ToDateTime(reader["DataRel"]);
            relFact.IdU = Convert.ToInt32(reader["IdU"]);
            relFact.IdC = Convert.ToInt32(reader["IdC"]);

            return relFact;
        }

        private void WriteItem(SqlCommand cmd, RelCons relFact)
        {
            cmd.Parameters.Add("@idu", System.Data.SqlDbType.Int).Value = relFact.IdU;
            cmd.Parameters.Add("@idc", System.Data.SqlDbType.Int).Value = relFact.IdC;
            cmd.Parameters.Add("@date", System.Data.SqlDbType.DateTime2).Value = relFact.DataRel;
        }

        public List<RelCons> GetRelCons(string strc, int idu)
        {
            List<RelCons> lista = new List<RelCons>();

            using (SqlConnection con = new SqlConnection(strc))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.CommandText = "stp_GetRelCons";
                    cmd.Connection = con;
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    cmd.Parameters.Add("@idu", System.Data.SqlDbType.Int).Value = idu;

                    con.Open();

                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        RelCons relFact = new RelCons();

                        relFact = ReadItem(reader);

                        lista.Add(relFact);
                    }

                    con.Close();
                }
            }

            return lista;
        }

        public void CreateRelCons(string strc, RelCons relFact)
        {
            using (SqlConnection con = new SqlConnection(strc))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.CommandText = "stp_CreateRelCons";
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
