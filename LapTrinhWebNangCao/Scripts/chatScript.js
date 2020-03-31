var name = "admin";
var role = "adminChat";
var message;
var adminEmail = "0ac6aeed8665fb0519dcbefe39180d3dbd4eaf8e5e6204ab9ddc5a5d75fb3605";
var emailList = [];
var currentEmail = "";
$(document).ready(function () {
    var chat = $.connection.MyHub;

    chat.client.addChatMessage = function (name, message, role, email) {
        message = message.replace(/</g, "&lt;").replace(/>/g, "&gt;");
        if (appendUsers(name, email)) {
            addNewClientChatContent(name, message, role, email);
        }
        else {
            if (name === "admin") {
                addAdminChatContent(name, message, role, currentEmail);
            }
            else {
                addClientChatContent(name, message, role, email);
            }
        }
    };

    $.connection.hub.start().done(function () {
        chat.server.join(adminEmail);
        $('#adminSendMessage').click(function () {
            $('#adminSendMessage').prop('disabled', true);
            setTimeout(function () {
                $('#adminSendMessage').prop('disabled', false);
            }, 2000);
            message = $('#mesageContent').val();
            if (message.length > 0 || message !== null) {
                // Call the Send method on the hub.
                chat.server.sendMessage(name, message, role, currentEmail);
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

function divscrolldown(email) {
    var bottomDiv = document.getElementById("bottom" + email + "ChatContent");
    bottomDiv.scrollIntoView({ behavior: "smooth" });
};

// thêm user vào listtab
function appendUsers(name, email) {
    if (checkuser(name, email) > 0) {
        $('#userListContent').append("<div id=\"" + email + "\" class=\"userListMember\" onClick=\"getClientUser(this.id)\">" + name + "</div>");
        return true;
    }
    else {
        return false;
    }
};

function getClientUser(id) {
    if (currentEmail === "0ac6aeed8665fb0519dcbefe39180d3dbd4eaf8e5e6204ab9ddc5a5d75fb3605") {
        currentEmail = id;
        $("#" + id + "div").removeAttr("hidden");
    } else {
        $("#" + currentEmail + "div").prop('hidden', true);
        currentEmail = id;
        $("#" + id + "div").removeAttr("hidden");
    }
    divscrolldown(id);
};

// Kiểm tra user đã tồn tại trong list user đã nhắn ?
function checkuser(name, email) {
    let flag = true;
    let result = 1;
    if (name === "admin") {
        return -2;
    }
    if (!emailList.length > 0) {
        emailList.push(email);
        return result;
    } else {
        emailList.forEach(function (str) {
            if (str === email) {
                flag = false;
                result = -1;
            }
        });
    }
    if (flag) emailList.push(email);
    return result;
}

// thêm chat phía admin
function addAdminChatContent(name, message, role, email) {
    $("#" + email + "div").append("<div class=\"w-100 mt-1 " + role + "Parent\"><div class=\"" + role + "Child\">" + message + "</div></div>");
    $('#bottom' + email + 'ChatContent').remove();
    $("#" + email + "div").append("<div id=\"bottom" + email + "ChatContent\"></div>");
    //console.log(($("#" + email + "div").last()).last());
    //divscrolldown();
};

function addNewClientChatContent(name, message, role, email) {
    $('#chatContent').append("<section hidden id=\"" + email + "div\">" + "</section>");
    $("#" + email + "div").append("<div class=\"w-100 mt-1 " + role + "Parent\"><div class=\"" + role + "Child\">" + message + "</div></div>");
    $('#bottom' + email + 'ChatContent').remove();
    $("#" + email + "div").append("<div id=\"bottom" + email + "ChatContent\"></div>");
    console.log(emailList);
    //divscrolldown(email);
};

function addClientChatContent(name, message, role, email) {
    $("#" + email + "div").append("<div class=\"w-100 mt-1 " + role + "Parent\"><div class=\"" + role + "Child\">" + message + "</div></div>");
    $('#bottom' + email + 'ChatContent').remove();
    $("#" + email + "div").append("<div id=\"bottom" + email + "ChatContent\"></div>");
    console.log(emailList);
}