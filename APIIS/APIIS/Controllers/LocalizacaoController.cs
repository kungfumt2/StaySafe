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
    public class LocalizacaoController : ControllerBase
    {
        private readonly IConfiguration configuration;

        public LocalizacaoController(IConfiguration cofig)
        {
            this.configuration = cofig;
        }

        // GET: api/Localizacao
        [HttpGet]
        public ActionResult Get()
        {
            return BadRequest();
        }

        // GET: api/Localizacao/5
        [HttpGet("{idc}")]
        public ActionResult Get(int idc)
        {
            try
            {
                Localizacao local = new Localizacao();

                return Ok(local.GetLocalizacoes(configuration.GetConnectionString("CSPaciente"), idc).ToList());
            }
            catch(Exception ex)
            {
                return Forbid();
            }
        }

        // POST: api/Localizacao
        [HttpPost]
        public ActionResult Post([FromBody] Localizacao value)
        {
            try
            {
                value.CreateLocalizacao(configuration.GetConnectionString("CSPaciente"), value);

                return Ok();
            }
            catch(Exception ex)
            {
                return Forbid();
            }
        }

        // PUT: api/Localizacao/5
        [HttpPut("{idc}")]
        public ActionResult Put(int idc, [FromBody] bool value)
        {
            try
            {
                Localizacao local = new Localizacao();

                local.UpdateLocalizacao(configuration.GetConnectionString("CSPaciente"), idc, value);

                return Ok();
            }
            catch(Exception ex)
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
