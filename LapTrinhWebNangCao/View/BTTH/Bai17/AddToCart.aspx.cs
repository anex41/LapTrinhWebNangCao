using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LapTrinhWebNangCao.View.BTTH.Bai17
{
    public partial class AddToCart : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["B17Products"] != null)
            {
                List<B17Products> lstProduct = Session["B17Products"] as List<B17Products>;
            }
        }
    }
}