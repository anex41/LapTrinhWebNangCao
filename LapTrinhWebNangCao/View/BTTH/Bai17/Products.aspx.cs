using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LapTrinhWebNangCao.View.BTTH.Bai17
{
    public partial class Products : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            renderList(populateList());
            if (Session["B17Products"] != null)
            {
                List<B17Products> lstProduct = Session["B17Products"] as List<B17Products>;
                appCartList(lstProduct);
            }
        }

        private List<B17Products> populateList()
        {
            List<B17Products> listB17Products = new List<B17Products>();
            listB17Products.Add(new B17Products(1, "Nhà 1", 50, 10000));
            listB17Products.Add(new B17Products(2, "Nhà 2", 50, 10000));
            listB17Products.Add(new B17Products(3, "Nhà 3", 50, 10000));
            listB17Products.Add(new B17Products(4, "Nhà 4", 50, 10000));
            listB17Products.Add(new B17Products(5, "Nhà 5", 50, 10000));
            return listB17Products;
        }

        private void renderList(List<B17Products> x)
        {
            StringBuilder str = new StringBuilder();
            foreach (B17Products item in x)
            {
                str.Append("<div class='col-sm-4 mb-3'><div class='card'><img src='../../../Assets/nhaDep1.jpg' class='card-img-top' alt=''>"
                                + "<div class='card-body'><h5 class='card-title'>" + item.B17Name + "</h5><p class='card-text'>Nhà có sổ đỏ, chưa bán<br>"
                                + String.Format("{0:n0}", item.B17Money) + " đ</p><button id=\"" + item.B17id + '_' + item.B17Amount + "_" + item.B17Name + "_" + item.B17Money + "\" type='button' class='btn btn-primary' data-toggle='modal' onClick=\"addCartData(this.id)\" data-target='#exampleModal'>Đặt hàng</button>"
                                + "</div></div></div>");
            }
            b17ProductsContent.InnerHtml = str.ToString();

        }

        private void appCartList(List<B17Products> list)
        {
            StringBuilder str = new StringBuilder();
            str.Append("Thay đổi trong giỏ hàng");
            foreach (B17Products item in list)
            {
                str.Append("<div>Bạn đã thêm: " + item.B17Name + " với số lượng là: " + item.B17Amount + "</div >");
            }
            str.Append("<hr />");
            cartChangeDiv.InnerHtml = str.ToString();
        }
    }
}