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
    public class DistritoController : ControllerBase
    {
        private readonly IConfiguration configuration;

        public DistritoController(IConfiguration cofig)
        {
            this.configuration = cofig;
        }

        // GET: api/Distrito
        [HttpGet]
        public ActionResult Get()
        {
            try
            {
                Distrito dist = new Distrito();

                return Ok(dist.GetDistritos(configuration.GetConnectionString("CSPaciente")).ToList());

            }
            catch(Exception ex)
            {
                return Forbid();
            }
        }

        // GET: api/Distrito/5
        [HttpGet("{id}")]
        public string Get(int id)
        {
            return "value";
        }

        // POST: api/Distrito
        [HttpPost]
        public ActionResult Post([FromBody] Distrito value)
        {
            try
            {
                value.CreateDistrito(configuration.GetConnectionString("CSAdministrador"), value);

                return Ok();
            }
            catch(Exception ex)
            {
                return Forbid();
            }
        }

        // PUT: api/Distrito/5
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
