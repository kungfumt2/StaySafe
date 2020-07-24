using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;

namespace APIIS.Models
{
    public class Paciente
    {
        public int IDU { get; set; }

        public string CodigoPac { get; set; }

        public int Idade { get; set; }

        public string Sexo { get; set; }

        public string Estado { get; set; }

        public bool Risco { get; set; }

        public string Morada { get; set; }

        public string CodigoPostal { get; set; }


        public Paciente()
        {
            IDU = 0;
            CodigoPac = string.Empty;
            Idade = 0;
            Sexo = string.Empty;
            Estado = "Não infetado";
            Risco = false;
            Morada = string.Empty;
            CodigoPostal = string.Empty;

        }

        private Paciente ReadItem(SqlDataReader reader)
        {
            Paciente pac = new Paciente();

            pac.IDU = Convert.ToInt32(reader["IDU"]);
            pac.CodigoPac = Convert.ToString(reader["CodigoPac"]);
            pac.Idade = Convert.ToInt32(reader["Idade"]);
            pac.Sexo = Convert.ToString(reader["Sexo"]);
            pac.Estado = Convert.ToString(reader["Estado"]);
            pac.Risco = Convert.ToBoolean(reader["Risco"]);
            pac.Morada = Convert.ToString(reader["Morada"]);
            pac.CodigoPostal = Convert.ToString(reader["CodigoPostal"]);

            return pac;
        }

        private void WriteItem(SqlCommand cmd, Paciente pac)
        {
            cmd.Parameters.Add("@idu", System.Data.SqlDbType.Int).Value = pac.IDU;
            cmd.Parameters.Add("@CP", System.Data.SqlDbType.VarChar).Value = pac.CodigoPac;
            cmd.Parameters.Add("@age", System.Data.SqlDbType.Int).Value = pac.Idade;
            cmd.Parameters.Add("@sex", System.Data.SqlDbType.VarChar).Value = pac.Sexo;
            cmd.Parameters.Add("@state", System.Data.SqlDbType.VarChar).Value = pac.Estado;
            cmd.Parameters.Add("@risk", System.Data.SqlDbType.Bit).Value = pac.Risco;
            cmd.Parameters.Add("@mor", System.Data.SqlDbType.VarChar).Value = pac.Morada;
            cmd.Parameters.Add("@codepostal", System.Data.SqlDbType.VarChar).Value = pac.CodigoPostal;


        }

        public List<Paciente> GetPacientes(string strc, string what, int idu, string value)
        {
            List<Paciente> lista = new List<Paciente>();

            using (SqlConnection con = new SqlConnection(strc))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.CommandText = "stp_GetPaciente";
                    cmd.Connection = con;
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    cmd.Parameters.Add("@what", System.Data.SqlDbType.VarChar).Value = what;
                    cmd.Parameters.Add("@idu", System.Data.SqlDbType.Int).Value = idu;
                    cmd.Parameters.Add("@value", System.Data.SqlDbType.VarChar).Value = value;

                    con.Open();

                    SqlDataReader reader = cmd.ExecuteReader();

                    while(reader.Read())
                    {
                        Paciente pac = new Paciente();

                        pac = ReadItem(reader);

                        lista.Add(pac);
                    }
                }
            }

            return lista;
        }

        public void CreatePaciente(string strc, Paciente pac)
        {
            using (SqlConnection con = new SqlConnection(strc))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.CommandText = "stp_CreatePaciente";
                    cmd.Connection = con;
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    WriteItem(cmd, pac);

                    con.Open();

                    cmd.ExecuteNonQuery();

                    con.Close();
                }
            }
        }

        public void UpdatePacienteEstado(string strc, string what, string state, bool risk, int idu)
        {
            using (SqlConnection con = new SqlConnection(strc))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.CommandText = "stp_UpdatePacienteEstado";
                    cmd.Connection = con;
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    cmd.Parameters.Add("@what", System.Data.SqlDbType.VarChar).Value = what;
                    cmd.Parameters.Add("@state", System.Data.SqlDbType.VarChar).Value = state;
                    cmd.Parameters.Add("@risk", System.Data.SqlDbType.Bit).Value = risk;
                    cmd.Parameters.Add("@idu", System.Data.SqlDbType.Int).Value = idu;

                    con.Open();

                    cmd.ExecuteNonQuery();

                    con.Close();
                }
            }
        }

        public void UpdatePacienteMorada(string strc,string what, string morada, string cp, int idu)
        {
            using (SqlConnection con = new SqlConnection(strc))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.CommandText = "stp_UpdatePacienteMorada";
                    cmd.Connection = con;
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    cmd.Parameters.Add("@what", System.Data.SqlDbType.VarChar).Value = what;
                    cmd.Parameters.Add("@morada", System.Data.SqlDbType.VarChar).Value = morada;
                    cmd.Parameters.Add("@cp", System.Data.SqlDbType.VarChar).Value = cp;
                    cmd.Parameters.Add("@idu", System.Data.SqlDbType.Int).Value = idu;

                    con.Open();

                    cmd.ExecuteNonQuery();

                    con.Close();
                }
            }
        }


    }
}
