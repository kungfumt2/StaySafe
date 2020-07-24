using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;

namespace APIIS.Models
{
    public class Sintomas
    {
        public int IDS { get; set; }

        public string Sintoma { get; set; }

        public Sintomas()
        {
            IDS = 0;
            Sintoma = string.Empty;
        }

        private Sintomas ReadItem(SqlDataReader reader)
        {
            Sintomas sint = new Sintomas();

            sint.IDS = Convert.ToInt32(reader["IDS"]);
            sint.Sintoma = Convert.ToString(reader["Sintoma"]);

            return sint;
        }

        private void WriteItem(SqlCommand cmd, Sintomas sint)
        {
            cmd.Parameters.Add("@sint", System.Data.SqlDbType.VarChar).Value = sint.Sintoma;

        }

        public List<Sintomas> GetSintomas(string strc)
        {
            List<Sintomas> lista = new List<Sintomas>();

            using (SqlConnection con = new SqlConnection(strc))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.CommandText = "stp_GetSintomas";
                    cmd.Connection = con;
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    con.Open();

                    SqlDataReader reader = cmd.ExecuteReader();

                    while(reader.Read())
                    {
                        Sintomas sint = new Sintomas();

                        sint = ReadItem(reader);

                        lista.Add(sint);
                    }

                    con.Close();
                }
            }

            return lista;
        }

        public void CreateSintomas(string strc, Sintomas sint)
        {
            using (SqlConnection con = new SqlConnection(strc))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.CommandText = "stp_CreateSintomas";
                    cmd.Connection = con;
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    WriteItem(cmd, sint);

                    con.Open();

                    cmd.ExecuteNonQuery();

                    con.Close();
                }
            }
        }
    }
}
