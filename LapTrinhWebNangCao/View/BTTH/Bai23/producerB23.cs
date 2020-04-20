using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LapTrinhWebNangCao.View.BTTH.Bai23
{
    public class producerB23
    {
        private int id;
        private string name;

        public int Id { get; set; }
        public string Name { get; set; }

        public producerB23() { }

        public producerB23(int id, string name)
        {
            Id = id;
            Name = name;
        }
    }
}