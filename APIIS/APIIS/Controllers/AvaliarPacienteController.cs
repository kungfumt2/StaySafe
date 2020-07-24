using APIIS.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Linq;

namespace APIIS.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AvaliarPacienteController : ControllerBase
    {
        private readonly IConfiguration configuration;

        public AvaliarPacienteController(IConfiguration cofig)
        {
            this.configuration = cofig;
        }

        // GET: api/AvaliarPaciente
        [HttpGet]
        public ActionResult Get()
        {
            return Ok();
        }

        // GET: api/AvaliarPaciente/5
        [HttpGet("{id}")]
        public ActionResult Get(int id)
        {
            return NoContent();
        }

        // POST: api/AvaliarPaciente
        [HttpPost]
        public ActionResult Post([FromBody] List<string> values)
        {
            try
            {
                int pont = 0;
                bool medicado = false;
                bool risco = false;
                string avaliacao = string.Empty;

                Utilizador user = new Utilizador();
                Paciente pac = new Paciente();

                pac = pac.GetPacientes(configuration.GetConnectionString("CSPaciente"), "IDU", Convert.ToInt32(values.First()), string.Empty).ToList().FirstOrDefault();


                avaliacao = pac.Estado;

                values.Remove(values.First());

                foreach (string v in values)
                {
                    if(v.Split(':')[0].Equals("Medicacao"))
                    {
                        pont += 5;
                        medicado = true;
                    }
                    else if(v.Split(':')[0].Equals("Sintomas"))
                    {
                        switch (v.Split(':')[2])
                        {
                            case "SIM":
                                if (medicado)
                                {
                                    pont += 5;
                                }
                                else
                                {
                                    pont += 10;
                                }

                                break;
                            case "NÃO":
                                pont += 0;
                                break;
                        }
                    }
                    else if(v.Split(':')[0].Equals("Contacto"))
                    {
                        switch (v.Split(':')[1])
                        {
                            case "Direto":

                                pont += 15;

                                break;
                            case "Indireto":
                                pont += 5;
                                break;
                        }
                    }
                    else if (v.Split(':')[0].Equals("Viagem"))
                    {
                        switch (v.Split(':')[1])
                        {
                            case "China":
                                if (v.Split(':')[2].Equals("SIM"))
                                {
                                    pont += 15;
                                }

                                break;
                            case "EUA":
                                if (v.Split(':')[2].Equals("SIM"))
                                {
                                    pont += 10;
                                }
                                break;
                            case "Espanha":
                                if (v.Split(':')[2].Equals("SIM"))
                                {
                                    pont += 10;
                                }
                                break;

                        }
                    }
                    else if (v.Split(':')[0].Equals("FR"))
                    {
                        switch (v.Split(':')[2])
                        {
                            case "SIM":

                                risco = true;

                                break;
                            
                        }
                    }
                     
                }

                if(!pac.Estado.Equals("Imune") && !pac.Estado.Equals("Infetado"))
                {
                    if(pont < 20)
                    {
                        avaliacao = "Não infetado";
                    }
                    else
                    {
                        avaliacao = "Risco";
                    }
                }

                return Ok(avaliacao);
            }
            catch(Exception ex)
            {
                return BadRequest();
            }
        }

        // PUT: api/AvaliarPaciente/5
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
