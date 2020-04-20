using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LapTrinhWebNangCao.View.BTTH.Bai18
{
    public class succeedLoginDetail
    {
        private DateTime time;
        private string userName;

        public DateTime Time { get; set; }

        public string UserName { get; set; }

        public succeedLoginDetail(DateTime time, string userName)
        {
            Time = time;
            UserName = userName;
        }

        public succeedLoginDetail() { }
    }
}