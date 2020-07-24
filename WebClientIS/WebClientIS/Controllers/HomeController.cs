using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using APIIS.Models;
using Microsoft.AspNetCore.Mvc;
using WebClientIS.Models;
using Newtonsoft.Json;
using RabbitMQ.Client;
using RabbitMQ.Client.Events;

using System.Net;
using Newtonsoft.Json;

using System.Configuration;

using System.Text;
using System.Data;
using System.Web;
using Microsoft.AspNetCore.Http;
using Nancy.Json;
using Microsoft.VisualStudio.Web.CodeGeneration.Contracts.Messaging;
using Microsoft.Extensions.WebEncoders.Testing;

namespace WebClientIS.Controllers
{
    public class HomeController : Controller
    {
        public static int UserId = 0; // Modifiable
        public static List<String> lista = new List<string>();
        public static List<String> respostas = new List<string>();
        public IActionResult Index()
        {if (HomeController.UserId == 0)
            {
                return RedirectToAction("Loggin", "Home");
                    }
            
            return View();
        }
        [HttpGet]
        public IActionResult FatorRisco()
        { return View(); }

        [HttpGet]
        public IActionResult Maps()
        {


            return View();
        }
        public JsonResult GetLocation()
        {
            Localizacao l = new Localizacao();
            l=l.GetLocalizacoes(UserId);
            JavaScriptSerializer jss = new JavaScriptSerializer();
            return Json(jss.Serialize(l));
        }
        [HttpPost]
        public IActionResult Maps(string latitude, string longitude)
        {
            Localizacao loc = new Localizacao();

            loc.IdC = UserId;
            loc.Latitude = (latitude);
            loc.Longitude = (longitude);

            loc.Validado = true;
            loc.CreateLocalizacao();
            return RedirectToAction("Intro", "Home");
        }
        [HttpPost]
        public async Task<IActionResult> FatorRisco(string tabagismo, string hiper, string diabetes, string colestrol)
        {
            List<RelFact> fatores = new List<RelFact>();
            if (string.IsNullOrEmpty(tabagismo))
            {
                respostas.Add("FR:Tabagismo:NÃO");
            }

            else { RelFact rf = new RelFact();
                    rf.IdP = UserId;
                    rf.Tempo = DateTime.Now.ToString();
                    rf.IdF = 1;
                    respostas.Add("FR:Tabagismo:SIM");
                fatores.Add(rf);
            }
            if (string.IsNullOrEmpty(hiper))
            {
                respostas.Add("FR:Hipertenção:NÃO");
            }

            else
            {
                RelFact rf = new RelFact();
                rf.IdP = UserId;
                rf.Tempo = DateTime.Now.ToString();
                rf.IdF = 2;
                respostas.Add("FR:Hipertenção:SIM");
                fatores.Add(rf);
            }

        
            if (string.IsNullOrEmpty(diabetes))
            {
                respostas.Add("FR:Diabetes:NÃO");
            }

            else
            {
                RelFact rf = new RelFact();
                rf.IdP = UserId;
                rf.Tempo = DateTime.Now.ToString();
                rf.IdF = 3;
                respostas.Add("FR:Diabetes:SIM"); fatores.Add(rf);
            

        }
            if (string.IsNullOrEmpty(colestrol))
            {
                respostas.Add("FR:Colestrol/Triglicerideos:NÃO");
            }

            else
            {
                RelFact rf = new RelFact();
                rf.IdP = UserId;
                rf.Tempo = DateTime.Now.ToString();
                rf.IdF = 4;
                respostas.Add("FR:Colestrol/Triglicerideos:SIM");
                fatores.Add(rf);

            }
           foreach(RelFact r in fatores)
            { r.CreateRelFact(); }
            Utilizador user = new Utilizador();
           
            Paciente p = new Paciente();
            p.UpdatePacienteEstado(UserId, await user.avaliarUtilizador(respostas));

            respostas.RemoveAt(0);
            return RedirectToAction("Resultados", "Home");
            }
        [HttpGet]
        public IActionResult Intro()
        {
            respostas.Clear();
            lista.Clear();
            return View(); }
        [HttpPost]
        public IActionResult Intro(string medico, string contato, string viagem)
        {if(medico == "cenas")
            { return RedirectToAction("Intro", "Home"); }
            lista.Add(medico);
            lista.Add(contato);
            lista.Add(viagem);
            if (medico == "sim")
            {
                return RedirectToAction("MedicoQuest", "Home");
            }
            else if (contato == "sim")
            { return RedirectToAction("SintomasQuest", "Home"); }
            else if (viagem == "sim")
            { return RedirectToAction("ViagemQuest", "Home"); }

            return RedirectToAction("FatorRisco", "Home");


        }
        [HttpGet]
        public IActionResult Loggin()
        { return View(); }
        [HttpPost]
        public async Task<IActionResult> Loggin(string username, string password)
        {
            Login l = new Login();
            l.Email = username;
            l.Password = password;
           UserId= Convert.ToInt32((await l.makelogginAsync())[0]);
                return RedirectToAction("Index", "Home");
        }
        [HttpGet]
        public IActionResult Registar()
        {
            Utilizador u = new Utilizador();
            return View(u);
        }
        [HttpPost]
        public async Task<IActionResult> RegistarAsync(Utilizador model, IFormFile ctlFile)
        {

            using (var ms = new MemoryStream())
            {
                ctlFile.CopyTo(ms);
                model.Fotografia = ms.ToArray();

                // act on the Base64 data
            }
   
            model.Tipo = "Paciente";
            model.Id = 0;
            UserId = await model.CreateUtilizadorAsync();

            return RedirectToAction("RegistarPaciente", "Home");
        }
        [HttpGet]
        public IActionResult MedicoQuest()
        {
            Utilizador u = new Utilizador();
            return View(u);
        }
        [HttpPost]
        public IActionResult MedicoQuest(string estado, string medicacao)
        {
            Paciente user = new Paciente();


            user.UpdatePacienteEstado(UserId, estado);

            if (medicacao == "medicado")
            {
                respostas.Add("Medicacao:SIM");
            }
            

            if (lista[1] == "sim")
            { return RedirectToAction("SintomasQuest", "Home"); }
            else if (lista[2] == "sim")
            { return RedirectToAction("ViagemQuest", "Home"); }
            return RedirectToAction("FatorRisco", "Home");
        }
        public IActionResult SintomasQuest()
        {

            return View();
        }
        [HttpPost]
        public IActionResult SintomasQuest(string contacto, string corrimento, string cansaco, string diarreia, string cnasal)
        {
            List<RelSin> Sintomas = new List<RelSin>();
            
            if (contacto == "Sim")
            {
                RelSin sintoma = new RelSin();
                sintoma.IdP = UserId;
                sintoma.IdS = 5;
                sintoma.DataSintoma = DateTime.Now;
                Sintomas.Add(sintoma);
                respostas.Add("Sintomas:Contacto:Direto");
            }
            else { respostas.Add("Sintomas:Contacto:Indireto"); }

            if (corrimento == "Sim")
            {
                RelSin sintoma = new RelSin();
                sintoma.IdP = UserId;
                sintoma.IdS = 1;
                sintoma.DataSintoma = DateTime.Now;
                Sintomas.Add(sintoma);
                respostas.Add("Sintomas:Corriento:SIM");
            }
            else { respostas.Add("Sintomas:Corriento:NÃO"); }
            if (cansaco == "Sim")
            {
                RelSin sintoma = new RelSin();
                sintoma.IdP = UserId;
                sintoma.IdS = 2;

                sintoma.DataSintoma = DateTime.Now;
                Sintomas.Add(sintoma);
                respostas.Add("Sintomas:Cansaço:SIM");
            }
            else { respostas.Add("Sintomas:Cansaço:NÃO"); }
            if (diarreia == "Sim")
            {
                RelSin sintoma = new RelSin();
                sintoma.IdP = UserId;
                sintoma.IdS = 3;
                sintoma.DataSintoma = DateTime.Now;
                Sintomas.Add(sintoma);
                respostas.Add("Sintomas:Diarreia:SIM");
            }
            else { respostas.Add("Sintomas:Diarreia:NÃO"); }
            if (cnasal == "Sim")
            {
                RelSin sintoma = new RelSin();
                sintoma.IdP = UserId;
                sintoma.IdS = 4;
                sintoma.DataSintoma = DateTime.Now;
                Sintomas.Add(sintoma);
                respostas.Add("Sintomas:Congestão:SIM");
            }
            else { respostas.Add("Sintomas:Congestão:NÃO"); }
          
           foreach (RelSin s in Sintomas)
            { s.CreateRelSin(); }
            if (lista[2] == "sim")
            { return RedirectToAction("ViagemQuest", "Home"); }

            return RedirectToAction("FatorRisco", "Home");
        }
        public IActionResult ViagemQuest()
        {

            return View();
        }
        [HttpPost]
        public IActionResult ViagemQuest(string china, string eua, string espanha, string italia)
        {


            if (china == "Sim")
            {
                
                respostas.Add("Viagem:China:SIM");
            }
            else { respostas.Add("Viagem:China:NÃO"); }

            if (eua== "Sim")
            {

                respostas.Add("Viagem:EUA:SIM");
            }
            else { respostas.Add("Viagem:EUA:NÃO"); }
            if (espanha== "Sim")
            {

                respostas.Add("Viagem:Espanha:SIM");
            }
            else { respostas.Add("Viagem:Espanha:NÃO"); }
            if (italia == "Sim")
            {

                respostas.Add("Viagem:Italia:SIM");
            }
            else { respostas.Add("Viagem:Italia:NÃO"); }
   

            return RedirectToAction("FatorRisco", "Home");
        }
        public IActionResult RegistarPaciente()
        {
            Paciente model = new Paciente();
            model.IDU = UserId;
            model.Idade = 0;
            return View(model);
        }
        [HttpPost]
        public IActionResult RegistarPaciente(Paciente model)
        {
            model.CodigoPac = "";
            model.Estado = "Nao Infetado";
            model.Risco = false;
            model.CreatePaciente();
            UserId = model.IDU;
            respostas.Add(UserId.ToString());
            return RedirectToAction("Maps", "Home");
        }
        [HttpGet]

        public IActionResult Resultados()
        {
            Paciente model = new Paciente();
            model.IDU = UserId;
            model.Idade = 0;
            return View(model);
        }
        [HttpPost]
        public IActionResult Resultados(int y)
        {
            Paciente p = new Paciente();
            p = p.GetPacientes().Where(x=>x.IDU==UserId).First();
            var factory = new ConnectionFactory() { HostName = "localhost" };
            using (var connection = factory.CreateConnection())
            using (var channel = connection.CreateModel())
            {
                channel.QueueDeclare(queue: "WO",
                                     durable: false,
                                     exclusive: false,
                                     autoDelete: false,
                                     arguments: null);

                string message = "Novo Caso "+""  + p.Estado;
                var body = Encoding.UTF8.GetBytes(message);

                channel.BasicPublish(exchange: "",
                                     routingKey: "WO",
                                     basicProperties: null,
                                     body: body);

            }

             return RedirectToAction("Index", "Home");
        }
     
    }

}

