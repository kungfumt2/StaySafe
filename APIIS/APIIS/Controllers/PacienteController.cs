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
    public class PacienteController : ControllerBase
    {
        private readonly IConfiguration configuration;

        public PacienteController(IConfiguration cofig)
        {
            this.configuration = cofig;
        }

        // GET: api/Paciente
        [HttpGet]
        public ActionResult Get()
        {
            Paciente pac = new Paciente();

            try
            {

                return Ok(pac.GetPacientes(configuration.GetConnectionString("CSPaciente"),string.Empty,0,string.Empty).ToList());
            }
            catch(Exception ex)
            {
                return Forbid();
            }
        }

        // GET: api/Paciente/5
        [HttpGet("{idu}/{what}/{value}")]
        public ActionResult Get([FromQuery]int idu, [FromQuery]string what, [FromQuery]string value)
        {
            Paciente pac = new Paciente();
            List<Paciente> lista = new List<Paciente>();

            try
            {
                switch (what)
                {
                    case "IDU":

                        lista = pac.GetPacientes(configuration.GetConnectionString("CSPaciente"), "IDU", idu, string.Empty).ToList();
                        break;

                    case "CodigoPac":
                        lista = pac.GetPacientes(configuration.GetConnectionString("CSPaciente"), "CodigoPac", 0, value).ToList();
                        break;

                    case "Sexo":
                        lista = pac.GetPacientes(configuration.GetConnectionString("CSPaciente"), "Sexo", 0, value).ToList();
                        break;

                    case "Estado":
                        lista = pac.GetPacientes(configuration.GetConnectionString("CSPaciente"), "Estado", 0, value).ToList();
                        break;

                    case "Risco":
                        lista = pac.GetPacientes(configuration.GetConnectionString("CSPaciente"), "Risco", 0, value).ToList();
                        break;

                    case "Nao Risco":
                        lista = pac.GetPacientes(configuration.GetConnectionString("CSPaciente"), "Nao Risco", 0, value).ToList();
                        break;

                    case "CodigoPostal":
                        lista = pac.GetPacientes(configuration.GetConnectionString("CSPaciente"), "CodigoPostal", 0, value).ToList();
                        break;

                }
                
                
               
                return Ok(lista);
            }
            catch(Exception ex)
            {
                return Forbid();
            }
        }

        // POST: api/Paciente
        [HttpPost]
        public ActionResult Post([FromBody] Paciente value)
        {
            try
            {
                Paciente pac = new Paciente();

                Random random = new Random();

                const string chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

                string code = new string(Enumerable.Repeat(chars, 7).Select(s => s[random.Next(s.Length)]).ToArray());

                value.CodigoPac = code;

                pac.CreatePaciente(configuration.GetConnectionString("CSAnonimo"), value);

                return Ok();
            }
            catch(Exception ex)
            {
                return Forbid();
            }
        }

        // PUT: api/Paciente/5
        [HttpPut("{idu}")]
        public ActionResult Put(int idu,[FromBody] string value)
        {
            try
            {
                Paciente pac = new Paciente();
                     
                    
                 pac.UpdatePacienteEstado(configuration.GetConnectionString("CSAdministrador"), "Estado", value, false, idu);
                        
                 
                return Ok();
            }
            catch(Exception e)
            {
                return Forbid();
            }
        }

        // DELETE: api/ApiWithActions/5
        [HttpDelete("{id}")]
        public void Delete(int id)
        {
        }
    }
}
