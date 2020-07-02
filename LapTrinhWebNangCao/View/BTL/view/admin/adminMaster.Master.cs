using LapTrinhWebNangCao.Services;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LapTrinhWebNangCao.View.BTL.view.admin
{
    public partial class adminMaster : System.Web.UI.MasterPage
    {
        private string str = System.Configuration.ConfigurationManager.AppSettings["message"];

        protected void Page_Load(object sender, EventArgs e)
        {
            ValidateProject vp = new ValidateProject();
            Session["mine"] = vp.EncryptMessage(str);
        }
        protected void Page_PreRender(object sender, EventArgs e)
        {
            if (Session["UserName"] != null)
            {
                loginDiv.Visible = false;
                logoutDiv.Visible = true;
            }
            else
            {
                loginDiv.Visible = true;
                logoutDiv.Visible = false;
            }
        }
    }
}