using Newtonsoft.Json;
using System.Security.Cryptography;
using System.Text;

namespace WebApiRest.Utilities
{
    // Esta clase sirve para poder encriptar o desencriptar un dato
    public static class Hasher
    {        

        private static readonly string secretKey = "K38#vQUjVK%ooTQyEU23A#BC&jBQcm";

        // Encriptar
        public static async Task<string> Encrypt(string text)
        {
            using Aes aesAlg = Aes.Create();
            aesAlg.Key = Encoding.UTF8.GetBytes(secretKey.PadRight(32));
            aesAlg.IV = GenerateRandomIV();
            string iv = Convert.ToBase64String(aesAlg.IV);

            ICryptoTransform encryptor = aesAlg.CreateEncryptor(aesAlg.Key, aesAlg.IV);

            using MemoryStream msEncrypt = new();
            using (CryptoStream csEncrypt = new(msEncrypt, encryptor, CryptoStreamMode.Write))
            {
                using StreamWriter swEncrypt = new(csEncrypt);
                await swEncrypt.WriteAsync(text);
            } 

            string cipherText = Convert.ToBase64String(msEncrypt.ToArray());
            string encryptedText = JsonConvert.SerializeObject(new { CipherText = cipherText, IV = iv });
            return encryptedText;
        }

        // Desencriptar
        public static async Task<string> Decrypt(string cipherTextConIV)
        {
            dynamic encryptedData = JsonConvert.DeserializeObject(cipherTextConIV);
            string cipherText = encryptedData.CipherText;
            string iv = encryptedData.IV;

            using Aes aesAlg = Aes.Create();
            aesAlg.Key = Encoding.UTF8.GetBytes(secretKey.PadRight(32));
            aesAlg.IV = Convert.FromBase64String(iv);

            ICryptoTransform decryptor = aesAlg.CreateDecryptor(aesAlg.Key, aesAlg.IV);

            byte[] encryptedBytes = Convert.FromBase64String(cipherText);

            using MemoryStream msDecrypt = new(encryptedBytes);
            using CryptoStream csDecrypt = new(msDecrypt, decryptor, CryptoStreamMode.Read);
            using StreamReader srDecrypt = new(csDecrypt);
            string decryptedText = await srDecrypt.ReadToEndAsync();
            return decryptedText;
        }

        private static byte[] GenerateRandomIV()
        {
            Aes aes = Aes.Create();
            aes.GenerateIV();
            return aes.IV;
        }

    }
}
