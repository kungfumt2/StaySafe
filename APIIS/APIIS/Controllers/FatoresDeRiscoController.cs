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
    public class FatoresDeRiscoController : ControllerBase
    {
        private readonly IConfiguration configuration;

        public FatoresDeRiscoController(IConfiguration cofig)
        {
            this.configuration = cofig;
        }

        // GET: api/FatoresDeRisco
        [HttpGet]
        public ActionResult Get()
        {
            try
            {
                FatoresDeRisco risk = new FatoresDeRisco();

                return Ok(risk.GetFatoresDeRiscos(configuration.GetConnectionString("CSPaciente")).ToList());

            }
            catch (Exception ex)
            {
                return Forbid();
            }
        }

        // GET: api/FatoresDeRisco/5
        [HttpGet("{id}")]
        public ActionResult Get(int id)
        {
            return BadRequest();
        }

        // POST: api/FatoresDeRisco
        [HttpPost]
        public ActionResult Post([FromBody] FatoresDeRisco value)
        {
            try
            {

                value.CreateFatoresDeRisco(configuration.GetConnectionString("CSAdministrador"), value);

                return Ok();
            }
            catch(Exception ex)
            {
                return Forbid();
            }
        }

        // PUT: api/FatoresDeRisco/5
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
