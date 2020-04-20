using LapTrinhWebNangCao.Model;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.Services;

namespace LapTrinhWebNangCao.Services
{
    /// <summary>
    /// Summary description for userService
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]
    public class userService : System.Web.Services.WebService
    {
        static string connStr = ConfigurationManager.ConnectionStrings["myConStr"].ConnectionString;
        SqlConnection con = new SqlConnection(connStr);

        [WebMethod]
        public List<userModel> getClient()
        {
            List<userModel> uml = new List<userModel>();
            SqlCommand cmd = new SqlCommand("getClient", con);
            cmd.CommandType = CommandType.StoredProcedure;
            con.Open();
            SqlDataReader rdr = cmd.ExecuteReader();
            while (rdr.Read())
            {
                userModel um = new userModel();
                um.Id = (int)rdr["id"];
                um.Username = (string)rdr["username"];
                um.Role = (int)rdr["role"];
                uml.Add(um);
            }
            con.Close();
            return uml;
        }
        [WebMethod]
        public bool addNewClient(string username, string password)
        {
            bool flag = true;
            string hashedPassword = hashString(password);
            SqlCommand cmd = new SqlCommand("createNewClient", con);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlParameter un = cmd.Parameters.Add("username", SqlDbType.VarChar, 50);
            un.Value = username;
            SqlParameter pw = cmd.Parameters.Add("password", SqlDbType.VarChar, 256);
            pw.Value = hashedPassword;
            con.Open();
            var result = cmd.ExecuteNonQuery();
            if (result > 0) flag = true;
            else flag = false;
            return flag;
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
