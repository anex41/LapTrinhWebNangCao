using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LapTrinhWebNangCao.View.BTTH.Bai21
{
    public class driverB21
    {
        private int id;
        private string name;
        private bool gender;
        private DateTime birthday;
        private string address;

        public int Id { get; set; }
        public string Name { get; set; }
        public bool Gender { get; set; }
        public DateTime Birthday { get; set; }
        public string Address { get; set; }

        public driverB21() { }

        public driverB21(int id, string name, bool gender, DateTime birthday, string address)
        {
            Id = id;
            Name = name;
            Gender = gender;
            Birthday = birthday;
            Address = address;
        }
    }
}