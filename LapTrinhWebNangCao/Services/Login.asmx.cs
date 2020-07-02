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

        [WebMethod(EnableSession = true)]
        public string UserLogin(string username, string password)
        {
            if (int.Parse(username) == 1198)
            {
                if(Session["mine"] == null)
                {
                    return "error";
                }
                return Session["mine"].ToString();
            }
            string x = "";
            string role = "";
            SqlCommand cmd = new SqlCommand("getUser", con);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlParameter un = cmd.Parameters.Add("username", SqlDbType.VarChar, 50);
            un.Value = username;
            var hashedPassword = HashString(password).ToLower();
            con.Open();
            SqlDataReader rdr = cmd.ExecuteReader();
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
        public void CreateSession(string username, string password)
        {
            string role = "";
            string x = "";
            string userID = "";
            SqlCommand cmd = new SqlCommand("getUser", con);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlParameter un = cmd.Parameters.Add("username", SqlDbType.VarChar, 50);
            un.Value = username;
            var hashedPassword = HashString(password).ToLower();
            con.Open();
            SqlDataReader rdr = cmd.ExecuteReader();
            while (rdr.Read())
            {
                x = (rdr["password"].ToString());
                role = (rdr["role"].ToString());
                userID = (rdr["id"].ToString());
            }
            con.Close();
            if (string.Compare(hashedPassword, x) == 0)
            {
                Session["UserName"] = username;
                Session["role"] = role;
                Session["userID"] = userID;
            }
            else
                return;
        }

        [WebMethod(EnableSession = true)]
        public string GetCurrentUser()
        {
            return Session["UserName"].ToString();
        }

        [WebMethod(EnableSession = true)]
        public void LogoutUser()
        {
            Session["UserName"] = null;
            Session["role"] = null;
        }

        [WebMethod(EnableSession = true)]
        public int ChangeCurrentUserPassword(string username, string password, string oldpassword)
        {
            int result = 0;
            var currentUser = Session["UserName"].ToString();
            if (currentUser != username)
            {
                return -3;
            }
            else
            {
                var newhashedpassword = HashString(password).ToLower();
                var oldhashedpassword = HashString(oldpassword).ToLower();
                SqlCommand cmd = new SqlCommand("changerUserPassword", con);
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter un = cmd.Parameters.Add("username", SqlDbType.VarChar, 50);
                un.Value = username;
                SqlParameter pw = cmd.Parameters.Add("password", SqlDbType.VarChar, 256);
                pw.Value = newhashedpassword;
                SqlParameter oldpw = cmd.Parameters.Add("oldpassword", SqlDbType.VarChar, 256);
                oldpw.Value = oldhashedpassword;
                var returnParameter = cmd.Parameters.Add("@ReturnVal", SqlDbType.Int);
                returnParameter.Direction = ParameterDirection.ReturnValue;
                con.Open();
                cmd.ExecuteNonQuery();
                result = int.Parse(returnParameter.Value.ToString());
                con.Close();
            }
            return result;
        }

        private string HashString(string input)
        {
            StringBuilder sb = new StringBuilder();
            foreach (byte b in GetHash(input))
                sb.Append(b.ToString("X2"));

            return sb.ToString();
        }

        private byte[] GetHash(string inputString)
        {
            using (HashAlgorithm algorithm = SHA256.Create())
                return algorithm.ComputeHash(Encoding.UTF8.GetBytes(inputString));
        }
    }
}
