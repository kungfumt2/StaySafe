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
    public class Localizacao
    {
        public int IdC { get; set; }

        public string Latitude { get; set; }

        public string Longitude { get; set; }

        public bool Validado { get; set; }


        public Localizacao()
        {
            IdC = 0;
            Latitude ="";
            Longitude = "";
            Validado = false;
        }


        public Localizacao GetLocalizacoes(int idc)
        {
            Localizacao lista = new Localizacao();

            HttpClient client = new HttpClient();

            client.BaseAddress = new Uri("http://6f85a52b4f05.ngrok.io/api/Localizacao/" + idc.ToString());

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
                        lista=(obj.ToObject<Localizacao>());
                    }
                    catch (Exception ex)
                    {
                        return new Localizacao();
                    }
                }

            }

            return lista;
        }

        public bool CreateLocalizacao()
        {
            HttpClient client = new HttpClient();

            var values = new Dictionary<string, string>
            {
                { "IdC", IdC.ToString() },
                { "Latitude", Latitude.ToString() },
                { "Longitude", Longitude.ToString() },
                { "Validado", Validado.ToString() }
               
            };

            client.BaseAddress = new Uri("http://6f85a52b4f05.ngrok.io/api/Localizacao");

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

        public bool UpdateLocalizacao(int idc, bool val)
        {
            HttpClient client = new HttpClient();

            client.BaseAddress = new Uri("http://6f85a52b4f05.ngrok.io/api/Localizacao/" + idc.ToString());

            var jsonString = JsonConvert.SerializeObject(val.ToString());
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
