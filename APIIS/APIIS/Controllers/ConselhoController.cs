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
    public class ConselhoController : ControllerBase
    {
        private readonly IConfiguration configuration;

        public ConselhoController(IConfiguration cofig)
        {
            this.configuration = cofig;
        }

        // GET: api/Conselho
        [HttpGet]
        public ActionResult Get()
        {
            try
            {
                Conselho cons = new Conselho();

                return Ok(cons.GetConselho(configuration.GetConnectionString("CSPaciente"), string.Empty, 0).ToList());
            }
            catch(Exception ex)
            {
                return Forbid();
            }
        }

        // GET: api/Conselho/5
        [HttpGet("{what}/{id}")]
        public ActionResult Get([FromQuery]string what, [FromQuery]int id)
        {
            try
            {
                Conselho cons = new Conselho();

                List<Conselho> lista = new List<Conselho>();

                switch(what)
                {
                    case "IdConselho":
                        lista = cons.GetConselho(configuration.GetConnectionString("CSPaciente"), what, id);
                        break;

                    case "IdDist":
                        lista = cons.GetConselho(configuration.GetConnectionString("CSPaciente"), what, id);
                        break;
                }

                if(lista.Count().Equals(0))
                {
                    lista = cons.GetConselho(configuration.GetConnectionString("CSPaciente"), string.Empty, 0).ToList();
                }

                return Ok(lista);
            }
            catch(Exception ex)
            {
                return Forbid();
            }
        }

        // POST: api/Conselho
        [HttpPost]
        public ActionResult Post([FromBody] Conselho value)
        {
            try
            {
                value.CreateConselho(configuration.GetConnectionString("CSPaciente"), value);

                return Ok();
            }
            catch(Exception ex)
            {
                return Forbid();
            }
        }

        // PUT: api/Conselho/5
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
