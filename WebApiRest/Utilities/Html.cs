namespace WebApiRest.Utilities
{
    public static class Html
    {        
        private static string GetHeader()
        {            
            string encabezado = "<!DOCTYPE html>" +
                "<html lang=\"es\"> " +
                " <head>" +
                "   <meta charset=\"UTF-8\" />" +
                "   <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\" />" +
                "   <title>Correo</title>    " +
                "  </head>";                

            return encabezado;
        }

        private static string GetFooter()
        {
            return "\r\n</html>";            
        }

        public static string GetRegisterUser(string urlImagen, string colorPrimario, string colorSecundario, string colorTerciario, string urlActivacion, string correo, string contrasena) {

            string body = "<body\r\n    style=\"\r\n      font-family: Arial, sans-serif;\r\n      background-color: #f0f0f0;\r\n      padding: 3%;\r\n    \"\r\n  >\r\n    <div\r\n      style=\"\r\n        width: 85%;\r\n        max-width: 400px;\r\n        margin: 0px auto;\r\n        padding: 20px;\r\n        border-radius: 10px;\r\n        background-color: #fff;\r\n        box-shadow: 0 0 100px rgba(0, 0, 0, 0.1);\r\n      \"\r\n    >\r\n      <div style=\"text-align: center\">\r\n        <img\r\n          src=\""+urlImagen+"\"\r\n          alt=\"Logo\"\r\n          style=\"\r\n            display: block;\r\n            margin: 5% auto;\r\n            border-radius: 10px;\r\n            max-width: 80%;\r\n            height: auto;\r\n            object-fit: cover;\r\n          \"\r\n        />\r\n      </div>\r\n      <div style=\"text-align: center; margin-top: 20px\">\r\n        <h2 style=\"color: " + colorPrimario+ "\">Bienvenido!</h2>\r\n  <div style=\"text-align: start\">\r\n          <small\r\n            style=\"display: block; margin-bottom: 10px; word-wrap: break-word\"\r\n            ><b>Correo electrónico:</b> "+correo+"</small\r\n          >\r\n          <small style=\"display: block\"><b>Contraseña:</b> "+contrasena+"</small>\r\n        </div>    <p style=\"margin: 30px 0px; color: " + colorSecundario+"\">\r\n          Haga clic en el botón de abajo para activar tu cuenta\r\n        </p>\r\n        <p>\r\n          <a\r\n            href=\""+urlActivacion+"\"\r\n            style=\"\r\n              width: fit-content;\r\n              padding: 10px 20px;\r\n              border-radius: 20px;\r\n              background-color: "+colorTerciario+";\r\n              color: #fff;\r\n              cursor: pointer;\r\n              text-decoration: none;\r\n            \"\r\n            >Activar cuenta</a\r\n          >\r\n        </p>\r\n      </div>\r\n    </div>\r\n  </body>";

            return GetHeader() + body + GetFooter(); 
        }

        public static string GetRecompensaCanjeada(string urlImagen, string colorPrimario, string colorSecundario, string colorTerciario, string recompensa, string urlImgRecompensa, string msgNotificacion)
        {
            string body = "<body\r\n    style=\"\r\n      font-family: Arial, sans-serif;\r\n      background-color: #f0f0f0;\r\n      padding: 3%;\r\n    \"\r\n  >\r\n    <div\r\n      style=\"\r\n        width: 85%;\r\n        max-width: 400px;\r\n        margin: 0px auto;\r\n        padding: 20px;\r\n        border-radius: 10px;\r\n        background-color: #fff;\r\n        box-shadow: 0 0 100px rgba(0, 0, 0, 0.1);\r\n      \"\r\n    >\r\n      <div style=\"text-align: center\">\r\n        <img\r\n          src=\""+urlImagen+ "\"\r\n          alt=\"Logo\"\r\n          style=\"\r\n            display: block;\r\n            margin: 5% auto;\r\n            border-radius: 10px;\r\n            max-width: 80%;\r\n            height: auto;\r\n            object-fit: cover;\r\n          \"\r\n        />\r\n      </div>\r\n      <div style=\"text-align: center; margin-top: 20px\">\r\n        <h3 style=\"color: " + colorPrimario+ "\"\">Recompensa Canjeada!</h3>\r\n        <div style=\"text-align: center\">\r\n          <span style=\"color: "+ colorSecundario+"; word-wrap: break-word\"\r\n            >"+recompensa+"</span\r\n          >\r\n          <img\r\n            src=\""+ urlImgRecompensa + "\"\r\n            alt=\"Recompensa\"\r\n            style=\"\r\n              display: block;\r\n              margin: 5% auto;\r\n              border-radius: 10px;\r\n              max-width: 50%;\r\n              height: auto;\r\n              object-fit: cover;\r\n            \"\r\n          />\r\n        </div>\r\n        <p style=\"margin: 30px 0px; color: "+ colorTerciario + "\">\r\n         "+ msgNotificacion + "\r\n        </p>\r\n      </div>\r\n    </div>\r\n  </body>";

            return GetHeader() + body + GetFooter();
        }
    }
}
