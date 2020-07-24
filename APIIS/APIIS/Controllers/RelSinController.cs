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
    public class RelSinController : ControllerBase
    {
        private readonly IConfiguration configuration;

        public RelSinController(IConfiguration cofig)
        {
            this.configuration = cofig;
        }

        // GET: api/RelSin
        [HttpGet]
        public ActionResult Get()
        {
            try
            {
                RelSin relsin = new RelSin();

                return Ok(relsin.GetRelSins(configuration.GetConnectionString("CSAssistente"), 0).ToList());
            }
            catch(Exception ex)
            {
                return Forbid();
            }
        }

        // GET: api/RelSin/5
        [HttpGet("{idp}")]
        public ActionResult Get(int idp)
        {
            try
            {
                RelSin relSin = new RelSin();

                return Ok(relSin.GetRelSins(configuration.GetConnectionString("CSPaciente"), idp).ToList());
            }
            catch(Exception ex)
            {
                return Forbid();
            }
            
        }

        // POST: api/RelSin
        [HttpPost]
        public ActionResult Post([FromBody] RelSin value)
        {
            try
            {
               
                    value.CreateRelSin(configuration.GetConnectionString("CSPaciente"), value);
                

                return Ok();
            }
            catch (Exception ex)
            {
                return Forbid();
            }
        }

        // PUT: api/RelSin/5
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
