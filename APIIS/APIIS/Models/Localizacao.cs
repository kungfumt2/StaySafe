using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;

namespace APIIS.Models
{
    public class Localizacao
    {
        public int IdC { get; set; }

        public double Latitude { get; set; }

        public double Longitude { get; set; }

        public bool Validado { get; set; }


        public Localizacao()
        {
            IdC = 0;
            Latitude = 0.0;
            Longitude = 0.0;
            Validado = false;
        }

        public Localizacao ReadItem(SqlDataReader reader)
        {
            Localizacao loc = new Localizacao();

            loc.IdC = Convert.ToInt32(reader["IdC"]);
            loc.Latitude = Convert.ToDouble(reader["Latitude"]);
            loc.Longitude = Convert.ToDouble(reader["Longitude"]);
            loc.Validado = Convert.ToBoolean(reader["Validado"]);

            return loc;
        }

        public void WriteItem(SqlCommand cmd, Localizacao loc)
        {
            cmd.Parameters.Add("@idc", System.Data.SqlDbType.Int).Value = loc.IdC;
            cmd.Parameters.Add("@lat", System.Data.SqlDbType.Float).Value = loc.Latitude;
            cmd.Parameters.Add("@long", System.Data.SqlDbType.Float).Value = loc.Longitude;
            cmd.Parameters.Add("@val", System.Data.SqlDbType.Bit).Value = loc.Validado;
        }

        public List<Localizacao> GetLocalizacoes(string strc, int idc)
        {
            List<Localizacao> lista = new List<Localizacao>();

            using (SqlConnection con = new SqlConnection(strc))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.CommandText = "stp_GetLocalizacao";
                    cmd.Connection = con;
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    cmd.Parameters.Add("@idc", System.Data.SqlDbType.Int).Value = idc;

                    con.Open();

                    SqlDataReader reader = cmd.ExecuteReader();

                    while(reader.Read())
                    {
                        Localizacao loc = new Localizacao();

                        loc = ReadItem(reader);

                        lista.Add(loc);
                    }

                    con.Close();
                }
            }

            return lista;
        }

        public void CreateLocalizacao(string strc, Localizacao loc)
        {
            using (SqlConnection con = new SqlConnection(strc))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.CommandText = "stp_CreateLocalizacao";
                    cmd.Connection = con;
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    WriteItem(cmd, loc);

                    con.Open();

                    cmd.ExecuteNonQuery();

                    con.Close();
                }
            }
        }

        public void UpdateLocalizacao(string strc, int idc, bool val)
        {
            using (SqlConnection con = new SqlConnection(strc))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.CommandText = "stp_UpdateLocalizacao";
                    cmd.Connection = con;
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    cmd.Parameters.Add("@idc", System.Data.SqlDbType.Int).Value = idc;
                    cmd.Parameters.Add("@val", System.Data.SqlDbType.Bit).Value = val;

                    con.Open();

                    cmd.ExecuteNonQuery();

                    con.Close();
                }
            }
        }
    }
}
