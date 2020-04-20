using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LapTrinhWebNangCao.View.BTTH.Bai19
{
    public class Class
    {
        private int id;
        private string name;

        public int Id { get; set; }

        public string Name { get; set; }

        public Class(int id, string name)
        {
            Id = id;
            Name = name;
        }
    }
}