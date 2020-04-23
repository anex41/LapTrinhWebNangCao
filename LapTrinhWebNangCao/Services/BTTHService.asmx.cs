using LapTrinhWebNangCao.View.BTTH.Bai17;
using LapTrinhWebNangCao.View.BTTH.Bai22;
using LapTrinhWebNangCao.View.BTTH.Bai23;
using LapTrinhWebNangCao.View.BTTH.Bai24;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
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
        static readonly string connStr = ConfigurationManager.ConnectionStrings["myConStr"].ConnectionString;
        readonly SqlConnection con = new SqlConnection(connStr);

        [WebMethod(EnableSession = true)]
        public bool AddB17Session(List<B17Products> B17Products)
        {
            Session["B17Products"] = B17Products;
            return true;
        }

        [WebMethod(EnableSession = true)]
        public float EditB17Data(int id, int amount)
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
        public bool DeleteB17Data(int id)
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
        public Array GetB22LoaiSach()
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
        public Array GetB22Sach(int id)
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

        [WebMethod]
        public Array GetB24DisapprovedList(int id)
        {
            List<NewsHeaderB24> lst = new List<NewsHeaderB24>();
            SqlCommand cmd = new SqlCommand("getDisApprovedtblNews", con);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlParameter categoryID = cmd.Parameters.Add("category", SqlDbType.Int);
            categoryID.Value = id;
            con.Open();
            SqlDataReader rdr = cmd.ExecuteReader();
            if (rdr.FieldCount > 0)
            {
                while (rdr.Read())
                {
                    lst.Add(new NewsHeaderB24(int.Parse(rdr["iNewsID"].ToString()), rdr["sTitle"].ToString(), rdr["sCategoryName"].ToString()));
                }
            }
            con.Close();
            return lst.ToArray();
        }

        [WebMethod]
        public Array GetB24ApprovedList(int id)
        {
            List<NewsHeaderB24> lst = new List<NewsHeaderB24>();
            SqlCommand cmd = new SqlCommand("getApprovedtblNews", con);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlParameter categoryID = cmd.Parameters.Add("category", SqlDbType.Int);
            categoryID.Value = id;
            con.Open();
            SqlDataReader rdr = cmd.ExecuteReader();
            if (rdr.FieldCount > 0)
            {
                while (rdr.Read())
                {
                    lst.Add(new NewsHeaderB24(int.Parse(rdr["iNewsID"].ToString()), rdr["sTitle"].ToString(), rdr["sCategoryName"].ToString()));
                }
            }
            con.Close();
            return lst.ToArray();
        }

        [WebMethod]
        public void B24ApprovedNews(int id)
        {
            SqlCommand cmd = new SqlCommand("approveNews", con);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlParameter newID = cmd.Parameters.Add("id", SqlDbType.Int);
            newID.Value = id;
            con.Open();
            cmd.ExecuteReader();
            con.Close();
        }

        [WebMethod]
        public void B24DisApprovedNews(int id)
        {
            List<NewsHeaderB24> lst = new List<NewsHeaderB24>();
            SqlCommand cmd = new SqlCommand("DisApproveNews", con);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlParameter newID = cmd.Parameters.Add("id", SqlDbType.Int);
            newID.Value = id;
            con.Open();
            cmd.ExecuteReader();
            con.Close();
        }

        [WebMethod]
        public Array GetB24News(bool allFlag)
        {
            List<B24NewsContent> lst = new List<B24NewsContent>();
            SqlCommand cmd = new SqlCommand("getB24News", con);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlParameter f = cmd.Parameters.Add("flag", SqlDbType.Bit);
            f.Value = allFlag;
            con.Open();
            SqlDataReader rdr = cmd.ExecuteReader();
            if (rdr.FieldCount > 0)
            {
                while (rdr.Read())
                {

                    lst.Add(new B24NewsContent(
                        int.Parse(rdr["iNewsID"].ToString()),
                        rdr["sTitle"].ToString(),
                        rdr["sContent"].ToString(),
                        DateTime.Parse(rdr["tPostedDate"].ToString()).ToString("dd/MM/yyyy"),
                        int.Parse(rdr["iUserID"].ToString()),
                        rdr["sCategoryName"].ToString()
                        ));
                }
            }
            con.Close();
            return lst.ToArray();
        }

        [WebMethod(EnableSession = true)]
        public bool CheckB24LoginStatus()
        {
            bool result = true;
            if (Session["B24Login"] != null)
            {
                if (bool.Parse(Session["B24Login"].ToString()) == true)
                {
                    if (DateTime.Now < DateTime.Parse(Session["B24Time"].ToString()))
                    {
                        result = true;
                    }
                    else
                    {
                        result = false;
                    };
                }
                else
                {
                    result = false;
                }
            }
            else
            {
                result = false;
            }
            return result;
        }

        [WebMethod(EnableSession = true)]
        public int LoginB24(string name, string password)
        {
            int result = 1, time = 0;
            string resultPassword = "";
            SqlCommand cmd = new SqlCommand("getB24User", con);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlParameter un = cmd.Parameters.Add("name", SqlDbType.VarChar, 30);
            un.Value = name;
            con.Open();
            SqlDataReader rdr = cmd.ExecuteReader();
            if (rdr.FieldCount > 0)
            {
                while (rdr.Read())
                {
                    resultPassword = (rdr["sPassword"].ToString());
                    time = int.Parse(rdr["iLoginTimes"].ToString());
                }
            }
            else
            {
                result = -2;
                return result;
            };
            con.Close();
            if (string.Compare(HashString(password).ToLower(), resultPassword) == 0)
            {
                Session["B24Login"] = true;
                Session["B24Time"] = DateTime.Now.AddMinutes(time);
            }
            else
            {
                result = -1;
                return result;
            };
            return result;
        }
        
        [WebMethod(EnableSession = true)]
        public void SignOutB24()
        {
            if (Session["B24Login"] != null)
            {
                Session["B24Login"] = null;
            }
            if (Session["B24Time"] != null)
            {
                Session["B24Time"] = null;
            }
        }

        [WebMethod]
        public Array PopulateProducerListB23()
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
            return producerLst.ToArray();
        }
        
        [WebMethod]
        public int GetTotalRecordB23(int curProducer, float curSPrice, float curEPrice)
        {
            int result = 0;
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
                result = int.Parse(rdr["NumberOfProduct"].ToString());
            }
            con.Close();
           
            return result;
        }
        
        [WebMethod]
        public Array GetB23Data(int start, int end, float priceStart, float priceEnd, int prducerID)
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
            return lst.ToArray();
        }

        private string HashString(string input)
        {
            StringBuilder sb = new StringBuilder();
            foreach (byte b in GetHash(input))
                sb.Append(b.ToString("X2"));

            return sb.ToString();
        }

        private byte[] GetHash(string inputString)
        {
            using (HashAlgorithm algorithm = SHA256.Create())
                return algorithm.ComputeHash(Encoding.UTF8.GetBytes(inputString));
        }
    }
}
