using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using LapTrinhWebNangCao.Model;
using LapTrinhWebNangCao.Services;

namespace LapTrinhWebNangCao.View.BTL.view.admin
{
    public partial class adminUserManager : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            userService us = new userService();
            List<userModel> uml = us.getClient();
            StringBuilder str = new StringBuilder();
            foreach (userModel item in uml)
            {
                str.Append("<div class=\"card col-sm-3\"><img class=\"card-img-top w-75\" style=\"align-self: center;\" src=\"/../../../../Assets/autoUser.png\" alt=''>"
                    + "<div class=\"card-body\"><h5 class=\"card-title\">" + item.Username + "</h5>"
                    + "<p class=\"card-text\">" + (item.Role == 0 ? "Người dùng" : "Quản trị viên") + "</p>"
                    + "<button type=\"button\" id=\"" + item.Id + "\" onClick=\"deactiveUser(this.id)\" class=\"btn btn-outline-danger\" style=\"float: right;\">Deactivate</button></div></div>");
            };
            userList.InnerHtml = userList.InnerHtml + str.ToString();
        }
    }
}