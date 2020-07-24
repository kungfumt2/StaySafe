using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Data.SqlClient;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Threading.Tasks;
using System.Web.Helpers;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

namespace APIIS.Models
{
    public class Utilizador
    {
        public int Id { get; set; }

        public string Nome { get; set; }
        [DataType(DataType.Password)]
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


        public Utilizador GetUtilizadors(int idd, string name)
        {
            Utilizador utilizadors = new Utilizador();

            HttpClient client = new HttpClient();

            client.BaseAddress = new Uri("http://6f85a52b4f05.ngrok.io/api/Utilizador/" + idd.ToString() + "/" + name);

            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));

            HttpResponseMessage response = client.GetAsync("").Result;

       
                var products = response.Content.ReadAsStringAsync().Result;

                var array = (JObject)JsonConvert.DeserializeObject(products);
            utilizadors = array.ToObject<Utilizador>();



           


            return utilizadors;
        }

        public async Task<int> CreateUtilizadorAsync()
        {
            HttpClient client = new HttpClient();

            var values = new Dictionary<string, object>
            {
                { "Id", Id.ToString() },
                {"Nome",Nome },
                {"Password",Password },
                {"Email",Email },
                {"Tipo",Tipo },
                {"Fotografia",Fotografia },
                {"Estado",Estado }


            };

            client.BaseAddress = new Uri("http://6f85a52b4f05.ngrok.io/api/Utilizador");

            var jsonString = JsonConvert.SerializeObject(values);
            var content = new StringContent(jsonString, Encoding.UTF8, "application/json");

            var resposta = client.PostAsync(client.BaseAddress.ToString(), content).Result;

           
          
                string responseBody = await resposta.Content.ReadAsStringAsync();


              

                return Convert.ToInt32(responseBody);
           

        }

        public bool UpdateUtilizador(string pw, int idd)
        {
            HttpClient client = new HttpClient();

            client.BaseAddress = new Uri("http://6f85a52b4f05.ngrok.io/api/Utilizador/" + idd.ToString() + "/UpdatePass");

            var jsonString = JsonConvert.SerializeObject(pw);
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

        public bool ValidarUtilizador(string estado, int idd)
        {
            HttpClient client = new HttpClient();

            client.BaseAddress = new Uri("http://6f85a52b4f05.ngrok.io/api/Utilizador/" + idd.ToString() + "/ValidarUser");

            var jsonString = JsonConvert.SerializeObject(estado);
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
        public async Task<string> avaliarUtilizador(List<String> lista)
        {
            lista[0] = WebClientIS.Controllers.HomeController.UserId.ToString();

            var jsonString = JsonConvert.SerializeObject(lista);
            var content = new StringContent(jsonString, Encoding.UTF8, "application/json");


            HttpClient client = new HttpClient();

            client.BaseAddress = new Uri("http://6f85a52b4f05.ngrok.io/api/AvaliarPaciente");

            var resposta = client.PostAsync(client.BaseAddress.ToString(), content).Result;
            string responseBody = await resposta.Content.ReadAsStringAsync();
            return responseBody;
        }
    }
}
