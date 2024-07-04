namespace WebApiRest.Utilities
{
    public class MailService
    {
        private readonly string smtpServer;
        private readonly int smtpPort;
        private readonly string smtpUser;
        private readonly string smtpPass;

        public MailService(string smtp, int port, string user, string pass)
        {
            smtpServer = smtp;
            smtpPort = port;
            smtpUser = user;
            smtpPass = pass;
        }
    }
}
