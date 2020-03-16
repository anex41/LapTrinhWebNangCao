using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LapTrinhWebNangCao.View.BTTH.Bai16
{
    public partial class SaveFile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            HttpPostedFile MyFile = Request.Files["UploadedFile"];
            //Setting location to upload files
            try
            {
                if (MyFile.ContentLength > 0)
                {
                    string fileName = "~/App_Data\\" + MyFile.FileName;
                    string filePath = Server.MapPath(fileName);
                    MyFile.SaveAs(filePath);
                    //Determining file name. You can format it as you wish.
                    //Determining file size.
                    //int FileSize = MyFile.ContentLength;
                    //Creating a byte array corresponding to file size.
                    //byte[] FileByteArray = new byte[FileSize];
                    //Posted file is being pushed into byte array.
                    //MyFile.InputStream.Read(FileByteArray, 0, FileSize);
                    //Uploading properly formatted file to server.
                    //MyFile.SaveAs(TargetLocation + FileName);
                    Response.Redirect("FileExplorer.aspx");
                }
            }
            catch (Exception BlueScreen)
            {
                Console.Write(BlueScreen);
                //Handle errors
            }
        }
    }
}