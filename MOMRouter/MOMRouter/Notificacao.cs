using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;

namespace MOMRouter
{
    public class Notificacao
    {
       public int id { get; set; }
        public string message { get; set; }
        public Notificacao()
        {id = 0;
  message = "";
        }

        public async Task<int> CreateNotificacao()
        {
            HttpClient client = new HttpClient();

            var values = new Dictionary<string, object>
            {
                { "Id", id.ToString() },
                {"Mensagem",message },
          


            };

            client.BaseAddress = new Uri("http://6f85a52b4f05.ngrok.io/api/Notificacao");

            var jsonString = JsonConvert.SerializeObject(values);
            var content = new StringContent(jsonString, Encoding.UTF8, "application/json");

            var resposta = client.PostAsync(client.BaseAddress.ToString(), content).Result;



            string responseBody = await resposta.Content.ReadAsStringAsync();




            return 1;


        }
    }
}