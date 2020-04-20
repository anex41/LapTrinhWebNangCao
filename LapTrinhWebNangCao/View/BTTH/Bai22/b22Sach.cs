using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LapTrinhWebNangCao.View.BTTH.Bai22
{
    public class b22Sach
    {
        private int maSach;
        private int maLoai;
        private string tenSach;
        private string tenLoai;

        public int MaSach { get; set; }
        public int MaLoai { get; set; }
        public string TenSach { get; set; }
        public string TenLoai { get; set; }

        public b22Sach() { }

        public b22Sach(int maSach, int maLoai, string tenSach, string tenLoai)
        {
            MaSach = maSach;
            MaLoai = maLoai;
            TenSach = tenSach;
            TenLoai = tenLoai;
        }
    }
}