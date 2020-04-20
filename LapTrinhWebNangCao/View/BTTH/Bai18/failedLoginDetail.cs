using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LapTrinhWebNangCao.View.BTTH.Bai18
{
    public class failedLoginDetail
    {
        private bool lockFlag;
        private string userName;
        private DateTime timeOut;
        private int strike;

        public bool LockFlag { get; set; }

        public DateTime TimeOut { get; set; }

        public int Strike { get; set; }
        public string UserName { get; set; }

        public failedLoginDetail() { }

        public failedLoginDetail(bool lockFlag, DateTime timeOut, int strike, string userName)
        {
            LockFlag = lockFlag;
            TimeOut = timeOut;
            Strike = strike;
            UserName = userName;
        }
    }
}