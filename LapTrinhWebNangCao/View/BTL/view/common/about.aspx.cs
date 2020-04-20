using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LapTrinhWebNangCao.View.BTL.view.common
{
    public partial class about : System.Web.UI.Page
    {
        static string connStr = ConfigurationManager.ConnectionStrings["myConStr"].ConnectionString;
        SqlConnection con = new SqlConnection(connStr);
        protected void Page_Load(object sender, EventArgs e)
        {
            StringBuilder str = new StringBuilder();
            bool activateFlagg = false;
            SqlCommand cmd = new SqlCommand("getCkEditorContent", con);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlParameter identity = cmd.Parameters.Add("id", SqlDbType.VarChar, 20);
            identity.Value = "introduction";
            con.Open();
            SqlDataReader rdr = cmd.ExecuteReader();
            while (rdr.Read())
            {
                str.Append(rdr["ckEditorContent"].ToString());
                activateFlagg = bool.Parse(rdr["activateFlag"].ToString());
            }
            con.Close();
            aboutContentDiv.InnerHtml = str.ToString();
        }
    }
}