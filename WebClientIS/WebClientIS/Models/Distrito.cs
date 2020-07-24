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
    public class Distrito
    {
        public int IdD { get; set; }

        public string Nome { get; set; }

        public Distrito()
        {
            IdD = 0;
            Nome = string.Empty;
        }

        

        public List<Distrito> GetDistritos()
        {
            List<Distrito> lista = new List<Distrito>();

            HttpClient client = new HttpClient();

            client.BaseAddress = new Uri("http://6f85a52b4f05.ngrok.io/api/Distrito");

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
                        lista.Add(obj.ToObject<Distrito>());
                    }
                    catch (Exception ex)
                    {
                        return new List<Distrito>();
                    }
                }

            }

            return lista;
        }

        public bool CreateDistrito(Distrito dis)
        {
            HttpClient client = new HttpClient();

            var values = new Dictionary<string, string>
            {
                { "IdD", dis.IdD.ToString() },
                { "Nome", dis.Nome }


            };

            client.BaseAddress = new Uri("http://6f85a52b4f05.ngrok.io/api/Distrito");

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
