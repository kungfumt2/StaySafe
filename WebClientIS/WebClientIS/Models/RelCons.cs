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
    public class RelCons
    {
        public DateTime DataRel { get; set; }

        public int IdU { get; set; }

        public int IdC { get; set; }

        public RelCons()
        {
            DataRel = new DateTime();
            IdU = 0;
            IdC = 0;
        }


        public List<RelCons> GetRelCons(int idu)
        {
            List<RelCons> lista = new List<RelCons>();

            HttpClient client = new HttpClient();

            client.BaseAddress = new Uri("http://6f85a52b4f05.ngrok.io/api/RelCons/" + idu.ToString());

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
                        lista.Add(obj.ToObject<RelCons>());
                    }
                    catch (Exception ex)
                    {
                        return new List<RelCons>();
                    }
                }

            }

            return lista;
        }

        public bool CreateRelCons(RelCons relcons)
        {
            HttpClient client = new HttpClient();

            var values = new Dictionary<string, string>
            {
                { "DataRel", relcons.DataRel.ToString() },
                {"IdU",relcons.IdU.ToString() },
                {"IdC",relcons.IdC.ToString() }


            };

            client.BaseAddress = new Uri("http://6f85a52b4f05.ngrok.io/api/RelCons");

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
