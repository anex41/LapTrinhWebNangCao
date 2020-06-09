var name = "admin";
var role = "adminChat";
var message;
var adminPhone = "0ac6aeed8665fb0519dcbefe39180d3dbd4eaf8e5e6204ab9ddc5a5d75fb3605";
var phoneList = [];
var currentPhone = "";
$(document).ready(function () {
    var chat = $.connection.MyHub;

    chat.client.addChatMessage = function (name, message, role, phone) {
        message = message.replace(/</g, "&lt;").replace(/>/g, "&gt;");
        if (appendUsers(name, phone)) {
            addNewClientChatContent(name, message, role, phone);
        }
        else {
            if (name === "admin") {
                addAdminChatContent(name, message, role, currentPhone);
            }
            else {
                addClientChatContent(name, message, role, phone);
            }
        }
    };

    $.connection.hub.start().done(function () {
        chat.server.join(adminPhone);
        $('#adminSendMessage').click(function () {
            $('#adminSendMessage').prop('disabled', true);
            setTimeout(function () {
                $('#adminSendMessage').prop('disabled', false);
            }, 2000);
            message = $('#mesageContent').val();
            if (message.length > 0 || message !== null) {
                // Call the Send method on the hub.
                chat.server.sendMessage(name, message, role, currentPhone);
                // Clear text box and reset focus for next comment.
                $('#mesageContent').val('').focus();
                //divscrolldown();

            }
            else {
                return;
            }
        });
    });
});

function divscrolldown(phone) {
    var bottomDiv = document.getElementById("bottom" + phone + "ChatContent");
    bottomDiv.scrollIntoView({ behavior: "smooth" });
};

// thêm user vào listtab
function appendUsers(name, phone) {
    if (checkuser(name, phone) > 0) {
        $('#userListContent').append("<div id=\"" + phone + "\" class=\"userListMember\" onClick=\"getClientUser(this.id)\">" + name + "</div>");
        return true;
    }
    else {
        return false;
    }
};

//lấy User hiện tại
function getClientUser(id) {
    if (currentPhone === "0ac6aeed8665fb0519dcbefe39180d3dbd4eaf8e5e6204ab9ddc5a5d75fb3605") {
        currentPhone = id;
        $("#" + id + "div").removeAttr("hidden");
    } else {
        $("#" + currentPhone + "div").prop('hidden', true);
        currentPhone = id;
        $("#" + id + "div").removeAttr("hidden");
    }
    divscrolldown(id);
};

// Kiểm tra user đã tồn tại trong list user đã nhắn ?
function checkuser(name, phone) {
    let flag = true;
    let result = 1;
    if (name === "admin") {
        return -2;
    }
    if (!phoneList.length > 0) {
        phoneList.push(phone);
        return result;
    } else {
        phoneList.forEach(function (str) {
            if (str === phone) {
                flag = false;
                result = -1;
            }
        });
    }
    if (flag) phoneList.push(phone);
    return result;
}

// thêm chat phía admin
function addAdminChatContent(name, message, role, phone) {
    $("#" + phone + "div").append("<div class=\"w-100 mt-1 " + role + "Parent\"><div class=\"" + role + "Child\">" + message + "</div></div>");
    $('#bottom' + phone + 'ChatContent').remove();
    $("#" + phone + "div").append("<div id=\"bottom" + phone + "ChatContent\"></div>");
};

// thêm chat phía client (thêm mới)
function addNewClientChatContent(name, message, role, phone) {
    $('#chatContent').append("<section hidden id=\"" + phone + "div\">" + "</section>");
    $("#" + phone + "div").append("<div class=\"w-100 mt-1 " + role + "Parent\"><div class=\"" + role + "Child\">" + message + "</div></div>");
    $('#bottom' + phone + 'ChatContent').remove();
    $("#" + phone + "div").append("<div id=\"bottom" + phone + "ChatContent\"></div>");
};

// thêm chat phía Client
function addClientChatContent(name, message, role, phone) {
    $("#" + phone + "div").append("<div class=\"w-100 mt-1 " + role + "Parent\"><div class=\"" + role + "Child\">" + message + "</div></div>");
    $('#bottom' + phone + 'ChatContent').remove();
    $("#" + phone + "div").append("<div id=\"bottom" + phone + "ChatContent\"></div>");
};