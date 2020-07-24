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
    public class SintomasController : ControllerBase
    {
        private readonly IConfiguration configuration;

        public SintomasController(IConfiguration cofig)
        {
            this.configuration = cofig;
        }

        // GET: api/Sintomas
        [HttpGet]
        public ActionResult Get()
        {
            try
            {
                Sintomas sint = new Sintomas();

                return Ok(sint.GetSintomas(configuration.GetConnectionString("CSPaciente")).ToList());

            }
            catch(Exception ex)
            {
                return Forbid();
            }
        }

        // GET: api/Sintomas/5
        [HttpGet("{id}")]
        public ActionResult Get(int id)
        {
            return BadRequest();
        }

        // POST: api/Sintomas
        [HttpPost]
        public ActionResult Post([FromBody] Sintomas value)
        {
            try
            {
                 value.CreateSintomas(configuration.GetConnectionString("CSAdministrador"),value);
                return Ok();
            }
            catch(Exception ex)
            {
                return Forbid();
            }
        }

        // PUT: api/Sintomas/5
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
