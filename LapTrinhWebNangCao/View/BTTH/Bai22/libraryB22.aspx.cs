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

namespace LapTrinhWebNangCao.View.BTTH.Bai22
{
    public partial class libraryB22 : System.Web.UI.Page
    {
        static string connStr = ConfigurationManager.ConnectionStrings["myConStr"].ConnectionString;
        SqlConnection con = new SqlConnection(connStr);
        public int totalPage = 100;
        protected void Page_Load(object sender, EventArgs e)
        {
           
        }

        private List<b22LoaiSach> getListLoaiSach(int start, int end)
        {
            List<b22LoaiSach> lst = new List<b22LoaiSach>();
            SqlCommand cmd = new SqlCommand("addtblLoaiSach", con);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlParameter startRecord = cmd.Parameters.Add("@startRecord", SqlDbType.Int);
            SqlParameter endRecord = cmd.Parameters.Add("@endRecord", SqlDbType.Int);
            startRecord.Value = start;
            endRecord.Value = end;
            con.Open();
            SqlDataReader rdr = cmd.ExecuteReader();
            if (rdr.FieldCount > 0)
            {
                while (rdr.Read())
                {
                    lst.Add(new b22LoaiSach(int.Parse(rdr["iMaLoai"].ToString()), rdr["sLoaiSach"].ToString()));
                }
            }
            con.Close();
            return lst;
        }

        private void addTblLoaiSach()
        {
            int count = 0;
            while (count < 100)
            {
                SqlCommand cmd = new SqlCommand("addtblLoaiSach", con);
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter strLoaiSach = cmd.Parameters.Add("@sLoaiSach", SqlDbType.NVarChar, 60);
                strLoaiSach.Value = "Loại sách:" + (count + 1);
                con.Open();
                var result = cmd.ExecuteNonQuery();
                con.Close();
                count++;
            }
        }
    }
}