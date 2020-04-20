using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LapTrinhWebNangCao.View.BTTH.Bai17
{
    public partial class ViewCart : System.Web.UI.Page
    {
        private string openDiv = "<div class=\"divTable\" style=\"border: 1px solid #000;\"><div class=\"divTableBody\">"
            + "<div class=\"divTableRow text-center\"><div class=\"divTableCell\">Hành động</div><div class=\"divTableCell\">STT</div><div class=\"divTableCell\">Tên sản phẩm</div>"
            + "<div class=\"divTableCell\">Số lượng</div>" + "<div class=\"divTableCell\">Giá sản phẩm</div><div class=\"divTableCell\">Tổng giá</div></div>";
        private string closeDiv = "</div></div>";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["B17Products"] != null)
            {
                List<B17Products> lstProduct = Session["B17Products"] as List<B17Products>;
                appendProduct(lstProduct);
            }
            else
            {
                alertEmptyCart();
            }
        }

        private void appendProduct(List<B17Products> list)
        {
            int x = 1;
            int productCount = 0;
            float sumPrice = 0;
            StringBuilder str = new StringBuilder();
            str.Append(openDiv);
            foreach (B17Products p in list)
            {
                str.Append("<div class=\"divTableRow text-center\"><div class=\"divTableCell\">"
                    + "<button data-toggle='modal' data-target='#exampleModal' type=\"button\" id=\"" + p.B17id + "\" class=\"btn btn-primary\" onClick=\"getItemID(this.id)\">Sửa</button></div>"
                    //+ "<asp:TextBox Text=\"Sửa\" CssClass=\"btn btn-success\" ID = \"txtun\" runat = \"server\" AutoPostBack = \"true\" OnTextChanged = \"editProduct\" /></div>"
                    + "<div class=\"divTableCell\">" + x + "</div><div class=\"divTableCell\">" + p.B17Name + "</div><div id=\"" + (p.B17id + "Amount")
                    + "\" class=\"divTableCell\">" + p.B17Amount + "</div><div class=\"divTableCell\">" + String.Format("{0:n0}", p.B17Money) + " đ</div><div class=\"divTableCell\">"
                    + "<span id=\"" + (p.B17id + "Money") + "\">" + String.Format("{0:n0}", p.B17Amount * p.B17Money) + "</span> đ</div></div>");
                x++;
                productCount += p.B17Amount;
                sumPrice += (p.B17Money * p.B17Amount);
            };
            str.Append(closeDiv);
            str.Append("<div class=\"col-sm-3 offset-sm-9 text-left\"><div style =\"\">Tổng giá: <span id=\"totalPrice\">" + String.Format("{0:n0}", sumPrice) + "</span> đ</div></div>");
            str.Append("<div class=\"col-sm-3 offset-sm-9 text-left\"><div style =\"\">Số lượng: <span id=\"totalAmount\">" + String.Format("{0:n0}", productCount) + "</span></div></div>");
            contentDiv.InnerHtml = contentDiv.InnerHtml + str.ToString();
        }

        private void alertEmptyCart()
        {
            contentDiv.InnerHtml = "<div class=\"w-100 d-block text-danger text-center\">Giỏ hàng trống</div>";
        }
    }
}



