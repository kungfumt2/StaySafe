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
    public class Relatorio
    {
        public DateTime DataRelatorio { get; set; }

        public int IdP { get; set; }

        public int IdA { get; set; }

        public byte[] Ficheiro { get; set; }


        public Relatorio()
        {
            DataRelatorio = new DateTime();
            IdP = 0;
            IdA = 0;
            Ficheiro = null;
        }

        

        public List<Relatorio> GetRelatorios(int id,string what, object value)
        {
            List<Relatorio> relatorios = new List<Relatorio>();

            HttpClient client = new HttpClient();

            client.BaseAddress = new Uri("http://6f85a52b4f05.ngrok.io/api/Relatorio/" + id.ToString() + "/"+what+"/"+value.ToString());

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
                        relatorios.Add(obj.ToObject<Relatorio>());
                    }
                    catch (Exception ex)
                    {
                        return new List<Relatorio>();
                    }
                }

            }

            return relatorios;
        }

        public bool CreateRelatorio(Relatorio rel)
        {
            HttpClient client = new HttpClient();

            var values = new Dictionary<string, string>
            {
                { "DataRelatorio", rel.DataRelatorio.ToString() },
                {"IdP",rel.IdP.ToString() },
                {"IdA",rel.IdA.ToString() },
                {"Ficheiro",rel.IdA.ToString() }


            };

            client.BaseAddress = new Uri("http://6f85a52b4f05.ngrok.io/api/Relatorio");

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
