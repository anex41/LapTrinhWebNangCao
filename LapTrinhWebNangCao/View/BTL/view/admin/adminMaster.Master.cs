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
        protected void Page_Load(object sender, EventArgs e)
        {

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