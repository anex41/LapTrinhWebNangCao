using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LapTrinhWebNangCao.View.BTTH.Bai21
{
    public class driverNameInfo
    {
        private int id;
        private string name;

        public int Id { get; set; }
        public string Name { get; set; }

        public driverNameInfo() { }

        public driverNameInfo(int id, string name)
        {
            Id = id;
            Name = name;
        }
    }
}