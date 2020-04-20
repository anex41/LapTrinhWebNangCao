using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LapTrinhWebNangCao.View.BTTH.Bai23
{
    public class phoneData
    {
        private int id;
        private int soLuong;
        private int nSXId;
        private float price;
        private string name;

        public int Id { get; set; }
        public int SoLuong { get; set; }
        public int NSXId { get; set; }
        public float Price { get; set; }
        public string Name { get; set; }

        public phoneData() { }

        public phoneData(int id, int soLuong, int nSXId, float price, string name)
        {
            Id = id;
            SoLuong = soLuong;
            NSXId = nSXId;
            Price = price;
            Name = name;
        }
    }
}