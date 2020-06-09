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
            UserService us = new UserService();
            List<UserModel> uml = us.GetClient();
            StringBuilder str = new StringBuilder();
            foreach (UserModel item in uml)
            {
                str.Append("<div class=\"card col-sm-4 userCard\"><img class=\"card-img-top w-75\" style=\"align-self: center;\" src=\"/../../../../Assets/autoUser.png\" alt=''>"
                    + "<div class=\"card-body\"><h5 class=\"card-title text-center\">" + item.Displayname + "</h5>"
                    + "<div class=\"row\"><div class=\"card-text col-sm-5\">Chức danh:</div><div class=\"card-text col-sm-7\">"
                    + (item.Role == 0 ? "Người dùng" : "Quản trị viên") + "</div></div><hr class=\"my-1\"/>"
                    + "<div class=\"row\"><div class=\"card-text col-sm-5\">Email:</div><div class=\"card-text col-sm-7\">"
                    + item.Email + "</div></div><hr class=\"my-1\"/>"
                    + "<div class=\"row\"><div class=\"card-text col-sm-5\">Số điện thoại:</div><div class=\"card-text col-sm-7\">"
                    + item.Phonenumber + "</div></div><hr class=\"my-1\"/>"
                    + "<button type=\"button\" id=\"" + item.Id + "\" onClick=\"deactiveUser(this.id)\" class=\"btn btn-outline-danger\" style=\"float: right;\">Deactivate</button></div></div>");
            };
            userList.InnerHtml = userList.InnerHtml + str.ToString();
        }
    }
}