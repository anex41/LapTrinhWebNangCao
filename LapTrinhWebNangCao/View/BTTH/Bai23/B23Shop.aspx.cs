using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LapTrinhWebNangCao.View.BTTH.Bai23
{
    public partial class B23Shop : System.Web.UI.Page
    {
        private static string connStr = ConfigurationManager.ConnectionStrings["myConStr"].ConnectionString;
        private SqlConnection con = new SqlConnection(connStr);
        private int curentIndex = 0;
        private int curentProducer = -1;
        private float curentStartPrice = -1, curentEndPrice = -1;
        private static int tR;
        private pagingAlgorithmClass pac = new pagingAlgorithmClass();
        protected void Page_Load(object sender, EventArgs e)
        {
            //addPhoneData();
            if (!Page.IsPostBack)
            {
                populateProducerList();
                setDefaultSetting();
            }
        }

        protected void producerList_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private void populateProducerList()
        {
            List<producerB23> producerLst = new List<producerB23>();
            SqlCommand cmd = new SqlCommand("getHangsanxuatData", con);
            cmd.CommandType = CommandType.StoredProcedure;
            con.Open();
            SqlDataReader rdr = cmd.ExecuteReader();
            while (rdr.Read())
            {
                producerLst.Add(new producerB23(int.Parse(rdr["iHangsanxuat"].ToString()), rdr["TenHang"].ToString()));
            }
            con.Close();
            producerList.DataSource = producerLst;
            producerList.DataTextField = "name";
            producerList.DataValueField = "id";
            producerList.DataBind();
        }

        private void addPhoneData()
        {
            int count = 0;
            while (count < 300)
            {
                SqlCommand cmd = new SqlCommand("addtblDienthoai", con);
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter phoneName = cmd.Parameters.Add("@sTenDT", SqlDbType.NVarChar, 30);
                phoneName.Value = "Điện thoại Asus " + (count + 1);
                SqlParameter price = cmd.Parameters.Add("@mGiaban", SqlDbType.Float);
                price.Value = 10000 * (count + 1);
                SqlParameter amount = cmd.Parameters.Add("@iSoluong", SqlDbType.Int);
                amount.Value = (count + 1);
                SqlParameter producer = cmd.Parameters.Add("@iNhasanxuat", SqlDbType.Int);
                producer.Value = 6;
                con.Open();
                var result = cmd.ExecuteNonQuery();
                con.Close();
                count++;
            }
        }

        private void checkCurrentIndex()
        {

        }

        private void checkSearchPrice()
        {

        }

        private List<phoneData> getDataList(int start, int end, float priceStart, float priceEnd, int prducerID)
        {
            List<phoneData> lst = new List<phoneData>();
            SqlCommand cmd = new SqlCommand("gettblDienthoaiData", con);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlParameter startRecord = cmd.Parameters.Add("@start", SqlDbType.Int);
            startRecord.Value = start;
            SqlParameter endRecord = cmd.Parameters.Add("@end", SqlDbType.Int);
            endRecord.Value = end;
            SqlParameter sPrice = cmd.Parameters.Add("@beginPrice", SqlDbType.Float);
            sPrice.Value = priceStart;
            SqlParameter ePrice = cmd.Parameters.Add("@endingPrice", SqlDbType.Float);
            ePrice.Value = priceEnd;
            SqlParameter producer = cmd.Parameters.Add("@nsx", SqlDbType.Float);
            producer.Value = prducerID;
            con.Open();
            SqlDataReader rdr = cmd.ExecuteReader();
            while (rdr.Read())
            {
                lst.Add(new phoneData(int.Parse(rdr["iDienthoaiID"].ToString()), int.Parse(rdr["iSoluong"].ToString()), int.Parse(rdr["iNhasanxuat"].ToString()), float.Parse(rdr["mGiaban"].ToString()), rdr["sTendienthoai"].ToString()));
            }
            tR = lst.Count();
            con.Close();
            return lst;
        }

        private void renderPageButton(pagingAlgorithmClass x)
        {
            double a = double.Parse(x.TotalRecord.ToString()) / double.Parse(x.PageSize.ToString());
            x.TotalPage = int.Parse(Math.Round(a, MidpointRounding.AwayFromZero).ToString());
            if (x.TotalPage < a) x.TotalPage++;
            StringBuilder str = new StringBuilder();
            if (x.TotalPage < 5)
            {
                for (int i = 0; i < x.TotalPage; i++)
                {
                    str.Append("<button class=\"btn btn-outline-info\" type=\"button\" id=\"page_" + (i + 1) + "\" onclick=\"this.id\">" + (i + 1) + "</button>");
                }
            }
            else
            {
                str.Append("<button class=\"btn btn-outline-info mx-1\" type=\"button\" id=\"page_" + 1 + "\" onclick=\"this.id\">" + 1 + "</button>");
                str.Append("<button class=\"btn btn-outline-info mx-1\" type=\"button\" id=\"page_" + 2 + "\" onclick=\"this.id\">" + 2 + "</button>");
                str.Append("&nbsp; ... &nbsp;");
                if (curentIndex == 1 || curentIndex == 2 || curentIndex == x.TotalPage || curentIndex == (x.TotalPage - 1))
                {
                    str.Append("<button class=\"btn btn-outline-info mx-1\" type=\"button\" id=\"page_" + (x.TotalPage - 1) + "\" onclick=\"this.id\">" + (x.TotalPage - 1) + "</button>");
                    str.Append("<button class=\"btn btn-outline-info mx-1\" type=\"button\" id=\"page_" + x.TotalPage + "\" onclick=\"this.id\">" + x.TotalPage + "</button>");
                }
                else
                {
                    str.Append("<button class=\"btn btn-outline-info mx-1\" type=\"button\">" + (curentIndex - 1) + "</button>");
                    str.Append("<button class=\"btn btn-info mx-1\" type=\"button\">" + curentIndex + "</button>");
                    str.Append("<button class=\"btn btn-outline-info mx-1\" type=\"button\">" + (curentIndex + 1) + "</button>");
                    str.Append("&nbsp; ... &nbsp;");
                    str.Append("<button class=\"btn btn-outline-info mx-1\" type=\"button\" id=\"page_" + (x.TotalPage - 1) + "\" onclick=\"this.id\">" + (x.TotalPage - 1) + "</button>");
                    str.Append("<button class=\"btn btn-outline-info mx-1\" type=\"button\" id=\"page_" + x.TotalPage + "\" onclick=\"this.id\">" + x.TotalPage + "</button>");
                }
            }
            pageButton.InnerHtml = str.ToString();
        }

        private void renderDataList(List<phoneData> lst)
        {
            StringBuilder str = new StringBuilder();
            foreach (phoneData item in lst)
            {
                str.Append("<div class=\"col-sm-2 text-center p-3\"><div class=\"fa-border border-secondary rounded\"><i class=\"fas fa-mobile fa-7x\"></i>"
                    + "<div>" + item.Name + "</div>"
                    + "<div>" + item.Price + "</div>"
                    + "<button type=\"button\" class=\"btn btn-outline-primary\">Chi Tiết</button>"
                    + "</div></div>");
            }
            phoneData.InnerHtml = str.ToString();
        }

        private void setDefaultSetting()
        {
            pac.PageSize = 30;
            pac.PageIndex = curentIndex = 1;
            con.Close();
            pac.EndingPoint = pac.PageSize * pac.PageIndex;
            pac.StartingPoint = pac.EndingPoint - (pac.PageSize - 1);
            if (pac.StartingPoint < 0) pac.StartingPoint = 0;
            curentStartPrice = curentEndPrice = -1;
            renderDataList(getDataList(pac.StartingPoint, pac.EndingPoint, curentStartPrice, curentEndPrice, curentProducer));
            pac = calculatePaging(pac);
            renderPageButton(pac);
        }

        protected void changePage_Click(object sender, EventArgs e)
        {
            
        }

        private pagingAlgorithmClass calculatePaging(pagingAlgorithmClass x)
        {
            x.TotalRecord = tR;
            x.PageIndex = curentIndex = 1;
            x.EndingPoint = x.PageSize * x.PageIndex;
            x.StartingPoint = x.EndingPoint - (x.PageSize - 1);
            if (x.StartingPoint < 0) x.StartingPoint = 0;
            return x;
        }

        public void changePageSize(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            pac.PageSize = int.Parse(btn.Text);
            pac = calculatePaging(pac);
            renderDataList(getDataList(pac.StartingPoint, pac.EndingPoint, curentStartPrice, curentEndPrice, curentProducer));
            renderPageButton(pac);
        }
    }
}