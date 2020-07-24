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
    public class UtilizadorController : ControllerBase
    {
        private readonly IConfiguration configuration;

        public UtilizadorController(IConfiguration cofig)
        {
            this.configuration = cofig;
        }

        // GET: api/Utilizador
        [HttpGet]
        public ActionResult Get()
        {
            try
            {
                Utilizador user = new Utilizador();

                List<Utilizador> users = new List<Utilizador>();

                users = user.GetUtilizadors(configuration.GetConnectionString("CSAnonimo"), "", 0, "").ToList();

                return Ok(users);
            }
            catch (Exception e)
            {
                return Forbid();
            }
        }

        // GET: api/Utilizador/5
        [HttpGet("{idd}")]
        public ActionResult Get(int idd)
        {
            try
            {
                Utilizador user = new Utilizador();

               
                    user = user.GetUtilizadors(configuration.GetConnectionString("CSAnonimo"), "Id", idd, string.Empty).FirstOrDefault();

                    
              return Ok(user);
            }
            catch (Exception ex)
            {
                return Forbid();
            }
        }

        // POST: api/Utilizador
        [HttpPost]
        public ActionResult Post([FromBody] Utilizador value)
        {
            try
            {
                Utilizador user = new Utilizador();

                if (user.GetUtilizadors(configuration.GetConnectionString("CSAnonimo"), "", 0, "").Where(x => x.Email.Equals(value.Email)).Count().Equals(0))
                {
                    
                    user.CreateUtilizador(configuration.GetConnectionString("CSAnonimo"), value);

                    return Ok(user.GetUtilizadors(configuration.GetConnectionString("CSAnonimo"), "", 0, "").Last().Id);
                }
                else
                {
                    return BadRequest();
                }

                
            }
            catch (Exception ex)
            {
                return Forbid();
            }
        }

        // PUT: api/Utilizador/5
        [HttpPut("{idd}")]
        public ActionResult Put(int idd, [FromBody] List<string> value)
        {
            Utilizador user = new Utilizador();


            if(value[0].Equals("UpdatePass"))
            {
                try
                {
                    user.UpdateUtilizador(configuration.GetConnectionString("CSPaciente"), value[1], idd);

                    return Ok();
                }
                catch(Exception ex)
                {
                    return BadRequest();
                }

            }
            else if(value[0].Equals("ValidarUser"))
            {
                try
                {
                    user.ValidarUtilizador(configuration.GetConnectionString("CSAdministrador"),value[1],idd);

                    return Ok();
                }
                catch (Exception ex)
                {
                    return BadRequest();
                }
            }
            else if(value[0].Equals("UpdateEstado"))
            {
                try
                {
                    user.UpdateEstadoUtilizador(configuration.GetConnectionString("CSPaciente"), idd, value[1]);

                    return Ok();
                }
                catch(Exception ex)
                {
                    return BadRequest();
                }
            }
            else
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
