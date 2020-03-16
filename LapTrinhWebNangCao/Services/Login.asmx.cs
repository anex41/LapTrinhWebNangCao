using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.IO;
using System.Security.Cryptography;
using System.Text;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

namespace LapTrinhWebNangCao.Services
{
    /// <summary>
    /// Summary description for Login
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]
    public class Login : System.Web.Services.WebService
    {
        static string connStr = ConfigurationManager.ConnectionStrings["myConStr"].ConnectionString;
        SqlConnection con = new SqlConnection(connStr);

        [WebMethod]
        public string HelloWorld()
        {
            return "Hello World";
        }

        [WebMethod]
        public string UserLogin(string username, string password)
        {
            string x = "";
            string role = "";
            SqlCommand cmd = new SqlCommand("getUser", con);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlParameter un = cmd.Parameters.Add("username", SqlDbType.VarChar, 50);
            un.Value = username;
            con.Open();
            SqlDataReader rdr = cmd.ExecuteReader();
            var hashedPassword = hashString(password).ToLower();
            while (rdr.Read())
            {
                x = (rdr["password"].ToString());
                role = (rdr["role"].ToString());
            }
            con.Close();
            if (string.Compare(hashedPassword, x) == 0)
            {
                return role;
            }
            else
            {
                return null;
            }
        }

        [WebMethod(EnableSession = true)]
        public void createSession(string username, string password)
        {
            string role = "";
            string x = "";
            SqlCommand cmd = new SqlCommand("getUser", con);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlParameter un = cmd.Parameters.Add("username", SqlDbType.VarChar, 50);
            un.Value = username;
            con.Open();
            SqlDataReader rdr = cmd.ExecuteReader();
            var hashedPassword = hashString(password).ToLower();
            while (rdr.Read())
            {
                x = (rdr["password"].ToString());
                role = (rdr["role"].ToString());
            }
            con.Close();
            if (string.Compare(hashedPassword, x) == 0)
            {
                Session["UserName"] = username;
                Session["role"] = role;
            }
            else
                return;
        }

        private string hashString(string input)
        {
            StringBuilder sb = new StringBuilder();
            foreach (byte b in getHash(input))
                sb.Append(b.ToString("X2"));

            return sb.ToString();
        }

        private byte[] getHash(string inputString)
        {
            using (HashAlgorithm algorithm = SHA256.Create())
                return algorithm.ComputeHash(Encoding.UTF8.GetBytes(inputString));
        }
    }
}
