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
    public class Notificacao
    {public int Id { get; set; }
        public string mensagem { get; set; }
        public Notificacao()
        {


            Id = 0;
            mensagem = "";
        }
        public Notificacao GetNotificacao()
        {

            Notificacao n  = new Notificacao();

            HttpClient client = new HttpClient();

            client.BaseAddress = new Uri("http://6f85a52b4f05.ngrok.io/api/Notificacao");

            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));

            HttpResponseMessage response = client.GetAsync("").Result;

            var products = response.Content.ReadAsStringAsync().Result;



            //string responseBody = await response.Content.ReadAsStringAsync();
            //JObject json = JObject.Parse(responseBody);
           n = JsonConvert.DeserializeObject<Notificacao>(products);




            return n;

        }
    }
}
