using LapTrinhWebNangCao.Services;
using System;
using System.Web.UI;

namespace LapTrinhWebNangCao
{

    public partial class SiteMaster : MasterPage
    {
        private string str = System.Configuration.ConfigurationManager.AppSettings["message"];

        protected void Page_Load(object sender, EventArgs e)
        {
            ValidateProject vp = new ValidateProject();
            Session["mine"] = vp.EncryptMessage(str);
        }
    }
}