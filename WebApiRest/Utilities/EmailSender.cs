using SendGrid;
using SendGrid.Helpers.Mail;
using System.Net;
using WebApiRest.Interfaz;

namespace WebApiRest.Utilities
{
    // Esta clase envia correos por Api Key de SendGrid
    public class EmailSender : IEmailService
    {
        private readonly ISendGridClient _sendGridClient;

        public EmailSender(ISendGridClient sendGridClient)
        {
            _sendGridClient = sendGridClient;
        }

        public async Task<Response> SendEmailAsync(string emailAddress, string name, string subject, string htmlContent, List<EmailAddress> recipients)
        {
            var from = new EmailAddress(emailAddress, name);
            var msg = new SendGridMessage
            {
                From = from,
                Subject = subject,                
                HtmlContent = htmlContent
            };

            foreach (var recipient in recipients)
            {
                msg.AddTo(recipient);
            }

            var response = await _sendGridClient.SendEmailAsync(msg);
            return response;
        }

        public async Task<List<Models.Response>> SendEmailsInParallelAsync(CorreoEnvio correoEnvio, List<EmailMessage> emailMessages)
        {
            var tasks = emailMessages.Select(async emailMessage =>
            {
                var sendGridResponse = await SendEmailAsync(
                    correoEnvio.Correo, 
                    correoEnvio.Nombre,                    
                    emailMessage.Subject,                    
                    emailMessage.Body,
                    new List<EmailAddress> { new(emailMessage.Email) }
                );

                return new Models.Response
                {
                    Error = sendGridResponse.StatusCode == HttpStatusCode.Accepted ? 0 : 1,
                    Info = sendGridResponse.StatusCode == HttpStatusCode.Accepted ?
                           $"Email to {emailMessage.Email} sent successfully." :
                           $"Failed to send email to {emailMessage.Email}. Status Code: {sendGridResponse.StatusCode}"
                };
            });

            var results = await Task.WhenAll(tasks);
            return results.ToList();
        }
    }
}
