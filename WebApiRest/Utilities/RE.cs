using System.Text.RegularExpressions;

namespace WebApiRest.Utilities
{
    // Esta clase es para Regular Expresions
    public static class RE
    {
        /*
         * La clave:
            debe tener mínimo 5 caracteres y máximo 20
            debe tener al menos una letra minúscula
            debe tener al menos una letra mayúscula
            debe tener la menos un número
            debe tener al menos un carácter especial pero solo los siguientes @.-_#$
         */

        private static readonly string palabras = @"^[a-zA-ZáÁéÉíÍóÓúÚüÜñÑ\s]+$";
        private static readonly string palabrasNumeros = @"^[\p{L}\s\d]+$";        
        private static readonly string celular = @"^\d{9}$";
        private static readonly string cedula = @"^\d{10,15}$";
        private static readonly string email = @"^[\w\.-]+@[a-zA-Z\d\.-]+\.[a-zA-Z]{2,}$";
        private static readonly string clave = @"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@\.\-_$#])[a-zA-Z\d@\.\-_$#]{5,20}$";
        private static readonly string invalid = @"^[^<>]+$";        

        public static bool ValidRE(string text, string nombrePatron)
        {
            if (string.IsNullOrEmpty(text))
            {
                return true;
            }

            Regex regex = Patron(nombrePatron);

            Match match = regex.Match(text.Trim());

            return match.Success;
        }

        private static Regex Patron(string patron)
        {
            Regex regex;
            switch (patron.ToLower())
            {
                case "palabras":
                    {
                        regex = new Regex(palabras);
                        break;
                    }
                case "palabras_numeros":
                    {
                        regex = new Regex(palabrasNumeros);
                        break;
                    }                
                case "cedula":
                    {
                        regex = new Regex(cedula);
                        break;
                    }
                case "celular":
                    {
                        regex = new Regex(celular);
                        break;
                    }
                case "email":
                    {
                        regex = new Regex(email);
                        break;
                    }
                case "clave":
                    {
                        regex = new Regex(clave);
                        break;
                    }
                case "invalid":
                    {
                        regex = new Regex(invalid);
                        break;
                    }                
                default:
                    {
                        regex = new Regex("");
                        break;
                    }
            }

            return regex;
        }
    }
}
