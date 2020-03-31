using LapTrinhWebNangCao.View.BTTH.Bai17;
using System;
using System.Collections.Generic;
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

        [WebMethod]
        public string HelloWorld()
        {
            return "Hello World";
        }

        [WebMethod(EnableSession = true)]
        public bool AddSession(List<B17Products> B17Products)
        {
            Session["B17Products"] = B17Products;
            return true;
        }
    }
}
