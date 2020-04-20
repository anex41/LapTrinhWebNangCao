using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LapTrinhWebNangCao.View.BTTH.Bai21
{
    public class ratingInfo
    {
        private int id;
        private DateTime ratingDate;
        private int ratingPoint;

        public int Id { get; set; }
        public DateTime RatingDate { get; set; }
        public int RatingPoint { get; set; }

        public ratingInfo() { }

        public ratingInfo(int id, DateTime ratingDate, int ratingPoint)
        {
            Id = id;
            RatingDate = ratingDate;
            RatingPoint = ratingPoint;
        }
    }
}