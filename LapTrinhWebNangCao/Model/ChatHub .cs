using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using Microsoft.AspNet.SignalR;
using Microsoft.AspNet.SignalR.Hubs;

namespace LapTrinhWebNangCao
{
    [HubName("MyHub")]
    public class ChatHub : Hub
    {
        static bool adminFlag = false;
        static string connectionID = "";
        //public override Task OnConnected()
        //{
        //    return base.OnConnected();
        //}
        public void Send(string name, string message, string role)
        {
            // Call the broadcastMessage method to update clients.
            Clients.All.broadcastMessage(name, message, role);
        }

        public void Join(string groupName)
        {
            if (groupName == "0ac6aeed8665fb0519dcbefe39180d3dbd4eaf8e5e6204ab9ddc5a5d75fb3605")
            {
                connectionID = Context.ConnectionId;
                adminFlag = true;
            }
            if (adminFlag == true)
            {
                Groups.Add(Context.ConnectionId, groupName);
                Groups.Add(connectionID, groupName);
            }
            else
            {
                Groups.Add(Context.ConnectionId, groupName);
            }
        }
        public void SendMessage(string name, string message, string role, string roomname)
        {
            //Clients.All.addContosoChatMessageToPage(name, message);
            //Clients.Caller.receiveMessage(name, message, role);
            Clients.Group(roomname).addChatMessage(name, message, role, roomname);
        }
    }
}