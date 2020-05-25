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
        private string displayname;
        private string phonenumber;
        private string email;
        private int statusflag;
        private int role;

        public int Id { get; set; }
        public string Username { get; set; }
        public string Password { get; set; }
        public string Displayname { get; set; }
        public string Phonenumber { get; set; }
        public string Email { get; set; }
        public int Statusflag { get; set; }
        public int Role { get; set; }

        public userModel() { }

        public userModel(int id, string username, string password, string displayname, string phonenumber, string email, int statusflag, int role)
        {
            Id = id;
            Username = username;
            Password = password;
            Displayname = displayname;
            Phonenumber = phonenumber;
            Email = email;
            Statusflag = statusflag;
            Role = role;
        }
    }
}