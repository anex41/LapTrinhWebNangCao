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

namespace LapTrinhWebNangCao.View.BTTH.Bai21
{
    public partial class bai21 : System.Web.UI.Page
    {
        private string str = System.Configuration.ConfigurationManager.AppSettings["message"];
        static string connStr = ConfigurationManager.ConnectionStrings["myConStr"].ConnectionString;
        SqlConnection con = new SqlConnection(connStr);
        static string startDiv = "<div class=\"row\"><div class=\"col-sm-4 text-center border border-secondary\">ID</div><div class=\"col-sm-4 text-center border border-secondary\">"
            + "Ngày đánh giá</div><div class=\"col-sm-4 text-center border border-secondary\"> Số sao</div></div>";
        protected void Page_Load(object sender, EventArgs e)
        {
            ValidateProject vp = new ValidateProject();
            Session["mine"] = vp.EncryptMessage(str);
            if (!Page.IsPostBack)
            {
                driverNameList.DataSource = getDriverNameList();
                driverNameList.DataTextField = "name";
                driverNameList.DataValueField = "id";
                driverNameList.DataBind();
                driverNameList.Items.Insert(0, new ListItem(string.Empty, string.Empty));
                driverNameList.SelectedIndex = 0;
            }
        }

        protected void driverNameList_SelectedIndexChanged(object sender, EventArgs e)
        {
            StringBuilder str = new StringBuilder();
            int i = 1;
            List<ratingInfo> list = getDriverRatingInfo(driverNameList.SelectedValue.ToString());
            driverB21 driver = getDriver(driverNameList.SelectedValue.ToString());
            str.Append("<div class=\"card\"><div class=\"card-header text-center\"><b>" + driver.Name + "</b></div><div class=\"card-body\">"
                + "<p class=\"card-text\">Ngày sinh: " + driver.Birthday.ToString("dd/MM/yyyy") + "</p>"
                + "<p class=\"card-text\">Giới tính: " + (driver.Gender == true ? "Nam" : "Nữ") + "</p>"
                + "<p class=\"card-text\">Địa chỉ: " + driver.Address + "</p>"
                + "</div></div>");
            driverDiv.InnerHtml = str.ToString();
            str.Clear();
            if (list.Count > 0)
            {
                foreach (ratingInfo item in list)
                {
                    str.Append("<div class=\"row\"><div id=\"" + item.Id + "Item\" class=\"col-sm-4 text-center border border-secondary\">"
                        + i + "</div><div class=\"col-sm-4 text-center border border-secondary\">"
                        + item.RatingDate.ToString("dd/MM/yyyy") + "</div><div class=\"col-sm-4 text-center border border-secondary\">"
                        + item.RatingPoint + "</div></div>");
                    i++;
                }
                driverInfoContent.InnerHtml = startDiv + str.ToString();
            }
            else
            {
                str.Append("<h2 class=\"text-center text-danger\">Không có dữ liệu</h2>");
                driverInfoContent.InnerHtml = str.ToString();
            }
            str.Clear();
        }

        private List<driverNameInfo> getDriverNameList()
        {
            List<driverNameInfo> driverNameLst = new List<driverNameInfo>();
            SqlCommand cmd = new SqlCommand("getDriverName", con);
            cmd.CommandType = CommandType.StoredProcedure;
            con.Open();
            SqlDataReader rdr = cmd.ExecuteReader();
            while (rdr.Read())
            {
                driverNameLst.Add(new driverNameInfo(int.Parse(rdr["iLaixe"].ToString()), rdr["sHoTen"].ToString()));
            }
            con.Close();
            //    var result = cmd.ExecuteNonQuery();
            return driverNameLst;
        }

        private List<ratingInfo> getDriverRatingInfo(string value)
        {
            List<ratingInfo> ratingInfo = new List<ratingInfo>();
            SqlCommand cmd = new SqlCommand("getDriverInfo", con);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlParameter identity = cmd.Parameters.Add("driverID", SqlDbType.Int);
            identity.Value = int.Parse(value);
            con.Open();
            SqlDataReader rdr = cmd.ExecuteReader();
            if (rdr.FieldCount > 0)
            {
                while (rdr.Read())
                {
                    ratingInfo.Add(new ratingInfo(int.Parse(rdr["iDanhgiaID"].ToString()), DateTime.Parse(rdr["dNgaydanhgia"].ToString()), int.Parse(rdr["iSosao"].ToString())));
                }
            }
            con.Close();
            return ratingInfo;
        }

        private driverB21 getDriver(string value)
        {
            driverB21 driver = new driverB21();
            SqlCommand cmd = new SqlCommand("getDriver", con);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlParameter identity = cmd.Parameters.Add("driverID", SqlDbType.Int);
            identity.Value = int.Parse(value);
            con.Open();
            SqlDataReader rdr = cmd.ExecuteReader();
            if (rdr.FieldCount > 0)
            {
                while (rdr.Read())
                {
                    driver = new driverB21(int.Parse(rdr["iLaixe"].ToString()), rdr["sHoten"].ToString(), bool.Parse(rdr["bGioitinh"].ToString()), DateTime.Parse(rdr["dNgaysinh"].ToString()), rdr["sDiachi"].ToString());
                }
            }
            con.Close();
            return driver;
        }

        protected void b21SubmitBtn_Clicked(object sender, EventArgs e)
        {
            SqlCommand cmd = new SqlCommand("addReview", con);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlParameter identity = cmd.Parameters.Add("driverID", SqlDbType.Int);
            identity.Value = int.Parse(driverNameList.SelectedValue.ToString());
            SqlParameter point = cmd.Parameters.Add("reviewPoint", SqlDbType.Int);
            point.Value = int.Parse(reviewButton.SelectedValue.ToString());
            SqlParameter time = cmd.Parameters.Add("reviewDate", SqlDbType.DateTime);
            time.Value = txtDate.Text;
            con.Open();
            var x = cmd.ExecuteNonQuery();
            con.Close();
        }

        protected void b21CancelBtn_Clicked(object sender, EventArgs e)
        {
            driverNameList.SelectedIndex = 0;
            inputDate.Value = "";
            txtDate.Text = "";
            reviewButton.SelectedValue = null;
            driverInfoContent.InnerHtml = "";
            driverDiv.InnerHtml = "";
        }
    }
}