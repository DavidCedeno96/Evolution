using System.Security.Cryptography;
using System.Security.Cryptography.Xml;
using System.Text;

namespace WebApiRest.Utilities
{
    // Esta clase sirve para poder encriptar un dato
    public class Hasher
    {
        
        private readonly Settings settings = new();

        public Hasher()
        {
            var config = new ConfigurationBuilder().SetBasePath(Directory.GetCurrentDirectory()).AddJsonFile("appsettings.json").Build();            
            settings = config.GetSection("settings").Get<Settings>();
        }

        // Encriptar
        public string Encrypt(string text)
        {
            PasswordDeriveBytes pdb = new(settings.HasherKey, new byte[] { 0x0, 0x1, 0x2, 0x1C, 0x1D, 0x1E, 0x3, 0x4, 0x5, 0xF, 0x20, 0x21, 0xAD, 0xAF, 0xA4 });

            Aes aesAlg = Aes.Create();
            aesAlg.Key = pdb.GetBytes(32);
            aesAlg.IV = pdb.GetBytes(16);


            if (!string.IsNullOrEmpty(text))
            {
                byte[] clearBytes = Encoding.Unicode.GetBytes(text.Trim());

                ICryptoTransform encryptor = aesAlg.CreateEncryptor(aesAlg.Key, aesAlg.IV);
                MemoryStream msEncrypt = new();
                CryptoStream csEncrypt = new(msEncrypt, encryptor, CryptoStreamMode.Write);
                csEncrypt.Write(clearBytes, 0, clearBytes.Length);
                csEncrypt.Close();


                byte[] encryptedData = msEncrypt.ToArray();
                //return  Encoding.UTF8.GetBytes(Convert.ToBase64String(encryptedData));
                return Convert.ToBase64String(encryptedData);
            }
            return "";
        }    

        // Desencriptar
        public string Decrypt(string text)
        {            
            PasswordDeriveBytes pdb = new(settings.HasherKey, new byte[] { 0x0, 0x1, 0x2, 0x1C, 0x1D, 0x1E, 0x3, 0x4, 0x5, 0xF, 0x20, 0x21, 0xAD, 0xAF, 0xA4 });                        

            using Aes aesAlg = Aes.Create();
            aesAlg.Key = pdb.GetBytes(32);
            aesAlg.IV = pdb.GetBytes(16);

            //string encryptedText = Encoding.UTF8.GetString(text);
            byte[] cipherBytes = Convert.FromBase64String(text);

            ICryptoTransform decryptor = aesAlg.CreateDecryptor(aesAlg.Key, aesAlg.IV);            
            MemoryStream msDecrypt = new(cipherBytes);
            CryptoStream csDecrypt = new(msDecrypt, decryptor, CryptoStreamMode.Read);
            StreamReader srDecrypt = new(csDecrypt, Encoding.Unicode);
            return srDecrypt.ReadToEnd();

        }       
    }
}
