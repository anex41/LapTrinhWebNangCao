using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Web;
using System.Web.Services;

namespace LapTrinhWebNangCao.Services
{
    /// <summary>
    /// Summary description for ValidateProject
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]
    public class ValidateProject : System.Web.Services.WebService
    {
        private byte[] bytek = System.Convert.FromBase64String(System.Configuration.ConfigurationManager.AppSettings["bytek"]);
        private byte[] byte4 = System.Convert.FromBase64String(System.Configuration.ConfigurationManager.AppSettings["byte4"]);

        [WebMethod]
        public string EncryptMessage(string raw)
        {

            //byte[] k = new byte[] { (byte)244, 49, 154, 200, 205, 28, 50, 222, 58, 92, 249, 73, 147, 152, 92, 244 };
            //var kcon = System.Convert.ToBase64String(k, 0, k.Length);
            string result = "";
            try
            {
                // Create Aes that generates a new key and initialization vector (IV).    
                // Same key must be used in encryption and decryption    
                using (AesManaged aes = new AesManaged())
                {
                    // Encrypt string    
                    byte[] rawConverted = Convert.FromBase64String(raw);
                    // Print encrypted string    
                    // Decrypt the bytes to a string.    
                    result = Decrypt(rawConverted, bytek, byte4);
                    // Print decrypted string. It should be same as raw data    
                }
            }
            catch (Exception exp)
            {
                Console.WriteLine(exp.Message);
            }
            return result;
        }

        static byte[] Encrypt(string plainText, byte[] Key, byte[] IV)
        {
            byte[] encrypted;
            // Create a new AesManaged.    
            using (AesManaged aes = new AesManaged())
            {
                // Create encryptor    
                ICryptoTransform encryptor = aes.CreateEncryptor(Key, IV);
                // Create MemoryStream    
                using (MemoryStream ms = new MemoryStream())
                {
                    // Create crypto stream using the CryptoStream class. This class is the key to encryption    
                    // and encrypts and decrypts data from any given stream. In this case, we will pass a memory stream    
                    // to encrypt    
                    using (CryptoStream cs = new CryptoStream(ms, encryptor, CryptoStreamMode.Write))
                    {
                        // Create StreamWriter and write data to a stream    
                        using (StreamWriter sw = new StreamWriter(cs))
                            sw.Write(plainText);
                        encrypted = ms.ToArray();
                    }
                }
            }
            // Return encrypted data    
            return encrypted;
        }
        static string Decrypt(byte[] cipherText, byte[] Key, byte[] IV)
        {
            string plaintext = null;
            // Create AesManaged    
            using (AesManaged aes = new AesManaged())
            {
                // Create a decryptor    
                ICryptoTransform decryptor = aes.CreateDecryptor(Key, IV);
                // Create the streams used for decryption.    
                using (MemoryStream ms = new MemoryStream(cipherText))
                {
                    // Create crypto stream    
                    using (CryptoStream cs = new CryptoStream(ms, decryptor, CryptoStreamMode.Read))
                    {
                        // Read crypto stream    
                        using (StreamReader reader = new StreamReader(cs))
                            plaintext = reader.ReadToEnd();
                    }
                }
            }
            return plaintext;
        }
    }
}
