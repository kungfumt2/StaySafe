using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;

namespace APIIS.Models
{
    public class Conselho
    {
        public int IdConselho { get; set; }

        public string Nome { get; set; }

        public int IdDist { get; set; }


        public Conselho()
        {
            IdConselho = 0;
            Nome = string.Empty;
            IdDist = 0;
        }

        private Conselho ReadItem(SqlDataReader reader)
        {
            Conselho dist = new Conselho();

            dist.IdConselho = Convert.ToInt32(reader["IdConselho"]);
            dist.Nome = Convert.ToString(reader["Nome"]);
            dist.IdDist = Convert.ToInt32(reader["IdDist"]);

            return dist;
        }

        private void WriteItem(SqlCommand cmd, Conselho dis)
        {
            cmd.Parameters.Add("@name", System.Data.SqlDbType.VarChar).Value = dis.Nome;
            cmd.Parameters.Add("@idd", System.Data.SqlDbType.Int).Value = dis.IdDist;
        }

        public List<Conselho> GetConselho(string strc,string what,int value)
        {
            List<Conselho> lista = new List<Conselho>();

            using (SqlConnection con = new SqlConnection(strc))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.CommandText = "stp_GetConselho";
                    cmd.Connection = con;
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    cmd.Parameters.Add("@what", System.Data.SqlDbType.VarChar).Value = what;
                    cmd.Parameters.Add("@value", System.Data.SqlDbType.Int).Value = value;

                    con.Open();

                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        Conselho dis = new Conselho();

                        dis = ReadItem(reader);

                        lista.Add(dis);
                    }

                    con.Close();
                }
            }

            return lista;
        }

        public void CreateConselho(string strc, Conselho dis)
        {
            using (SqlConnection con = new SqlConnection(strc))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.CommandText = "stp_CreateConselho";
                    cmd.Connection = con;
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    WriteItem(cmd, dis);

                    con.Open();

                    cmd.ExecuteNonQuery();

                    con.Close();
                }
            }
        }
    }
}
