using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;

namespace LapTrinhWebNangCao.Services
{
    /// <summary>
    /// Summary description for contentManagerService
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]
    public class contentManagerService : System.Web.Services.WebService
    {
        static string connStr = ConfigurationManager.ConnectionStrings["myConStr"].ConnectionString;
        SqlConnection con = new SqlConnection(connStr);

        [WebMethod]
        public bool addWebContent(string identity, string content, bool activateFlagValue)
        {
            bool flag = true;
            SqlCommand cmd = new SqlCommand("addCkEditorContent", con);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlParameter id = cmd.Parameters.Add("id", SqlDbType.VarChar, 20);
            id.Value = identity;
            SqlParameter textContent = cmd.Parameters.Add("textContent", SqlDbType.NText);
            textContent.Value = content;
            SqlParameter activateFlag = cmd.Parameters.Add("activateFlag", SqlDbType.Bit);
            activateFlag.Value = activateFlagValue;
            con.Open();
            var result = cmd.ExecuteNonQuery();
            con.Close();
            if (result > 0) flag = true;
            else flag = false;
            return flag;
        }
    }
}
