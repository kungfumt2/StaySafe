using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using APIIS.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;

namespace APIIS.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class MainViewController : ControllerBase
    {
        private readonly IConfiguration configuration;

        public MainViewController(IConfiguration cofig)
        {
            this.configuration = cofig;
        }

        // GET: api/MainView
        [HttpGet]
        public ActionResult Get()
        {
            return BadRequest();
        }

        // GET: api/MainView/5
        [HttpGet("{id}")]
        public string Get(int id)
        {
            return "value";
        }

        // POST: api/MainView
        [HttpPost]
        public ActionResult Post([FromBody] string iduser)
        {
            try
            {
                Paciente user = new Paciente();

                int ninfet = 0;
                int nimunes = 0;
                int nrisco = 0;
                int nninft = 0;

                Localizacao loc = new Localizacao();

                loc = loc.GetLocalizacoes(configuration.GetConnectionString("CSPaciente"), Convert.ToInt32(iduser)).FirstOrDefault();

                foreach (Localizacao l in loc.GetLocalizacoes(configuration.GetConnectionString("CSPaciente"), 0))
                {
                    if (l.IdC != loc.IdC)
                    {
                        var R = 6371; // Raio da terra
                        var dLat = (l.Latitude - loc.Latitude) * (Math.PI / 180);
                        var dLon = (l.Longitude - loc.Longitude) * (Math.PI / 180);
                        var a =
                            Math.Sin(dLat / 2) * Math.Sin(dLat / 2) +
                            Math.Cos((loc.Latitude) * (Math.PI / 180)) * Math.Cos(l.Latitude * (Math.PI / 180)) *
                            Math.Sin(dLon / 2) * Math.Sin(dLon / 2);

                        var c = 2 * Math.Atan2(Math.Sqrt(a), Math.Sqrt(1 - a));
                        var d = R * c; // Distancia in km


                        if (d < 10)
                        {
                            user = user.GetPacientes(configuration.GetConnectionString("CSPaciente"), "IDU", l.IdC, string.Empty).First();

                            switch (user.Estado)
                            {
                                case "Infetado":
                                    ninfet++;
                                    break;

                                case "Risco":
                                    nrisco++;
                                    break;

                                case "Nao Infetado":
                                    nninft++;
                                    break;

                                case "Imune":
                                    nimunes++;
                                    break;


                            }
                        }

                    }
                }

                Dictionary<string, object> response = new Dictionary<string,object>();

                response.Add("ninfet", ninfet.ToString());
                response.Add("nrisco", nrisco.ToString());
                response.Add("nninft", nninft.ToString());
                response.Add("nimunes", nimunes.ToString());

                return Ok(response);
            }
            catch(Exception ex)
            {
                return NoContent();
            }

        }

        // PUT: api/MainView/5
        [HttpPut("{id}")]
        public void Put(int id, [FromBody] string value)
        {
        }

        // DELETE: api/ApiWithActions/5
        [HttpDelete("{id}")]
        public void Delete(int id)
        {
        }
    }
}
