using Nancy.Json;
using Nancy.Json.Simple;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using RestSharp;
using ServiceStack;
using ServiceStack.Text;
using System;

using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;

namespace WebClientIS.Models
{
    public class Login
    {
        public string Email { get; set; }
        public string Password { get; set; }

        public async Task<List<string>> makelogginAsync() { 
         List<string> l = new List<string>();
            HttpClient client = new HttpClient();

            var values = new Dictionary<string, string>
            {
                {"Password",Password },
                {"Email",Email },



            };
           


            client.BaseAddress = new Uri("http://6f85a52b4f05.ngrok.io/api/Login");

            var jsonString = JsonConvert.SerializeObject(this);
            //var jsonString = new JavaScriptSerializer().Serialize(this);

            var content = new StringContent(jsonString, Encoding.UTF8, "application/json");

            var resposta = client.PostAsync(client.BaseAddress.ToString(), content).Result;
            

            string responseBody = await resposta.Content.ReadAsStringAsync();
            JObject json = JObject.Parse(responseBody);
            l.Add(json["id"].ToString());
            l.Add(json["role"].ToString());
            return l;



        }

    }
}
