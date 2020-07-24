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
    public class Sintomas
    {
        public int IDS { get; set; }

        public string Sintoma { get; set; }

        public Sintomas()
        {
            IDS = 0;
            Sintoma = string.Empty;
        }


        public List<Sintomas> GetSintomas()
        {
            List<Sintomas> lista = new List<Sintomas>();

            HttpClient client = new HttpClient();

            client.BaseAddress = new Uri("http://6f85a52b4f05.ngrok.io/api/Sintomas");

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
                        lista.Add(obj.ToObject<Sintomas>());
                    }
                    catch (Exception ex)
                    {
                        return new List<Sintomas>();
                    }
                }

            }

            return lista;
        }

        public bool CreateSintomas(string strc, Sintomas sint)
        {
            HttpClient client = new HttpClient();

            var values = new Dictionary<string, string>
            {
                { "IDS", sint.IDS.ToString() },
                {"Sintoma",sint.Sintoma }
                

            };

            client.BaseAddress = new Uri("http://6f85a52b4f05.ngrok.io/api/Sintomas");

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
    }
}
