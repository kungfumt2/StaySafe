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
    public class NotificacaoController : ControllerBase
    {
        private readonly IConfiguration configuration;

        public NotificacaoController(IConfiguration cofig)
        {
            this.configuration = cofig;
        }

        // GET: api/Notificacao
        [HttpGet]
        public ActionResult Get()
        {
            try
            {
                Notificacao n = new Notificacao();

                n = n.GetNotificacao(configuration.GetConnectionString("CSPaciente"));

                return Ok(n);

            }
            catch(Exception ex)
            {
                return Forbid();
            }
        }

        // GET: api/Notificacao/5
        [HttpGet("{id}")]
        public ActionResult Get(int id)
        {
            return Forbid();
        }

        // POST: api/Notificacao
        [HttpPost]
        public ActionResult Post([FromBody] Notificacao value)
        {
            try
            {
                value.CreateNotificacao(configuration.GetConnectionString("CSPaciente"), value);

                return Ok();
            }
            catch(Exception ex)
            {
                return Forbid();
            }
        }

        // PUT: api/Notificacao/5
        [HttpPut("{id}")]
        public void Put(int id, [FromBody] string value)
        {
        }

        // DELETE: api/ApiWithActions/5
        [HttpDelete("{id}")]
        public ActionResult Delete(int id)
        {
            try
            {
                Notificacao value = new Notificacao();

                value.DeleteNotificacao(configuration.GetConnectionString("CSPaciente"), id);

                return Ok();
            }
            catch (Exception ex)
            {
                return Forbid();
            }
        }
    }
}
