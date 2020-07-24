using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Threading.Tasks;

namespace WebClientIS.Models
{
    public class casos
    {
        public int ninfet;
        public int nrisco;
        public int nninft;
        public int nimunes;
        public casos Getcasos(int idd)
        {
            casos caso = new casos();

            HttpClient client = new HttpClient();

            client.BaseAddress = new Uri("http://6f85a52b4f05.ngrok.io/api/MainView/" );


           

            var jsonString = JsonConvert.SerializeObject(idd.ToString());
            var content = new StringContent(jsonString, Encoding.UTF8, "application/json");

            var resposta = client.PostAsync(client.BaseAddress.ToString(), content).Result;


   


            var products = resposta.Content.ReadAsStringAsync().Result;



            //string responseBody = await response.Content.ReadAsStringAsync();
            //JObject json = JObject.Parse(responseBody);
            caso = JsonConvert.DeserializeObject<casos>(products);






            return caso;
        }
    }
}
