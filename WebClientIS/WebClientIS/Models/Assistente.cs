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

namespace APIIS.Models
{
    public class Assistente
    {
        public int IDU { get; set; }

        public string Tipo { get; set; }

        public string Cargo { get; set; }

        public Assistente()
        {
            IDU = 0;
            Tipo = string.Empty;
            Cargo = string.Empty;
        }


        public List<Assistente> GetAssistentes(int idu, string what, string type, string car)
        {
            List<Assistente> assistentes = new List<Assistente>();

            HttpClient client = new HttpClient();

            client.BaseAddress = new Uri("http://6f85a52b4f05.ngrok.io/api/Assistente/" + idu.ToString() + "/" + what + "/" + type + "/" + car);

            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));

            HttpResponseMessage response = client.GetAsync("").Result;

            if (response.IsSuccessStatusCode)
            {
                var products = response.Content.ReadAsStringAsync().Result;

                var array = JArray.Parse(products);

                foreach (var obj in array)
                {
                    try
                    {
                        assistentes.Add(obj.ToObject<Assistente>());
                    }
                    catch (Exception ex)
                    {
                        return new List<Assistente>();
                    }
                }

            }


            return assistentes;
        }

        public bool CreateAssistente(Assistente assis)
        {
            HttpClient client = new HttpClient();

            var values = new Dictionary<string, string>
            {
                { "IDU", assis.IDU.ToString() },
                { "Tipo", assis.Tipo },
                { "Cargo", assis.Cargo }

            };

            client.BaseAddress = new Uri("http://6f85a52b4f05.ngrok.io/api/Conselho");

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

        public bool UpdateAssistente(int idu, string what, string value)
        {
            HttpClient client = new HttpClient();

            client.BaseAddress = new Uri("http://6f85a52b4f05.ngrok.io/api/Localizacao/" + idu.ToString() + "/" + what);

            var jsonString = JsonConvert.SerializeObject(value);
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
