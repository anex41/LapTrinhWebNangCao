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
        public List<userModel> GetClient()
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
                um.Displayname = (string)rdr["displayName"];
                um.Email = (string)rdr["email"];
                um.Phonenumber = (string)rdr["phoneNumber"];
                um.Role = (int)rdr["role"];
                um.Statusflag = (int)rdr["statusFlag"];
                uml.Add(um);
            }
            con.Close();
            return uml;
        }
        [WebMethod]
        public bool AddNewClient(string username, string password, string displayname, string phonenumber, string email)
        {
            bool flag = true;
            string hashedPassword = HashString(password);
            SqlCommand cmd = new SqlCommand("createNewClient", con);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlParameter un = cmd.Parameters.Add("username", SqlDbType.VarChar, 50);
            un.Value = username;
            SqlParameter pw = cmd.Parameters.Add("password", SqlDbType.VarChar, 256);
            pw.Value = hashedPassword;
            SqlParameter dn = cmd.Parameters.Add("displayName", SqlDbType.NVarChar, 50);
            dn.Value = displayname;
            SqlParameter pn = cmd.Parameters.Add("phoneNumber", SqlDbType.VarChar, 12);
            pn.Value = phonenumber;
            SqlParameter em = cmd.Parameters.Add("email", SqlDbType.VarChar, 50);
            em.Value = email;
            con.Open();
            var result = cmd.ExecuteNonQuery();
            con.Close();
            if (result > 0) flag = true;
            else flag = false;
            return flag;
        }

        [WebMethod]
        public bool CheckUserExistence(string username)
        {
            bool flag = true;
            SqlCommand cmd = new SqlCommand("checkUserName", con);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlParameter un = cmd.Parameters.Add("username", SqlDbType.VarChar, 50);
            un.Value = username;
            var returnParameter = cmd.Parameters.Add("@ReturnVal", SqlDbType.Int);
            returnParameter.Direction = ParameterDirection.ReturnValue;
            con.Open();
            cmd.ExecuteNonQuery();
            int result = int.Parse(returnParameter.Value.ToString());
            con.Close();
            if (result == 0) flag = false;
            else flag = true;
            return flag;
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
