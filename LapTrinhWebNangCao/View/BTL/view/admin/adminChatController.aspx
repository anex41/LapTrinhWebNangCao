﻿<%@ Page Title="ChatController" Language="C#" MasterPageFile="~/View/BTL/view/admin/adminMaster.Master" AutoEventWireup="true" CodeBehind="adminChatController.aspx.cs" Inherits="LapTrinhWebNangCao.View.BTL.view.admin.adminChatController" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder" runat="server">
    <section class="container-fluid position-absolute" style="height: calc(100% - 80px)">
        <div class="row position-absolute w-100 h-100">
            <div id="userListContent" class="col-sm-3 bg-danger">
            </div>
            <div class="col-sm-9">
                <div class="row h-100">
                    <div id="chatContent" class="chatContent col-sm-12" style="height: 90%;">
                    </div>
                    <div class="col-sm-12 chatInput" style="height: 10%;">
                        <div class="row h-100">
                            <button type="button" id="adminSendMessage" class="btn btn-success col-sm-2">Send</button>
                            <textarea class="col-sm-10 w-100" id="mesageContent"></textarea>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <script type="text/javascript" src="/Scripts/jquery.signalR-2.4.1.min.js"></script>
    <script type="text/javascript" src="/signalr/hubs"></script>
    <script type="text/javascript" src="/Scripts/chatScript.js"></script>
</asp:Content>
