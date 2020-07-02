using LapTrinhWebNangCao.Services;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LapTrinhWebNangCao.View.BTTH.Bai20
{
    public partial class RegisterB20 : System.Web.UI.Page
    {
        private string str = System.Configuration.ConfigurationManager.AppSettings["message"];

        protected void Page_Load(object sender, EventArgs e)
        {
            ValidateProject vp = new ValidateProject();
            Session["mine"] = vp.EncryptMessage(str);
            if (Page.IsPostBack)
            {
                Response.Redirect(Request.RawUrl);
            }
        }
    }
}