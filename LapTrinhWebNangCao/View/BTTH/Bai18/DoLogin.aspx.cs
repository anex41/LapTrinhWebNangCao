using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LapTrinhWebNangCao.View.BTTH.Bai18
{
    public partial class DoLogin : System.Web.UI.Page
    {
        private string username = "";
        private string password = "";
        private int srikeLimit = int.Parse(System.Configuration.ConfigurationManager.AppSettings["strikeK"]);
        private int timeOutLimt = int.Parse(System.Configuration.ConfigurationManager.AppSettings["timeOutLimitN"]);
        protected void Page_Load(object sender, EventArgs e)
        {
            username = Request.Params["submitUsername"];
            password = Request.Params["sumbitPassword"];
            if (Session["failedLogin"] != null)
            {
                failedLoginDetail obj = Session["failedLogin"] as failedLoginDetail;
                if (obj.LockFlag == true && obj.TimeOut > DateTime.Now)
                {
                    addExtraTime();
                    Session["flag"] = false;
                    Response.Redirect("Login.aspx");
                }
                else
                {
                    doLogin();
                }
            }
            else
            {
                doLogin();
            }
        }

        private void doLogin()
        {
            if (validateField(username, password))
            {
                if (username == "admin1" && password == "admin100")
                {
                    addSucceedList(username);
                    Session["flag"] = true;
                    Response.Redirect("Login.aspx");
                }
                else
                {
                    Session["failedLogin"] = addFailedList();
                    Session["flag"] = false;
                    Response.Redirect("Login.aspx");
                }
            }
            else
            {
                Session["failedLogin"] = addFailedList();
                Session["flag"] = false;
                Response.Redirect("Login.aspx");
            }
        }

        private bool validateField(string a, string b)
        {
            bool result = true;
            if (a.Length < 6 || a.Length > 12 || b.Length < 6 || b.Length > 12)
            {
                result = false;
            }
            return result;
        }

        private failedLoginDetail addFailedList()
        {
            failedLoginDetail obj = new failedLoginDetail();
            if (Session["failedLogin"] != null)
            {
                obj = Session["failedLogin"] as failedLoginDetail;
                obj.Strike ++;
                if (obj.Strike == srikeLimit)
                {
                    obj.Strike = 0;
                    obj.LockFlag = true;
                    obj.TimeOut = DateTime.Now.AddMinutes(timeOutLimt);
                }
                else
                {
                    obj.LockFlag = false;
                }
            }
            else
            {
                obj.Strike = 1;
                obj.LockFlag = false;
            }
            return obj;
        }

        private void addSucceedList(string u)
        {
            List<succeedLoginDetail> dt;
            if (Session["successLogin"] != null)
            {
                dt = Session["successLogin"] as List<succeedLoginDetail>;
                DateTime rn = DateTime.Now;
                dt.Add(new succeedLoginDetail(rn, u));
            }
            else
            {
                dt = new List<succeedLoginDetail>();
                DateTime rn = DateTime.Now;
                dt.Add(new succeedLoginDetail(rn, u));
            };
            Session["successLogin"] = dt;
        }

        private void addExtraTime()
        {
            failedLoginDetail obj = Session["failedLogin"] as failedLoginDetail;
            obj.Strike = 0;
            obj.LockFlag = true;
            obj.TimeOut = DateTime.Now.AddMinutes(timeOutLimt + 10);
            Session["failedLogin"] = obj;
        }
    }
}