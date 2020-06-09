using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LapTrinhWebNangCao.Model
{
    public class ProductModel
    {
        private int id;
        private string name;
        private string description;
        private int catalog;
        private int status;
        private int seenNumber;
        private DateTime addedDate;
        private float price;
        private string address;
        private string content;
        private string user;
        private string city;
        private string district;

        public int Id { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public int Catalog { get; set; }
        public int Status { get; set; }
        public int SeenNumber { get; set; }
        public DateTime AddedDate { get; set; }
        public float Price { get; set; }
        public string Address { get; set; }
        public string Content { get; set; }
        public string User { get; set; }
        public string City { get; set; }
        public string District { get; set; }

        public ProductModel() { }

        public ProductModel(int id, string name, string description, int catalog,
            int status, int seenNumber, DateTime addedDate, float price,
            string address, string content, string user, string city, string district)
        {
            Id = id;
            Name = name;
            Description = description;
            Catalog = catalog;
            Status = status;
            SeenNumber = seenNumber;
            AddedDate = addedDate;
            Price = price;
            Address = address;
            Content = content;
            User = user;
            City = city;
            District = district;
        }
    }
}