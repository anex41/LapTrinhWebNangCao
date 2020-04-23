using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LapTrinhWebNangCao.View.BTTH.Bai24
{
    public class NewsHeaderB24
    {
        private int id;
        private string name;
        private string categoryName;
        public int Id { get; set; }
        public string Name { get; set; }
        public string CategoryName { get; set; }
        public NewsHeaderB24() { }
        public NewsHeaderB24(int id, string name, string categoryName)
        {
            Id = id;
            Name = name;
            CategoryName = categoryName;
        }
    }
}