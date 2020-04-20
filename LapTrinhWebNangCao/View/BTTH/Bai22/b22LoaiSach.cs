using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LapTrinhWebNangCao.View.BTTH.Bai22
{
    public class b22LoaiSach
    {
        private int id;
        private string loaiSach;

        public int Id { get; set; }

        public string LoaiSach { get; set; }

        public b22LoaiSach() { }

        public b22LoaiSach(int id, string loaiSach)
        {
            Id = id;
            LoaiSach = loaiSach;
        }
    }
}