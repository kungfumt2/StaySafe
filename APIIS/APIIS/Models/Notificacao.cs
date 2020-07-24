using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;

namespace APIIS.Models
{
    public class Notificacao
    {
        public int Id { get; set; }

        public string Mensagem { get; set; }


        public Notificacao()
        {
            Id = 0;
            Mensagem = string.Empty;
        }

        private Notificacao ReadItem(SqlDataReader reader)
        {
            Notificacao not = new Notificacao();

            not.Id = Convert.ToInt32(reader["Id"]);
            not.Mensagem = Convert.ToString(reader["Mensagem"]);

            return not;
        }

        private void WriteItem(SqlCommand cmd, Notificacao not)
        {
            cmd.Parameters.Add("@mess", System.Data.SqlDbType.VarChar).Value = not.Mensagem;
        }

        public Notificacao GetNotificacao(string str)
        {
            Notificacao not = new Notificacao();

            using (SqlConnection con = new SqlConnection(str))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.CommandText = "stp_GetNotificacao";
                    cmd.Connection = con;
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    con.Open();

                    SqlDataReader reader = cmd.ExecuteReader();

                    while(reader.Read())
                    {
                        not = ReadItem(reader);
                    }

                    con.Close();
                }
            }

            return not;
        }

        public void CreateNotificacao(string str, Notificacao not)
        {
            using (SqlConnection con = new SqlConnection(str))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.CommandText = "stp_CreateNotificacao";
                    cmd.Connection = con;
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    WriteItem(cmd, not);

                    con.Open();

                    cmd.ExecuteNonQuery();

                    con.Close();
                }
            }
        }

        public void DeleteNotificacao(string str, int id)
        {
            using (SqlConnection con = new SqlConnection(str))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.CommandText = "stp_DeleteNotificacao";
                    cmd.Connection = con;
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    cmd.Parameters.Add("@id", System.Data.SqlDbType.Int).Value = id;

                    con.Open();

                    cmd.ExecuteNonQuery();

                    con.Close();
                }
            }
        }
    }
}
