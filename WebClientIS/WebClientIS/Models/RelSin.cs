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
    public class RelSin
    {
        public int IdP { get; set; }

        public int IdS { get; set; }

        public DateTime DataSintoma { get; set; }

        public RelSin()
        {
            IdP = 0;
            IdS = 0;
            DataSintoma = new DateTime();

        }


        public List<RelSin> GetRelSins(int idp)
        {
            List<RelSin> lista = new List<RelSin>();

            HttpClient client = new HttpClient();

            client.BaseAddress = new Uri("http://6f85a52b4f05.ngrok.io/api/RelSin/"+idp.ToString());

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
                        lista.Add(obj.ToObject<RelSin>());
                    }
                    catch (Exception ex)
                    {
                        return new List<RelSin>();
                    }
                }

            }

            return lista;
        }

        public bool CreateRelSin()
        {
            HttpClient client = new HttpClient();

            var values = new Dictionary<string, object>
            {
                { "IdP", IdP.ToString() },
                {"IdS",IdS.ToString() },
                {"DataSintoma",DataSintoma }


            };

            client.BaseAddress = new Uri("http://6f85a52b4f05.ngrok.io/api/RelSin");

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
