using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;

namespace LapTrinhWebNangCao.View.BTTH
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        private string hoten,ns,gender;
        public string HoTens { get { return hoten; } }
        public string Ngaysinh { get { return ns; } }
        public string genders { get { return gender; } }

        protected void Page_Load(object sender, EventArgs e)
        {
            hoten = Request.Params["hoten"];
            ns = Request.Params["ns"];
            gender = Request.Params["gender"];


            string XML = "<xml>" + "<stringA>" + hoten + "</stringA>" + "<stringB>" + ns + "</stringB>" + "<stringC>" + gender + "</stringC></xml>";
            //?xml version =\"1.0\" encoding=\"utf-8\"?
            Response.Buffer = true;
            Response.ClearContent();
            Response.ClearHeaders();
            Response.ContentType = "text/xml";
            Response.Write(XML);
            Response.End();   //Stop all other output to the browser
            //XmlDocument doc = new XmlDocument();
            //doc.LoadXml(XML);
            //Response.Clear();
            ////Response.ContentType = "text/xml";
            //Response.ContentEncoding = System.Text.Encoding.UTF8;

            ////Response.Charset = "UTF-8";
            //Response.Write(XML);
            //Response.ContentType = "application/xml";
            ////Response.Write(Server.HtmlEncode(doc));
            //Response.End();
        }

    }
}