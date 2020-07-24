using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using APIIS.Models;

namespace APIIS.Models
{
    public class Login
    {
        public string Email { get; set; }

        public string Password { get; set; }


        public Login()
        {
            Email = string.Empty;
            Password = string.Empty;
        }

        public Utilizador IsValidLogin(Login log)
        {
            Utilizador user = new Utilizador();

            List<Utilizador> lista = user.GetUtilizadors("Server=localhost;Database=StaySafeIS;User ID=AnonimoSSIS;Password=IS123;Trusted_Connection=False;", string.Empty, 0, string.Empty);


            if (lista.Where(x=>x.Email.Equals(log.Email)).Count() != 0)
            {
                if(lista.Where(x=>x.Email.Equals(log.Email)).First().Password.Equals(log.Password))
                {
                    return lista.Where(x => x.Email.Equals(log.Email)).First();
                }
               
            }
            return null;
        }
    }
}
