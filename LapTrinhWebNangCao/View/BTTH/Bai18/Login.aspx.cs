using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Text;
using System.Web.UI.WebControls;

namespace LapTrinhWebNangCao.View.BTTH.Bai18
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["flag"] != null)
            {
                if (bool.Parse(Session["flag"].ToString()))
                {
                    ShowSucceedLoginList();
                }
                else
                {
                    ShowFailedLoginList();
                }
            }
        }

        private void ShowSucceedLoginList()
        {
            StringBuilder str = new StringBuilder();
            List<succeedLoginDetail> dt = Session["successLogin"] as List<succeedLoginDetail>;
            foreach (succeedLoginDetail item in dt)
            {
                str.Append("<div class=\"col-sm-12 text-primary\">user: " + item.UserName + " succeed login at: " + item.Time + "</div>");
            };
            LoginDetail.InnerHtml = str.ToString();
        }

        private void ShowFailedLoginList()
        {
            failedLoginDetail obj = Session["failedLogin"] as failedLoginDetail;
            if (obj.LockFlag == true)
            {
                timmer.InnerHtml = obj.TimeOut.ToString();
            }
            else
            {
                StringBuilder str = new StringBuilder();
                str.Append("<div class=\"col-sm-12 text-danger text-center\">Đăng Nhập sai</div>");
                LoginDetail.InnerHtml = str.ToString();
            };
        }
    }
}