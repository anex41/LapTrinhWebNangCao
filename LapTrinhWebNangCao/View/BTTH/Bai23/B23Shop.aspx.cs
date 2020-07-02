using LapTrinhWebNangCao.Services;
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
        private string str = System.Configuration.ConfigurationManager.AppSettings["message"];
        private static string connStr = ConfigurationManager.ConnectionStrings["myConStr"].ConnectionString;
        private SqlConnection con = new SqlConnection(connStr);
        private static int currentIndex = 0, currentProducer = -1, tR = 0, currentPageSize = 0, currentTotalPage = 0;
        private float currentStartPrice = -1, currentEndPrice = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            //addPhoneData();
            ValidateProject vp = new ValidateProject();
            Session["mine"] = vp.EncryptMessage(str);
            if (!Page.IsPostBack)
            {
                PopulateProducerList();
                setDefaultSetting();
            }
        }

        private void PopulateProducerList()
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
            producerList.DataValueField = "id";
            producerList.DataTextField = "name";
            producerList.DataBind();
            producerList.Items.Insert(0, new ListItem("Tất cả", "-1"));
            producerList.SelectedIndex = 0;
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
            con.Close();
            return lst;
        }

        private void renderPageButton(pagingAlgorithmClass x, bool flg)
        {
            StringBuilder str = new StringBuilder();
            if (flg)
            {
                double a = double.Parse(x.TotalRecord.ToString()) / double.Parse(x.PageSize.ToString());
                x.TotalPage = int.Parse(Math.Round(a, MidpointRounding.AwayFromZero).ToString());
                if (x.TotalPage < a) x.TotalPage++;
                currentTotalPage = x.TotalPage;
                if (x.TotalPage <= 5)
                {
                    pageInput.Visible = false;
                    for (int i = 0; i < x.TotalPage; i++)
                    {
                        if (currentIndex == (i + 1))
                        {
                            str.Append("<button class=\"btn btn-info\" type=\"button\" id=\"page_" + (i + 1) + "\" onclick=\"getPageIndex(this.id)\">" + (i + 1) + "</button>");
                        }
                        else
                        {
                            str.Append("<button class=\"btn btn-outline-info\" type=\"button\" id=\"page_" + (i + 1) + "\" onclick=\"getPageIndex(this.id)\">" + (i + 1) + "</button>");
                        }
                    }
                }
                else
                {
                    pageInput.Visible = true;
                    if (currentIndex == 1)
                    {
                        str.Append("<button class=\"btn btn-info\" type=\"button\" id=\"page_" + 1 + "\" onclick=\"getPageIndex(this.id)\">" + 1 + "</button>");
                        str.Append("<button class=\"btn btn-outline-info\" type=\"button\" id=\"page_" + 2 + "\" onclick=\"getPageIndex(this.id)\">" + 2 + "</button>");
                        str.Append("&nbsp; ... &nbsp;");
                        str.Append("<button class=\"btn btn-outline-info\" type=\"button\" id=\"page_" + (x.TotalPage - 1) + "\" onclick=\"getPageIndex(this.id)\">" + (x.TotalPage - 1) + "</button>");
                        str.Append("<button class=\"btn btn-outline-info\" type=\"button\" id=\"page_" + x.TotalPage + "\" onclick=\"getPageIndex(this.id)\">" + x.TotalPage + "</button>");
                    }
                    else if (currentIndex == 2)
                    {
                        str.Append("<button class=\"btn btn-outline-info\" type=\"button\" id=\"page_" + 1 + "\" onclick=\"getPageIndex(this.id)\">" + 1 + "</button>");
                        str.Append("<button class=\"btn btn-info\" type=\"button\" id=\"page_" + 2 + "\" onclick=\"getPageIndex(this.id)\">" + 2 + "</button>");
                        str.Append("&nbsp; ... &nbsp;");
                        str.Append("<button class=\"btn btn-outline-info\" type=\"button\" id=\"page_" + (x.TotalPage - 1) + "\" onclick=\"getPageIndex(this.id)\">" + (x.TotalPage - 1) + "</button>");
                        str.Append("<button class=\"btn btn-outline-info\" type=\"button\" id=\"page_" + x.TotalPage + "\" onclick=\"getPageIndex(this.id)\">" + x.TotalPage + "</button>");
                    }
                    else if (currentIndex == (x.TotalPage - 1))
                    {
                        str.Append("<button class=\"btn btn-outline-info\" type=\"button\" id=\"page_" + 1 + "\" onclick=\"getPageIndex(this.id)\">" + 1 + "</button>");
                        str.Append("<button class=\"btn btn-outline-info\" type=\"button\" id=\"page_" + 2 + "\" onclick=\"getPageIndex(this.id)\">" + 2 + "</button>");
                        str.Append("&nbsp; ... &nbsp;");
                        str.Append("<button class=\"btn btn-info\" type=\"button\" id=\"page_" + (x.TotalPage - 1) + "\" onclick=\"getPageIndex(this.id)\">" + (x.TotalPage - 1) + "</button>");
                        str.Append("<button class=\"btn btn-outline-info\" type=\"button\" id=\"page_" + x.TotalPage + "\" onclick=\"getPageIndex(this.id)\">" + x.TotalPage + "</button>");
                    }
                    else if (currentIndex == x.TotalPage)
                    {
                        str.Append("<button class=\"btn btn-outline-info\" type=\"button\" id=\"page_" + 1 + "\" onclick=\"getPageIndex(this.id)\">" + 1 + "</button>");
                        str.Append("<button class=\"btn btn-outline-info\" type=\"button\" id=\"page_" + 2 + "\" onclick=\"getPageIndex(this.id)\">" + 2 + "</button>");
                        str.Append("&nbsp; ... &nbsp;");
                        str.Append("<button class=\"btn btn-outline-info\" type=\"button\" id=\"page_" + (x.TotalPage - 1) + "\" onclick=\"getPageIndex(this.id)\">" + (x.TotalPage - 1) + "</button>");
                        str.Append("<button class=\"btn btn-info\" type=\"button\" id=\"page_" + x.TotalPage + "\" onclick=\"getPageIndex(this.id)\">" + x.TotalPage + "</button>");
                    }
                    else
                    {
                        str.Append("<button class=\"btn btn-outline-info\" type=\"button\" id=\"page_" + 1 + "\" onclick=\"getPageIndex(this.id)\">" + 1 + "</button>");
                        str.Append("<button class=\"btn btn-outline-info\" type=\"button\" id=\"page_" + 2 + "\" onclick=\"getPageIndex(this.id)\">" + 2 + "</button>");
                        str.Append("&nbsp; ... &nbsp;");
                        str.Append("<button class=\"btn btn-info\" type=\"button\" id=\"page_" + currentIndex + "\" onclick=\"getPageIndex(this.id)\">" + currentIndex + "</button>");
                        str.Append("&nbsp; ... &nbsp;");
                        str.Append("<button class=\"btn btn-outline-info\" type=\"button\" id=\"page_" + (x.TotalPage - 1) + "\" onclick=\"getPageIndex(this.id)\">" + (x.TotalPage - 1) + "</button>");
                        str.Append("<button class=\"btn btn-outline-info\" type=\"button\" id=\"page_" + x.TotalPage + "\" onclick=\"getPageIndex(this.id)\">" + x.TotalPage + "</button>");
                    }
                }
            }
            else
            {
                pageInput.Visible = false;
                str.Append("");
            }
            pageButton.InnerHtml = str.ToString();
        }

        protected void producerList_SelectedIndexChanged(object sender, EventArgs e)
        {
            string value = producerList.SelectedValue.ToString();
            currentProducer = int.Parse(value);
            pagingAlgorithmClass pac = new pagingAlgorithmClass();
            pac.PageIndex = currentIndex = 1;
            pac.PageSize = currentPageSize;
            pac = calculatePaging(pac, currentProducer, currentStartPrice, currentEndPrice);
            if (renderDataList(getDataList(pac.StartingPoint, pac.EndingPoint, currentStartPrice, currentEndPrice, currentProducer)))
                renderPageButton(pac, true);
            else renderPageButton(pac, false);
        }

        protected void serachB23_Click(object sender, EventArgs e)
        {
            currentStartPrice = float.Parse(inputSPrice.Value);
            currentEndPrice = float.Parse(inputEPrice.Value);
            if (currentStartPrice == -1 && currentEndPrice == -1)
            {
                refreshPriceButton.Visible = false;
                inputSPrice.Value = "";
                inputEPrice.Value = "";
            }
            else refreshPriceButton.Visible = true;
            pagingAlgorithmClass pac = new pagingAlgorithmClass();
            pac.PageIndex = currentIndex = 1;
            pac.PageSize = currentPageSize;
            pac = calculatePaging(pac, currentProducer, currentStartPrice, currentEndPrice);
            if (renderDataList(getDataList(pac.StartingPoint, pac.EndingPoint, currentStartPrice, currentEndPrice, currentProducer)))
                renderPageButton(pac, true);
            else renderPageButton(pac, false);
        }

        private bool renderDataList(List<phoneData> lst)
        {
            bool flag = true;
            StringBuilder str = new StringBuilder();
            if (lst.Count == 0)
            {
                str.Append("<div class=\"col-sm-12 text-center text-danger\"><h2>Không có dữ liệu</h2></div>");
                flag = false;
            }
            else
            {
                flag = true;
                foreach (phoneData item in lst)
                {
                    str.Append("<div class=\"col-sm-2 text-center p-3\"><div class=\"fa-border border-secondary rounded\"><i class=\"fas fa-mobile fa-7x\"></i>"
                        + "<div>" + item.Name + "</div>"
                        + "<div>" + String.Format("{0:n0}", item.Price) + " đ</div>"
                        + "<button type=\"button\" class=\"btn btn-outline-primary\">Chi Tiết</button>"
                        + "</div></div>");
                }
            }
            phoneData.InnerHtml = str.ToString();
            return flag;
        }

        private void setDefaultSetting()
        {
            pagingAlgorithmClass pac = new pagingAlgorithmClass();
            pac.PageSize = currentPageSize = 30;
            pac.PageIndex = currentIndex = 1;
            pac.EndingPoint = pac.PageSize * pac.PageIndex;
            pac.StartingPoint = pac.EndingPoint - (pac.PageSize - 1);
            if (pac.StartingPoint < 0) pac.StartingPoint = 0;
            currentStartPrice = currentEndPrice = -1;
            pac = calculatePaging(pac, currentProducer, currentStartPrice, currentEndPrice);
            if (renderDataList(getDataList(pac.StartingPoint, pac.EndingPoint, currentStartPrice, currentEndPrice, currentProducer)))
                renderPageButton(pac, true);
            else renderPageButton(pac, false);
        }

        protected void changePage_Click(object sender, EventArgs e)
        {
            int value = int.Parse(pageValue.Value.ToString());
            if (value > currentTotalPage || value <= 0)
            {
                noPageFound.Visible = true;
            }
            else
            {
                pagingAlgorithmClass pac = new pagingAlgorithmClass();
                currentIndex = pac.PageIndex = int.Parse(pageValue.Value.ToString());
                pac.PageSize = currentPageSize;
                pac = calculatePaging(pac, currentProducer, currentStartPrice, currentEndPrice);
                if (renderDataList(getDataList(pac.StartingPoint, pac.EndingPoint, currentStartPrice, currentEndPrice, currentProducer)))
                    renderPageButton(pac, true);
                else renderPageButton(pac, false);
            }
        }

        private pagingAlgorithmClass calculatePaging(pagingAlgorithmClass x, int curProducer, float curSPrice, float curEPrice)
        {
            SqlCommand cmd = new SqlCommand("countRecordtblDienthoai", con);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlParameter startRecord = cmd.Parameters.Add("@nsx", SqlDbType.Int);
            startRecord.Value = curProducer;
            SqlParameter sPrice = cmd.Parameters.Add("@beginPrice", SqlDbType.Float);
            sPrice.Value = curSPrice;
            SqlParameter ePrice = cmd.Parameters.Add("@endingPrice", SqlDbType.Float);
            ePrice.Value = curEPrice;
            con.Open();
            SqlDataReader rdr = cmd.ExecuteReader();
            while (rdr.Read())
            {
                tR = int.Parse(rdr["NumberOfProduct"].ToString());
            }
            con.Close();
            x.TotalRecord = tR;
            x.EndingPoint = x.PageSize * x.PageIndex;
            x.StartingPoint = x.EndingPoint - (x.PageSize - 1);
            if (x.StartingPoint < 0) x.StartingPoint = 0;
            return x;
        }

        public void changePageSize(object sender, EventArgs e)
        {
            pagingAlgorithmClass pac = new pagingAlgorithmClass();
            Button btn = (Button)sender;
            pac.PageSize = currentPageSize = int.Parse(btn.Text);
            pac.PageIndex = currentIndex = 1;
            pac = calculatePaging(pac, currentProducer, currentStartPrice, currentEndPrice);
            if (renderDataList(getDataList(pac.StartingPoint, pac.EndingPoint, currentStartPrice, currentEndPrice, currentProducer)))
                renderPageButton(pac, true);
            else renderPageButton(pac, false);
        }
    }
}