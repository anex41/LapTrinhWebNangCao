using LapTrinhWebNangCao.View.BTTH.Bai17;
using LapTrinhWebNangCao.View.BTTH.Bai22;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;

namespace LapTrinhWebNangCao.Services
{
    /// <summary>
    /// Summary description for BTTHService
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]
    public class BTTHService : System.Web.Services.WebService
    {
        static string connStr = ConfigurationManager.ConnectionStrings["myConStr"].ConnectionString;
        SqlConnection con = new SqlConnection(connStr);

        [WebMethod]
        public string HelloWorld()
        {
            return "Hello World";
        }

        [WebMethod(EnableSession = true)]
        public bool AddB17Session(List<B17Products> B17Products)
        {
            Session["B17Products"] = B17Products;
            return true;
        }

        [WebMethod(EnableSession = true)]
        public float editB17Data(int id, int amount)
        {
            bool flag = true;
            List<B17Products> lst = Session["B17Products"] as List<B17Products>;
            // loop through list to find item
            foreach (B17Products item in lst)
            {
                if (item.B17id == id)
                {
                    if (item.B17Amount == amount)
                    {
                        flag = true;
                        // ammount not changed
                        return -2;
                    }
                    else
                    {
                        flag = true;
                        item.B17Amount = amount;
                        Session["B17Products"] = lst;
                        //change succeed
                        return 1;
                    }
                }
                else
                {
                    flag = false;
                }
            }
            // cannot find item
            if (!flag) return -1;
            // default return
            return 0;
        }

        [WebMethod(EnableSession = true)]
        public bool deleteB17Data(int id)
        {
            bool flag = true;
            List<B17Products> lst = Session["B17Products"] as List<B17Products>;
            // loop through list to find item
            foreach (B17Products item in lst)
            {
                if (item.B17id == id)
                {
                    lst.Remove(item);
                    flag = true;
                    Session["B17Products"] = lst;
                    break;
                }
                else flag = false;
            }
            if (lst.Count == 0)
            {
                Session["B17Products"] = null;
            }
            return flag;
        }

        [WebMethod]
        public Array getB22LoaiSach()
        {
            List<b22LoaiSach> lst = new List<b22LoaiSach>();
            SqlCommand cmd = new SqlCommand("gettblLoaiSach", con);
            cmd.CommandType = CommandType.StoredProcedure;
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
            return lst.ToArray();
        }

        [WebMethod]
        public Array getB22Sach(int id)
        {
            List<b22Sach> lst = new List<b22Sach>();
            SqlCommand cmd = new SqlCommand("gettblSach", con);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlParameter identity = cmd.Parameters.Add("identity", SqlDbType.Int);
            identity.Value = id;
            con.Open();
            SqlDataReader rdr = cmd.ExecuteReader();
            if (rdr.FieldCount > 0)
            {
                while (rdr.Read())
                {
                    lst.Add(new b22Sach(int.Parse(rdr["iMaSach"].ToString()), int.Parse(rdr["iMaLoai"].ToString()), rdr["sTenSach"].ToString(), rdr["sLoaiSach"].ToString()));
                }
            }
            con.Close();
            return lst.ToArray();
        }
    }
}
