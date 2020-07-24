using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;

namespace APIIS.Models
{
    public class Distrito
    {
        public int IdD { get; set; }

        public string Nome { get; set; }

        public Distrito()
        {
            IdD = 0;
            Nome = string.Empty;
        }

        private Distrito ReadItem(SqlDataReader reader)
        {
            Distrito dist = new Distrito();

            dist.IdD = Convert.ToInt32(reader["IdD"]);
            dist.Nome = Convert.ToString(reader["Nome"]);

            return dist;
        }

        private void WriteItem(SqlCommand cmd, Distrito dis)
        {
            cmd.Parameters.Add("@name", System.Data.SqlDbType.VarChar).Value = dis.Nome;
        }

        public List<Distrito> GetDistritos(string strc)
        {
            List<Distrito> lista = new List<Distrito>();

            using (SqlConnection con = new SqlConnection(strc))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.CommandText = "stp_GetDistrito";
                    cmd.Connection = con;
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    con.Open();

                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        Distrito dis = new Distrito();

                        dis = ReadItem(reader);

                        lista.Add(dis);
                    }

                    con.Close();
                }
            }

            return lista;
        }

        public void CreateDistrito(string strc, Distrito dis)
        {
            using (SqlConnection con = new SqlConnection(strc))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.CommandText = "stp_CreateDistrito";
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
