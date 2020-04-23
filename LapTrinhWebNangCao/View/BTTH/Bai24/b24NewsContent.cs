using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;

namespace LapTrinhWebNangCao.View.BTTH.Bai24
{
    public class B24NewsContent
    {
        private int id;
        private string title;
        private string content;
        private string postedDate;
        private int userID;
        private string categoryName;

        public int Id { get; set; }
        public string Title { get; set; }
        public string Content { get; set; }
        public string PostedDate { get; set; }
        public int UserID { get; set; }
        public string CategoryName { get; set; }
        public B24NewsContent() { }
        public B24NewsContent(int id, string title, string content, string postedDate, int userID, string categoryName)
        {
            Id = id;
            Title = title;
            Content = content;
            PostedDate = postedDate;
            UserID = userID;
            CategoryName = categoryName;
        }
    }
}