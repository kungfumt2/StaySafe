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
    public class Conselho
    {
        public int IdConselho { get; set; }

        public string Nome { get; set; }

        public int IdDist { get; set; }


        public Conselho()
        {
            IdConselho = 0;
            Nome = string.Empty;
            IdDist = 0;
        }

       

        public List<Conselho> GetConselho(string what,int id)
        {
            List<Conselho> lista = new List<Conselho>();

            HttpClient client = new HttpClient();

            client.BaseAddress = new Uri("http://6f85a52b4f05.ngrok.io/api/Conselho/"+what+"/"+id.ToString());

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
                        lista.Add(obj.ToObject<Conselho>());
                    }
                    catch (Exception ex)
                    {
                        return new List<Conselho>();
                    }
                }

            }

            return lista;
        }
        public List<Conselho> GetConselhos()
        {
            List<Conselho> lista = new List<Conselho>();

            HttpClient client = new HttpClient();

            client.BaseAddress = new Uri("http://6f85a52b4f05.ngrok.io/api/Conselho/" );

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
                        lista.Add(obj.ToObject<Conselho>());
                    }
                    catch (Exception ex)
                    {
                        return new List<Conselho>();
                    }
                }

            }

            return lista;
        }
        public bool CreateConselho(Conselho dis)
        {
            HttpClient client = new HttpClient();

            var values = new Dictionary<string, string>
            {
                { "IdConselho", dis.IdConselho.ToString() },
                { "Nome", dis.Nome },
                { "IdDist", dis.IdDist.ToString() }

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
    }
}
