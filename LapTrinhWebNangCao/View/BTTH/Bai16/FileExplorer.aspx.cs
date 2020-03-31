using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LapTrinhWebNangCao.View.BTTH.Bai16
{
    public partial class FileExplorer : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            DirectoryInfo dir;
            StringBuilder str = new StringBuilder();
            FileInfo[] files;
            dir = new DirectoryInfo(Server.MapPath("~/Assets/"));
            files = dir.GetFiles();
            foreach (FileInfo file in files)
            {
                //str.Append(@"<a href=FileExplorer.aspx?file=" + file.Name.ToString() + "'\">");
                str.Append("<a href=\"/../../../Assets\\" + file.Name.ToString() + "\" download=\"" + file.Name.ToString() + "\">");
                 str.Append(file.Name.ToString() + "</a><br />");
            }
            Response.Write(str.ToString());
        }
    }
}