using Quartz;
using System.Net.Mail;
using WebApiRest.Data;
using WebApiRest.Interfaz;
using WebApiRest.Models;

namespace WebApiRest.Utilities
{
    [DisallowConcurrentExecution]
    public class BackgroundJob: IJob
    {
        readonly RetoData retoData = new();        
        readonly CorreoEnvioData dataCorreoEnvio = new();
        private readonly IEmailService _emailService;

        public BackgroundJob(IEmailService emailService)
        {
            _emailService = emailService;
        }

        public async Task Execute(IJobExecutionContext context)
        {
            //Console.WriteLine("¡¡¡Hola mundo con Quartz.NET!!!");
            Usuario_RetoList response = await retoData.GetUsuarioRetoList(1);
            CorreoEnvioItem responseCorreoEnvio = await dataCorreoEnvio.GetCorreoEnvio(true);

            if (response.Error == 0 && responseCorreoEnvio.Error == 0)
            {
                string imgaen = responseCorreoEnvio.CorreoEnvio.Imagen;
                string url = responseCorreoEnvio.CorreoEnvio.Url;
                string colorPri = responseCorreoEnvio.CorreoEnvio.ColorPrimario;
                string colorSec = responseCorreoEnvio.CorreoEnvio.ColorSecundario;
                string colorTer = responseCorreoEnvio.CorreoEnvio.ColorTerciario;

                int diasRestantes = Convert.ToInt32(response.Info.Split(':')[1]);

                string urlImageLogo;
                if (!imgaen.Equals("N/A"))
                {
                    urlImageLogo = $"{url}/Content/Images/Config/{imgaen}";
                }
                else
                {
                    urlImageLogo = $"{url}/Content/Images/Default/default-logoDM.png";
                }

                List<EmailMessage> emailMessages = new();

                foreach (Usuario_Reto ur in response.Lista)
                {
                    emailMessages.Add(new EmailMessage()
                    {
                        Email = ur.Usuario.Correo,
                        Subject = "Reto por Cerrarse",
                        Body = Html.GetRetosPorCerrarse(urlImageLogo, colorPri, colorSec, colorTer, url, diasRestantes, ur.Reto.Nombre)
                    });                    
                }                

                await _emailService.SendEmailsInParallelAsync(responseCorreoEnvio.CorreoEnvio, emailMessages);
            }

            //return Task.CompletedTask; // <= poner esto si no es async la funcion.
        }
    }
}
