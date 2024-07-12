using MailKit.Net.Smtp;
using MailKit.Security;
using MimeKit;
using MimeKit.Text;
using WebApiRest.Models;

namespace WebApiRest.Utilities
{
    // Esta clase envia correos por SMTP
    public class EmailService
    {
        private readonly CorreoEnvio _smtpConfig;
        private readonly int _batchSize = 50;
        private readonly SmtpClient _smtpClient;

        private readonly int connectionTimeout = 10000;

        public EmailService(CorreoEnvio smtpConfig)
        {
            _smtpConfig = smtpConfig;
            _smtpClient = new SmtpClient();
        }

        public async Task<Response> ConnectAsync()
        {
            var response = new Response();

            _smtpClient.Timeout = connectionTimeout;
            try
            {
                if (!_smtpClient.IsConnected)
                {
                    await _smtpClient.ConnectAsync(_smtpConfig.Host, _smtpConfig.Puerto, SecureSocketOptions.StartTls);
                    await _smtpClient.AuthenticateAsync(_smtpConfig.Correo, _smtpConfig.Password);
                    response.Info = "Conexión y autenticación exitosa";
                    response.Error = 0;
                }
            }
            catch (Exception ex)
            {
                response.Info = $"Error al conectar o autenticar: {ex.Message}";
                response.Error = 1;
            }
            return response;
        }

        public async Task DisconnectAsync()
        {
            if (_smtpClient.IsConnected)
            {
                await _smtpClient.DisconnectAsync(true);
            }
        }

        public async Task<Response> SendEmail(string correoUsuario, string asunto, string body)
        {
            var response = new Response();
            var message = new MimeMessage();
            //message.From.Add(MailboxAddress.Parse(WC.GetTrim(_smtpConfig.User)));
            message.From.Add(new MailboxAddress(WC.GetTrim(_smtpConfig.Nombre), WC.GetTrim(_smtpConfig.Correo)));
            message.To.Add(MailboxAddress.Parse(WC.GetTrim(correoUsuario)));
            message.Subject = asunto;
            message.Body = new TextPart(TextFormat.Html) { Text = body };

            try
            {
                await _smtpClient.SendAsync(message);
                response.Info = $"Correo enviado a {correoUsuario}";
                response.Error = 0;
            }
            catch (Exception ex)
            {
                response.Info = $"Error al enviar correo a {correoUsuario}: {ex.Message}";
                response.Error = 1;
            }

            return response;
        }

        public async Task<List<Response>> SendEmailsInBatches(List<EmailMessage> emailMessages)
        {
            var responses = new List<Response>();
            var connectResponse = await ConnectAsync();
            if (connectResponse.Error == 1)
            {
                responses.Add(connectResponse);
                return responses;
            }

            var emailBatches = GetEmailBatches(emailMessages, _batchSize);

            foreach (var batch in emailBatches)
            {
                foreach (var email in batch)
                {
                    var response = await SendEmail(email.Email, email.Subject, email.Body);
                    responses.Add(response);
                }

                // Espera mínima entre lotes para evitar problemas de carga en el servidor SMTP
                await Task.Delay(100); // Ajustar según sea necesario
            }

            await DisconnectAsync();
            return responses;
        }

        private static IEnumerable<List<EmailMessage>> GetEmailBatches(List<EmailMessage> emailMessages, int batchSize)
        {
            for (int i = 0; i < emailMessages.Count; i += batchSize)
            {
                yield return emailMessages.Skip(i).Take(batchSize).ToList();
            }
        }        
    }
}
