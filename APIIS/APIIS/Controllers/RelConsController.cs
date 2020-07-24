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
    public class RelConsController : ControllerBase
    {
        private readonly IConfiguration configuration;

        public RelConsController(IConfiguration cofig)
        {
            this.configuration = cofig;
        }
        // GET: api/RelCons
        [HttpGet]
        public ActionResult Get()
        {
            try
            {
                RelCons cons = new RelCons();

                return Ok(cons.GetRelCons(configuration.GetConnectionString("CSPaciente"),0).ToList());
            }
            catch (Exception ex)
            {
                return Forbid();
            }
        }

        // GET: api/RelCons/5
        [HttpGet("{idu}")]
        public ActionResult Get(int idu)
        {
            try
            {
                RelCons cons = new RelCons();

                List<RelCons> lista = new List<RelCons>();

                             
                lista = cons.GetRelCons(configuration.GetConnectionString("CSPaciente"),idu).ToList();
                
                    

                return Ok(lista);
            }
            catch (Exception ex)
            {
                return Forbid();
            }
        }

        // POST: api/RelCons
        [HttpPost]
        public ActionResult Post([FromBody] RelCons value)
        {
            try
            {
                value.CreateRelCons(configuration.GetConnectionString("CSPaciente"), value);

                return Ok();
            }
            catch(Exception ex)
            {
                return Forbid();
            }
        }

        // PUT: api/RelCons/5
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
