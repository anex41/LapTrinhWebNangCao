using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LapTrinhWebNangCao.View.BTTH.Bai17
{
    public class B17Products
    {
        private int b17id;
        private string b17Name;
        private int b17Amount;
        private float b17Money;

        public int B17id { get => b17id; set => b17id = value; }
        public string B17Name { get => b17Name; set => b17Name = value; }
        public int B17Amount { get => b17Amount; set => b17Amount = value; }
        public float B17Money { get => b17Money; set => b17Money = value; }

        public B17Products()
        {
        }

        public B17Products(int b17id, string b17Name, int b17Amount, float b17Money)
        {
            this.B17id = b17id;
            this.B17Name = b17Name;
            this.B17Amount = b17Amount;
            this.b17Money = b17Money;
        }

        //public List<B17Products> populateB17Products()
        //{
        //    
        //}
    }
}