using SendGrid;
using SendGrid.Helpers.Mail;
using WebApiRest.Utilities;

namespace WebApiRest.Interfaz
{
    public interface IEmailService
    {
        Task<Response> SendEmailAsync(string emailAddress, string name, string subject, string htmlContent, List<EmailAddress> recipients);
        Task<List<Models.Response>> SendEmailsInParallelAsync(CorreoEnvio correoEnvio, List<EmailMessage> emailMessages);
    }
}
