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
    public class RelFactController : ControllerBase
    {
        private readonly IConfiguration configuration;

        public RelFactController(IConfiguration cofig)
        {
            this.configuration = cofig;
        }

        // GET: api/RelFact
        [HttpGet]
        public ActionResult Get()
        {
            try
            {
                RelFact relFact = new RelFact();

                return Ok(relFact.GetRelFacts(configuration.GetConnectionString("CSPaciente"), 0).ToList());

            }
            catch(Exception ex)
            {
                return Forbid();
            }
        }

        // GET: api/RelFact/5
        [HttpGet("{idp}")]
        public ActionResult Get(int idp)
        {
            try
            {

                RelFact relFact = new RelFact();

                return Ok(relFact.GetRelFacts(configuration.GetConnectionString("CSPaciente"), idp).ToList());

            }
            catch (Exception ex)
            {
                return Forbid();
            }
        }

        // POST: api/RelFact
        [HttpPost]
        public ActionResult Post([FromBody] RelFact values)
        {
            try
            {

              
                    values.CreateRelFact(configuration.GetConnectionString("CSPaciente"), values);
                

                return Ok();
            }
            catch(Exception ex)
            {
                return Forbid();
            }
        }

        // PUT: api/RelFact/5
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
