<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Chat.ascx.cs" Inherits="LapTrinhWebNangCao.View.BTL.userControl.chat" %>
<button type="button" id="open" class="btn btn-info w-100">Click here to chat with us</button>
<div hidden id="registerClientDiv" class="p-1">
    <div class="col-sm-12 mb-1">
        <div class="form-group">
            <label for="exampleFormControlInput1">Tên</label>
            <input type="text" class="form-control" id="chatName">
        </div>
    </div>
    <div class="col-sm-12 mb-1">
        <div class="form-group">
            <label for="exampleFormControlInput1">Địa chỉ Email</label>
            <input type="email" class="form-control" id="chatEmail">
        </div>
    </div>
    <div class="text-right">
        <button type="button" id="setClient" class="btn btn-info">OK</button>
    </div>
</div>
<div hidden id="chatClientDiv" class="p-1">
    <div class="col-sm-12 mb-1">
        <div class="form-group">
            <label id="chatClientName">Tên</label>
        </div>
    </div>
    <div id="chatContent" class="container-fluid chatContent">
    </div>
    <div class="container row mb-1">
        <div class="col-sm-12">
            <label for="exampleFormControlInput1">Nội Dung</label>
        </div>
        <div class="col-sm-10 form-group">
            <textarea class="form-control" style="height: 40px; resize: none;" id="messageContent"></textarea>
        </div>
        <div class="col-sm-2">
            <button type="button" id="sendMessage" class="btn btn-success">Send</button>
        </div>
    </div>
</div>
<script type="text/javascript" src="/Scripts/jquery.signalR-2.4.1.min.js"></script>
<script type="text/javascript" src="/signalr/hubs"></script>
<script>
    $(document).ready(function () {
        var name;
        var message;
        var role = "clientChat";
        var chat = $.connection.MyHub;

        chat.client.addChatMessage = function (name, message, role, email) {
            message = message.replace(/</g, "&lt;").replace(/>/g, "&gt;");
            $('#chatContent').append("<div class=\"w-100 mt-1 " + role + "Parent\"><div class=\"" + role + "Child\">" + message + "</div></div>");
            $('#bottomChatContent').remove();
            $('#chatContent').append("<div id=\"bottomChatContent\"></div>");
            divscrolldown();
        };

        $("#open").on("click", function () {
            $("#open").hide();
            $('#registerClientDiv').removeAttr('hidden');
        });

        //chat.client.broadcastMessage = function (name, message, role) {
        //    // Add the message to the page.
        //    $('#chatContent').append("<div class=\"w-100 mt-1 " + role + "Parent\"><div class=\"" + role + "Child\">" + message + "</div></div>");
        //    $('#bottomChatContent').remove();
        //    $('#chatContent').append("<div id=\"bottomChatContent\"></div>");
        //    divscrolldown();
        //};

        $.connection.hub.start().done(function () {
            $('#sendMessage').click(function () {
                $('#sendMessage').prop('disabled', true);
                setTimeout(function () {
                    $('#sendMessage').prop('disabled', false);
                }, 2000);
                message = $('#messageContent').val();
                if (message.length > 0 || message !== null) {
                    // Call the Send method on the hub.
                    chat.server.sendMessage(name, message, role, email);
                    // Clear text box and reset focus for next comment.
                    $('#messageContent').val('').focus();
                    //divscrolldown();

                }
                else {
                    return;
                }
            });

            $("#setClient").on("click", function () {
                $('#chatClientName').html("Người dùng: " + $('#chatName').val());
                name = $('#chatName').val();
                email = $('#chatEmail').val();
                $("#registerClientDiv").hide();
                $('#chatClientDiv').removeAttr('hidden');
                chat.server.join(email);
            });
        });
    });

    function divscrolldown() {
        var bottomDiv = document.getElementById("bottomChatContent");
        bottomDiv.scrollIntoView({ behavior: "smooth" });
    }
</script>
