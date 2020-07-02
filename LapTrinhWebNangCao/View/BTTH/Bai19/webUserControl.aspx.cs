using LapTrinhWebNangCao.Services;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LapTrinhWebNangCao.View.BTTH.Bai19
{
    public partial class webUserControl1 : System.Web.UI.Page
    {
        private string str = System.Configuration.ConfigurationManager.AppSettings["message"];

        protected void Page_Load(object sender, EventArgs e)
        {
            ValidateProject vp = new ValidateProject();
            Session["mine"] = vp.EncryptMessage(str);
        }
    }
}