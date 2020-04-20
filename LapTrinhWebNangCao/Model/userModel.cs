using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LapTrinhWebNangCao.Model
{
    public class userModel
    {
        private int id;
        private string username;
        private string password;
        private int role;

        public int Id { get; set; }
        public string Username { get; set; }
        public string Password { get; set; }
        public int Role { get; set; }

        public userModel() { }

        public userModel(int id, string username, string password, int role)
        {
            Id = id;
            Username = username;
            Password = password;
            Role = role;
        }
    }
}