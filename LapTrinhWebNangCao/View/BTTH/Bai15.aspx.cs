using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LapTrinhWebNangCao.View.BTTH
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        private string hoten,ns,gender;
        public string HoTens { get { return hoten; } }
        public string Ngaysinh { get { return ns; } }
        public string genders { get { return gender; } }

        protected void Page_Load(object sender, EventArgs e)
        {
            hoten = Request.Params["hoten"];
            ns = Request.Params["ns"];
            gender = Request.Params["gender"];
        }
    }
}