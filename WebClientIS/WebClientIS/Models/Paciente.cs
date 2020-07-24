using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Threading.Tasks;
using System.Web.Mvc;

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


        public List<Paciente> GetPacientes()
        {
            List<Paciente> lista = new List<Paciente>();

            HttpClient client = new HttpClient();

            client.BaseAddress = new Uri("http://6f85a52b4f05.ngrok.io/api/Paciente/" );

            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));

            HttpResponseMessage response = client.GetAsync("").Result;

         
                var products = response.Content.ReadAsStringAsync().Result;

                var array = JArray.Parse(products);

                foreach (var obj in array)
                {
                    
                        lista.Add(obj.ToObject<Paciente>());
                    
                 
                }

            

            return lista;

        }
        public IEnumerable<SelectListItem> TypeList
        { 
            get
            {
                List<SelectListItem> x = new List<SelectListItem>();
                  Conselho c = new Conselho();
                List<Conselho> lc = new List<Conselho>();
                lc = c.GetConselhos();
                foreach(Conselho conselho in lc)
                {
                    x.Add(new SelectListItem { Text = conselho.Nome, Value = conselho.Nome });
                    
                }
                return x;
            }
        }
        public bool CreatePaciente()
        {
            HttpClient client = new HttpClient();

            var values = new Dictionary<string, string>
            {
                { "IDU", IDU.ToString() },
                { "CodigoPac", CodigoPac },
                { "Idade", Idade.ToString() },
                { "Sexo", Sexo },
                { "Estado", Estado },
                { "Risco", Risco.ToString() },
                { "Morada", Morada },
                { "CodigoPostal", CodigoPostal },
            };

            client.BaseAddress = new Uri("http://6f85a52b4f05.ngrok.io/api/Paciente");

            var jsonString = JsonConvert.SerializeObject(values);
            var content = new StringContent(jsonString, Encoding.UTF8, "application/json");

            var resposta = client.PostAsync(client.BaseAddress.ToString(), content).Result;

            if (resposta.IsSuccessStatusCode)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        public bool UpdatePacienteEstado(int idu, object value)
        {
            HttpClient client = new HttpClient();

            client.BaseAddress = new Uri("http://6f85a52b4f05.ngrok.io/api/Paciente/" + idu.ToString());

            var jsonString = JsonConvert.SerializeObject(value.ToString());
            var content = new StringContent(jsonString, Encoding.UTF8, "application/json");

            var resposta = client.PutAsync(client.BaseAddress.ToString(), content).Result;

            if (resposta.IsSuccessStatusCode)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        public bool UpdatePacienteMorada(int idu, object value)
        {
            HttpClient client = new HttpClient();

            client.BaseAddress = new Uri("http://6f85a52b4f05.ngrok.io/api/Paciente/" + idu.ToString() + "/Morada");

            var jsonString = JsonConvert.SerializeObject(value.ToString());
            var content = new StringContent(jsonString, Encoding.UTF8, "application/json");

            var resposta = client.PutAsync(client.BaseAddress.ToString(), content).Result;

            if (resposta.IsSuccessStatusCode)
            {
                return true;
            }
            else
            {
                return false;
            }
        }


    }
}
