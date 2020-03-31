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
    public partial class SaveFile : System.Web.UI.Page
    {
        List<string> filename = new List<string>();
        protected void Page_Load(object sender, EventArgs e)
        {
            HttpPostedFile MyFile = Request.Files["UploadedFile"];
            //Setting location to upload files
            try
            {
                if (MyFile.ContentLength > 0)
                {
                    string fileName = "~/Assets\\" + MyFile.FileName;
                    string filePath = Server.MapPath(fileName);
                    //Determining file name. You can format it as you wish.
                    //Determining file size.
                    int FileSize = MyFile.ContentLength;
                    //Creating a byte array corresponding to file size.
                    int x = FileSize / 1024 / 1024;
                    if (!validateFileName(getListofName(), MyFile.FileName))
                    {
                        Response.Redirect("FileChooser.htm?id=1");
                    }
                    //byte[] FileByteArray = new byte[FileSize];
                    if (x < 3)
                    {
                        MyFile.SaveAs(filePath);
                        Response.Redirect("FileExplorer.aspx");
                    }
                    //Posted file is being pushed into byte array.
                    //MyFile.InputStream.Read(FileByteArray, 0, FileSize);
                    //Uploading properly formatted file to server.
                    //MyFile.SaveAs(TargetLocation + FileName);
                    Response.Redirect("FileChooser.htm?id=-1");
                }
            }
            catch (Exception BlueScreen)
            {
                Console.Write(BlueScreen);
                //Handle errors
            }
        }
        private Array getListofName()
        {
            DirectoryInfo dir;
            FileInfo[] files;
            dir = new DirectoryInfo(Server.MapPath("~/Assets/"));
            files = dir.GetFiles();
            foreach (FileInfo file in files)
            {
                var temp = file.Name;
                filename.Add(temp);
            }
            return filename.ToArray();
        }

        private bool validateFileName(Array x, string name)
        {
            var result = true;
            foreach (string str in x)
            {
                if(name == str)
                {
                    result = false;
                }
            }
            return result;
        }
    }
}