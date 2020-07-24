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
    public class LoginController : ControllerBase
    {
        private readonly IConfiguration configuration;

        public LoginController(IConfiguration cofig)
        {
            this.configuration = cofig;
        }

        // GET: api/Login
        [HttpGet]
        public ActionResult Get()
        {
            try
            {
                if (HttpContext.Session.GetString("UserMail") != null && HttpContext.Session.GetString("UserMail") != "")
                {
                    return Ok(HttpContext.Session.GetString("UserMail"));
                }
                else
                {
                    return BadRequest();
                }
            }
            catch(Exception ex)
            {
                return BadRequest();
            }
        }

        // GET: api/Login/5
        [HttpGet("{id}")]
        public string Get(int id)
        {
            return "value";
        }

        // POST: api/Login
        [HttpPost]
        public ActionResult Post([FromBody] Login value)
        {
            try
            {
                try
                {

                   Utilizador user = value.IsValidLogin(value);

                    Paciente pac = new Paciente();

             

                    Dictionary<string, object> dic = new Dictionary<string, object>();


                    if(pac.GetPacientes(configuration.GetConnectionString("CSPaciente"),"IDU",user.Id,string.Empty).Count() != 0)
                    {
                        dic.Add("id", user.Id);
                        dic.Add("role", "Paciente");
                    }
                   


                    return Ok(dic);
                }
                catch(Exception ex)
                {
                    return NoContent();
                }
            }
            catch(Exception ex)
            {
                return BadRequest();
            }
        }

        // PUT: api/Login/5
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
