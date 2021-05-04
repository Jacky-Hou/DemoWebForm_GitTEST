using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;

namespace ClassLibrary
{
    public class Cryptography
    {

        #region AES 加解密
        /// <summary>
        /// AES 加密字串 
        /// 可逆編碼(對稱金鑰)
        /// </summary>
        /// <param name="plainText">原始字串</param>
        /// <param name="key">密鑰, 長度為 16/24/32 bytes[128/192/256bit]</param>
        /// <param name="iv">Vectory向量, 長度為 16 bytes[128bit]</param>
        /// <returns></returns>
        public string EncryptAES(string plainText, string key, string iv)
        {
            // Check arguments. 
            if (plainText == null || plainText.Length <= 0)
                throw new ArgumentNullException("plainText");
            if (key == null || key.Length <= 0)
                throw new ArgumentNullException("key");
            if (key.Length != 16 && key.Length != 24 && key.Length != 32)
                throw new ArgumentOutOfRangeException("key");
            if (iv == null || iv.Length <= 0)
                throw new ArgumentNullException("iv");
            if (iv.Length != 16)
                throw new ArgumentOutOfRangeException("iv");
            
            var sourceBytes = System.Text.Encoding.UTF8.GetBytes(plainText);
            var aes = new System.Security.Cryptography.RijndaelManaged();         //.net framework
            //var aes = System.Security.Cryptography.Aes.Create();                //.net core
            aes.Mode = System.Security.Cryptography.CipherMode.CBC;
            aes.Padding = System.Security.Cryptography.PaddingMode.PKCS7;
            aes.Key = System.Text.Encoding.UTF8.GetBytes(key);
            aes.IV = System.Text.Encoding.UTF8.GetBytes(iv);
            var transform = aes.CreateEncryptor();
            return System.Convert.ToBase64String(transform.TransformFinalBlock(sourceBytes, 0, sourceBytes.Length));
        }

        /// <summary>
        /// AES 解密字串
        /// 可逆編碼(對稱金鑰)
        /// </summary>
        /// <param name="text">加密後的字串</param>
        /// <param name="key">密鑰, 長度為 16/24/32 bytes[128/192/256bit]</param>
        /// <param name="iv">Vectory向量, 長度為 16 bytes[128bit]</param>
        /// <returns></returns>
        public string DecryptAES(string EncryptText, string key, string iv)
        {
            // Check arguments. 
            if (EncryptText == null || EncryptText.Length <= 0)
                throw new ArgumentNullException("plainText");
            if (key == null || key.Length <= 0)
                throw new ArgumentNullException("key");
            if (key.Length != 16 && key.Length != 24 && key.Length != 32)
                throw new ArgumentOutOfRangeException("key");
            if (iv == null || iv.Length <= 0)
                throw new ArgumentNullException("iv");
            if (iv.Length != 16)
                throw new ArgumentOutOfRangeException("iv");

            var encryptBytes = System.Convert.FromBase64String(EncryptText);
            var aes = new System.Security.Cryptography.RijndaelManaged();     //.net framework
            //var aes = System.Security.Cryptography.Aes.Create();                //.net core
            aes.Mode = System.Security.Cryptography.CipherMode.CBC;
            aes.Padding = System.Security.Cryptography.PaddingMode.PKCS7;
            aes.Key = System.Text.Encoding.UTF8.GetBytes(key);
            aes.IV = System.Text.Encoding.UTF8.GetBytes(iv);
            var transform = aes.CreateDecryptor();
            return System.Text.Encoding.UTF8.GetString(transform.TransformFinalBlock(encryptBytes, 0, encryptBytes.Length));
        }
        #endregion AES 加解密


    }
}
