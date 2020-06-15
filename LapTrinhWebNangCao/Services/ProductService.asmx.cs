using LapTrinhWebNangCao.Model;
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
    /// Summary description for ProductService
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]
    public class ProductService : System.Web.Services.WebService
    {
        static string connStr = ConfigurationManager.ConnectionStrings["myConStr"].ConnectionString;
        SqlConnection con = new SqlConnection(connStr);

        [WebMethod]
        public Array GetAllProducts(string type)
        {
            List<ProductModel> pml = new List<ProductModel>();
            if (type == "default")
            {
                SqlCommand cmd = new SqlCommand("getAllProducts", con);
                cmd.CommandType = CommandType.StoredProcedure;
                con.Open();
                SqlDataReader rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    ProductModel pm = new ProductModel();
                    pm.Id = (int)rdr["productId"];
                    pm.Name = (string)rdr["productName"];
                    pm.Description = (string)rdr["productDescription"];
                    pm.Catalog = (int)rdr["productCatalog"];
                    pm.Status = (int)rdr["productStatus"];
                    pm.SeenNumber = (int)rdr["productSeenNumber"];
                    pm.AddedDate = DateTime.Parse(rdr["productAddedDate"].ToString());
                    pm.Price = float.Parse(rdr["productPrice"].ToString());
                    pm.Address = (string)rdr["ProductAddress"];
                    pm.City = (string)rdr["cityName"];
                    pm.District = (string)rdr["districtName"];
                    pm.User = (string)rdr["displayName"];
                    pml.Add(pm);
                };
                con.Close();
            }
            return pml.ToArray();
        }

        [WebMethod]
        public ProductModel GetProductById(string id)
        {
            var x = int.Parse(id);
            ProductModel pm = new ProductModel();
            SqlCommand cmd = new SqlCommand("getProductById", con);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlParameter identity = cmd.Parameters.Add("identity", SqlDbType.Int);
            identity.Value = x;
            con.Open();
            SqlDataReader rdr = cmd.ExecuteReader();
            while (rdr.Read())
            {
                pm.Id = (int)rdr["productId"];
                pm.Name = (string)rdr["productName"];
                pm.Description = (string)rdr["productDescription"];
                pm.Catalog = (int)rdr["productCatalog"];
                pm.Status = (int)rdr["productStatus"];
                pm.SeenNumber = (int)rdr["productSeenNumber"];
                pm.AddedDate = DateTime.Parse(rdr["productAddedDate"].ToString());
                pm.Price = float.Parse(rdr["productPrice"].ToString());
                pm.Address = (string)rdr["ProductAddress"];
                pm.Content = (string)rdr["ProductContent"];
                pm.City = (string)rdr["cityName"];
                pm.District = (string)rdr["districtName"];
                pm.User = (string)rdr["displayName"];
            };
            con.Close();
            return pm;
        }

        [WebMethod(EnableSession = true)]
        public void CreateNewProduct(string name, string des, int catalog, string date, float price, string address, string content, int district)
        {
            string user = Session["userID"].ToString();
            SqlCommand cmd = new SqlCommand("addProduct", con);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlParameter Name = cmd.Parameters.Add("name", SqlDbType.NVarChar, 100);
            Name.Value = name;
            SqlParameter Description = cmd.Parameters.Add("desription", SqlDbType.NText);
            Description.Value = des;
            SqlParameter Catalog = cmd.Parameters.Add("catalog", SqlDbType.Int);
            Catalog.Value = catalog;
            SqlParameter Date = cmd.Parameters.Add("addedDate", SqlDbType.Date);
            Date.Value = date;
            SqlParameter Price = cmd.Parameters.Add("price", SqlDbType.Float);
            Price.Value = price;
            SqlParameter Address = cmd.Parameters.Add("address", SqlDbType.NVarChar, 200);
            Address.Value = address;
            SqlParameter Content = cmd.Parameters.Add("content", SqlDbType.NText);
            Content.Value = content;
            SqlParameter District = cmd.Parameters.Add("district", SqlDbType.Int);
            District.Value = district;
            SqlParameter uid = cmd.Parameters.Add("userid", SqlDbType.Int);
            uid.Value = user;
            con.Open();
            SqlDataReader rdr = cmd.ExecuteReader();
            con.Close();
            return;
        }

        [WebMethod]
        public Array GetEditProductList()
        {
            List<ProductModel> pml = new List<ProductModel>();
            SqlCommand cmd = new SqlCommand("getEditProduct", con);
            cmd.CommandType = CommandType.StoredProcedure;
            con.Open();
            SqlDataReader rdr = cmd.ExecuteReader();
            while (rdr.Read())
            {
                ProductModel pm = new ProductModel();
                pm.Id = (int)rdr["productId"];
                pm.Name = (string)rdr["productName"];
                pm.Description = (string)rdr["productDescription"];
                pm.Catalog = (int)rdr["productCatalog"];
                pm.Status = (int)rdr["productStatus"];
                pm.SeenNumber = (int)rdr["productSeenNumber"];
                pm.AddedDate = DateTime.Parse(rdr["productAddedDate"].ToString());
                pm.Price = float.Parse(rdr["productPrice"].ToString());
                pm.Address = (string)rdr["ProductAddress"];
                pm.City = (string)rdr["cityName"];
                pm.District = (string)rdr["districtName"];
                pm.User = (string)rdr["displayName"];
                pml.Add(pm);
            };
            con.Close();
            return pml.ToArray();
        }

        [WebMethod]
        public ProductModel GetEditProductById(string id)
        {
            var x = int.Parse(id);
            ProductModel pm = new ProductModel();
            SqlCommand cmd = new SqlCommand("getEditProductById", con);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlParameter identity = cmd.Parameters.Add("identity", SqlDbType.Int);
            identity.Value = x;
            con.Open();
            SqlDataReader rdr = cmd.ExecuteReader();
            while (rdr.Read())
            {
                pm.Id = (int)rdr["productId"];
                pm.Name = (string)rdr["productName"];
                pm.Description = (string)rdr["productDescription"];
                pm.Catalog = (int)rdr["productCatalog"];
                pm.Status = (int)rdr["productStatus"];
                pm.SeenNumber = (int)rdr["productSeenNumber"];
                pm.AddedDate = DateTime.Parse(rdr["productAddedDate"].ToString());
                pm.Price = float.Parse(rdr["productPrice"].ToString());
                pm.Address = (string)rdr["ProductAddress"];
                pm.Content = (string)rdr["ProductContent"];
                pm.City = rdr["cityId"].ToString();
                pm.District = (string)rdr["districtId"].ToString();
                pm.User = (string)rdr["displayName"];
            };
            con.Close();
            return pm;
        }

        [WebMethod]
        public void ApproveProduct(string value)
        {
            SqlCommand cmd = new SqlCommand("approveProduct", con);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlParameter identity = cmd.Parameters.Add("identity", SqlDbType.Int);
            identity.Value = value;
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
            return;
        }

        [WebMethod]
        public void DisapproveProduct(string value)
        {
            SqlCommand cmd = new SqlCommand("disapproveProduct", con);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlParameter identity = cmd.Parameters.Add("identity", SqlDbType.Int);
            identity.Value = value;
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
            return;
        }

        [WebMethod]
        public Array GetDisapproveProduct()
        {
            List<ProductModel> pml = new List<ProductModel>();
            SqlCommand cmd = new SqlCommand("getDisapproveProduct", con);
            cmd.CommandType = CommandType.StoredProcedure;
            con.Open();
            SqlDataReader rdr = cmd.ExecuteReader();
            while (rdr.Read())
            {
                ProductModel pm = new ProductModel();
                pm.Id = (int)rdr["productId"];
                pm.Name = (string)rdr["productName"];
                pm.Description = (string)rdr["productDescription"];
                pm.Catalog = (int)rdr["productCatalog"];
                pm.Status = (int)rdr["productStatus"];
                pm.SeenNumber = (int)rdr["productSeenNumber"];
                pm.AddedDate = DateTime.Parse(rdr["productAddedDate"].ToString());
                pm.Price = float.Parse(rdr["productPrice"].ToString());
                pm.Address = (string)rdr["ProductAddress"];
                pm.City = (string)rdr["cityName"];
                pm.District = (string)rdr["districtName"];
                pm.User = (string)rdr["displayName"];
                pml.Add(pm);
            };
            con.Close();
            return pml.ToArray();
        }

        [WebMethod]
        public Array getApproveProduct()
        {
            List<ProductModel> pml = new List<ProductModel>();
            SqlCommand cmd = new SqlCommand("getApproveProduct", con);
            cmd.CommandType = CommandType.StoredProcedure;
            con.Open();
            SqlDataReader rdr = cmd.ExecuteReader();
            while (rdr.Read())
            {
                ProductModel pm = new ProductModel();
                pm.Id = (int)rdr["productId"];
                pm.Name = (string)rdr["productName"];
                pm.Description = (string)rdr["productDescription"];
                pm.Catalog = (int)rdr["productCatalog"];
                pm.Status = (int)rdr["productStatus"];
                pm.SeenNumber = (int)rdr["productSeenNumber"];
                pm.AddedDate = DateTime.Parse(rdr["productAddedDate"].ToString());
                pm.Price = float.Parse(rdr["productPrice"].ToString());
                pm.Address = (string)rdr["ProductAddress"];
                pm.City = (string)rdr["cityName"];
                pm.District = (string)rdr["districtName"];
                pm.User = (string)rdr["displayName"];
                pml.Add(pm);
            };
            con.Close();
            return pml.ToArray();
        }
        
        [WebMethod(EnableSession = true)]
        public void editProduct(string name, string des, int catalog, string date, float price, string address, string content, int district, int value)
        {
            string userID = Session["userID"].ToString();
            SqlCommand cmd = new SqlCommand("editProduct", con);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlParameter IDValue = cmd.Parameters.Add("identity", SqlDbType.Int);
            IDValue.Value = value;
            SqlParameter Name = cmd.Parameters.Add("name", SqlDbType.NVarChar, 100);
            Name.Value = name;
            SqlParameter Description = cmd.Parameters.Add("desription", SqlDbType.NText);
            Description.Value = des;
            SqlParameter Catalog = cmd.Parameters.Add("catalog", SqlDbType.Int);
            Catalog.Value = catalog;
            SqlParameter Date = cmd.Parameters.Add("addedDate", SqlDbType.Date);
            Date.Value = date;
            SqlParameter Price = cmd.Parameters.Add("price", SqlDbType.Float);
            Price.Value = price;
            SqlParameter Address = cmd.Parameters.Add("address", SqlDbType.NVarChar, 200);
            Address.Value = address;
            SqlParameter Content = cmd.Parameters.Add("content", SqlDbType.NText);
            Content.Value = content;
            SqlParameter District = cmd.Parameters.Add("district", SqlDbType.Int);
            District.Value = district;
            SqlParameter uid = cmd.Parameters.Add("userid", SqlDbType.Int);
            uid.Value = userID;
            con.Open();
            SqlDataReader rdr = cmd.ExecuteReader();
            con.Close();
        }
    }
}