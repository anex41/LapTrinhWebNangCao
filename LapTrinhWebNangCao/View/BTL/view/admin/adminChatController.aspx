<%@ Page Title="ChatController" Language="C#" MasterPageFile="~/View/BTL/view/admin/adminMaster.Master" AutoEventWireup="true" CodeBehind="adminChatController.aspx.cs" Inherits="LapTrinhWebNangCao.View.BTL.view.admin.adminChatController" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder" runat="server">
    <section class="container-fluid">
        <div class="row">
            <div class="col-sm-3 bg-danger">
                User this user that
            </div>
            <div class="col-sm-9">
                <div class="row">
                    <div id="chatContent" class="chatContent col-sm-12">
                    </div>
                    <div class="col-sm-12 chatInput">
                        <div class="row">
                            <button type="button" id="adminSendMessage" class="btn btn-success col-sm-2">Send</button>
                            <textarea class="col-sm-10 w-100" id="mesageContent"></textarea>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <script type="text/javascript" src="/Scripts/jquery.signalR-2.2.2.min.js"></script>
    <script type="text/javascript" src="/signalr/hubs"></script>
    <script>
        $(document).ready(function () {
            var name = "admin";
            var message;
            var chat = $.connection.MyHub;
            chat.client.broadcastMessage = function (name, message) {
                // Add the message to the page.
                $('#chatContent').append("<p class=\"bg-success\">" + message + "</p>");
            };

            $.connection.hub.start().done(function () {
                $('#adminSendMessage').click(function () {
                    $('#adminSendMessage').prop('disabled', true);
                    setTimeout(function () {
                        $('#adminSendMessage').prop('disabled', false);
                    }, 2000);
                    message = $('#mesageContent').val();
                    if (message.length > 0 || message !== null) {
                        // Call the Send method on the hub.
                        chat.server.send(name, message);
                        // Clear text box and reset focus for next comment.
                        $('#mesageContent').val('').focus();
                        divscrolldown();
                    }
                    else {
                        chat.server.send(name, 'Không điền gì à Địt mẹ m');
                        $('#mesageContent').val('').focus();
                        divscrolldown();
                    }
                });
            });
        });

        function divscrolldown() {
            setTimeout(function () {
                $('#chatContent').animate({
                    scrollTop: $("#chatContent").offset().top
                }, 500);

            }, 200)
        };
    </script>
</asp:Content>
