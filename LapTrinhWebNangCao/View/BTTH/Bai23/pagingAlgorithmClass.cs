using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LapTrinhWebNangCao.View.BTTH.Bai23
{
    public class pagingAlgorithmClass
    {
        private int pageSize;
        private int totalPage;
        private int totalRecord;
        private int pageIndex;
        private int startingPoint;
        private int endingPoint;

        public int TotalPage { get; set; }
        public int PageSize { get; set; }
        public int TotalRecord { get; set; }
        public int PageIndex { get; set; }
        public int StartingPoint { get; set; }
        public int EndingPoint { get; set; }

        public pagingAlgorithmClass() { }

        public pagingAlgorithmClass(int totalPage,int pageSize,  int totalRecord, int pageIndex, int startingPoint, int endingPoint)
        {
            TotalPage = totalPage;
            PageSize = pageSize;
            TotalRecord = totalRecord;
            PageIndex = pageIndex;
            StartingPoint = startingPoint;
            EndingPoint = endingPoint;
        }
    }
}