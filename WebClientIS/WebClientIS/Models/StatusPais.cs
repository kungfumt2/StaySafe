using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Threading.Tasks;
using System.Web.Helpers;

namespace WebClientIS.Models
{
    public class StatusPais
    {
        public String Country { get; set; }
        public int NewConfirmed { get; set; }
        public int TotalConfirmed { get; set; }
        public int NewDeaths { get; set; }
        public int TotalDeaths { get; set; }
        public int NewRecovered { get; set; }
        public int TotalRecovered { get; set; }
        public DateTime Date { get; set; }

        //public StatusPais ()
        // {
        //         Country = "";
        //     NewConfirmed = 0;
        //     totalconf = 0;
        //     novasmortes = 0;
        //     mortestotal = 0;
        //     novosrecup= 0;
        //     totalrecup = 0;
        //     dataatualizacao = DateTime.Now;
        //}
        public StatusPais GetPais()
        {
            List<StatusPais> lista = new List<StatusPais>();

            HttpClient client = new HttpClient();

            client.BaseAddress = new Uri("https://api.covid19api.com/summary");

            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));

            HttpResponseMessage response = client.GetAsync("").Result;

            var products = response.Content.ReadAsStringAsync().Result;



            var data = (JObject)JsonConvert.DeserializeObject(products);


            lista = JsonConvert.DeserializeObject<List<StatusPais>>(data["Countries"].ToString());


            for (int i = 0; i < lista.Count; i++)
            {


                if (lista[i].Country == "Portugal")
                    return lista[i];
            }



            return null;
        }

    }
}
