using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;

namespace APIIS.Models
{
    public class Utilizador
    {
        public int Id { get; set; }

        public string Nome { get; set; }

        public string Password { get; set; }

        public string Email { get; set; }

        public string Tipo { get; set; }

        public byte[] Fotografia { get; set; }

        public string Estado { get; set; }

        public Utilizador()
        {
            Id = 0;
            Nome = string.Empty;
            Password = string.Empty;
            Email = string.Empty;
            Tipo = string.Empty;
            Fotografia = null;
            Estado = "Pendente";
        }

        private Utilizador ReadItem(SqlDataReader reader)
        {
            Utilizador user = new Utilizador();

            user.Id = Convert.ToInt32(reader["Id"]);
            user.Nome = Convert.ToString(reader["Nome"]);
            user.Password = Convert.ToString(reader["PW"]);
            user.Email = Convert.ToString(reader["Email"]);
            user.Tipo = Convert.ToString(reader["Tipo"]);
            user.Fotografia = (byte[])(reader["Fotografia"]);
            user.Estado = Convert.ToString(reader["Estado"]);

            return user;
        }

        private void WriteItem(SqlCommand cmd, Utilizador user)
        {
            cmd.Parameters.Add("@name", System.Data.SqlDbType.VarChar).Value = user.Nome;
            cmd.Parameters.Add("@pw", System.Data.SqlDbType.VarChar).Value = user.Password;
            cmd.Parameters.Add("@email", System.Data.SqlDbType.VarChar).Value = user.Email;
            cmd.Parameters.Add("@type", System.Data.SqlDbType.VarChar).Value = user.Tipo;
            cmd.Parameters.Add("@foto", System.Data.SqlDbType.VarBinary).Value = user.Fotografia;
            cmd.Parameters.Add("@state", System.Data.SqlDbType.VarChar).Value = user.Estado;

        }

        public List<Utilizador> GetUtilizadors(string strc, string what, int idd, string name)
        {
            List<Utilizador> utilizadors = new List<Utilizador>();

            using (SqlConnection con = new SqlConnection(strc))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.CommandText = "stp_GetUtilizador";
                    cmd.Connection = con;
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    cmd.Parameters.Add("@what", System.Data.SqlDbType.VarChar).Value = what;
                    cmd.Parameters.Add("@idd", System.Data.SqlDbType.Int).Value = idd;
                    cmd.Parameters.Add("@name", System.Data.SqlDbType.VarChar).Value = name;

                    con.Open();

                    SqlDataReader reader = cmd.ExecuteReader();

                    while(reader.Read())
                    {
                        Utilizador user = new Utilizador();

                        user = ReadItem(reader);

                        utilizadors.Add(user);
                    }

                    con.Close();
                }
            }

            return utilizadors;
        }

        public void CreateUtilizador(string strc, Utilizador user)
        {
            using (SqlConnection con = new SqlConnection(strc))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.CommandText = "stp_CreateUtilizador";
                    cmd.Connection = con;
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    WriteItem(cmd, user);

                    con.Open();

                    cmd.ExecuteNonQuery();

                    con.Close();


                }
            }
        }

        public void UpdateUtilizador(string strc, string pw, int idd)
        {
            using (SqlConnection con = new SqlConnection(strc))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.CommandText = "stp_UpdateUtilizador";
                    cmd.Connection = con;
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    cmd.Parameters.Add("@pw", System.Data.SqlDbType.VarChar).Value = pw;
                    cmd.Parameters.Add("@idd", System.Data.SqlDbType.Int).Value = idd;

                    con.Open();

                    cmd.ExecuteNonQuery();

                    con.Close();
                }
            }
        }

        public void ValidarUtilizador(string strc, string estado, int idd)
        {
            using (SqlConnection con = new SqlConnection(strc))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.CommandText = "stp_ValidarUtilizador";
                    cmd.Connection = con;
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    cmd.Parameters.Add("@estado", System.Data.SqlDbType.VarChar).Value = estado;
                    cmd.Parameters.Add("@idd", System.Data.SqlDbType.Int).Value = idd;

                    con.Open();

                    cmd.ExecuteNonQuery();

                    con.Close();
                }
            }
        }

        public void UpdateEstadoUtilizador(string strc, int id, string estado)
        {
            using (SqlConnection con = new SqlConnection(strc))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.CommandText = "stp_UpdateEstadoUtilizador";
                    cmd.Connection = con;
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    cmd.Parameters.Add("@id", System.Data.SqlDbType.Int).Value = id;
                    cmd.Parameters.Add("@estado", System.Data.SqlDbType.VarChar).Value = estado;

                    con.Open();

                    cmd.ExecuteNonQuery();

                    con.Close();
                }
            }
        }
    }
}
