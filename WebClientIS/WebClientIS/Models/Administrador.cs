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
    public class Administrador
    {
        public int Id { get; set; }

        public string Username { get; set; }

        public string Password { get; set; }

        public Administrador()
        {
            Id = 0;
            Username = string.Empty;
            Password = string.Empty;

        }

        

        public Administrador GetAdministrador(string usern)
        {
            Administrador admin = new Administrador();

            HttpClient client = new HttpClient();

            client.BaseAddress = new Uri("http://6f85a52b4f05.ngrok.io/api/Administrador/" + usern);

            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));

            HttpResponseMessage response = client.GetAsync("").Result;

            if (response.IsSuccessStatusCode)
            {
                var products = response.Content.ReadAsStringAsync().Result;

                var array = JArray.Parse(products);

                
                    try
                    {
                      admin = array[0].ToObject<Administrador>();
                    }
                    catch (Exception ex)
                    {
                        return new Administrador();
                    }
                

            }

            return admin;
        }

        public bool CreateAdministrador(Administrador admin)
        {
            HttpClient client = new HttpClient();

            var values = new Dictionary<string, string>
            {
                { "Id", admin.Id.ToString() },
                { "Username", admin.Username },
                { "Password", admin.Password }

            };

            client.BaseAddress = new Uri("http://6f85a52b4f05.ngrok.io/api/Administrador");

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
