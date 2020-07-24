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
    public class FatoresDeRisco
    {
        public int Id { get; set; }

        public string Fator { get; set; }

        
        public FatoresDeRisco()
        {
            Id = 0;
            Fator = string.Empty;
        }



        public List<FatoresDeRisco> GetFatoresDeRiscos()
        {
            List<FatoresDeRisco> fact = new List<FatoresDeRisco>();

            HttpClient client = new HttpClient();

            client.BaseAddress = new Uri("http://6f85a52b4f05.ngrok.io/api/FatoresDeRisco");

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
                        fact.Add(obj.ToObject<FatoresDeRisco>());
                    }
                    catch (Exception ex)
                    {
                        return new List<FatoresDeRisco>();
                    }
                }

            }

            return fact;

        }

        public bool CreateFatoresDeRisco(FatoresDeRisco fatores)
        {
            HttpClient client = new HttpClient();

            var values = new Dictionary<string, string>
            {
                { "Id", fatores.Id.ToString() },
                { "Fator", fatores.Fator }
                

            };

            client.BaseAddress = new Uri("http://6f85a52b4f05.ngrok.io/api/FatoresDeRisco");

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
