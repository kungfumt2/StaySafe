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
    public class RelFact
    {
        public int IdF { get; set; }

        public int IdP { get; set; }

        public string Tempo { get; set; }

        public RelFact()
        {
            IdF = 0;
            IdP = 0;
            Tempo = string.Empty;
        }

        

        public List<RelFact> GetRelFacts(int idp)
        {
            List<RelFact> lista = new List<RelFact>();

            HttpClient client = new HttpClient();

            client.BaseAddress = new Uri("http://6f85a52b4f05.ngrok.io/api/RelFact/" + idp.ToString());

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
                        lista.Add(obj.ToObject<RelFact>());
                    }
                    catch (Exception ex)
                    {
                        return new List<RelFact>();
                    }
                }

            }

            return lista;
        }

        public bool CreateRelFact()
        {
            HttpClient client = new HttpClient();

            var values = new Dictionary<string, string>
            {
                { "IdF", IdF.ToString() },
                {"IdP",IdP.ToString() },
                {"Tempo",Tempo }


            };

            client.BaseAddress = new Uri("http://6f85a52b4f05.ngrok.io/api/RelFact");

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
