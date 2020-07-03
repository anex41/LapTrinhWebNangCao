<%@ Page Title="Quản lý người dùng" Language="C#" MasterPageFile="~/View/BTL/view/admin/adminMaster.Master" AutoEventWireup="true" CodeBehind="adminUserManager.aspx.cs" Inherits="LapTrinhWebNangCao.View.BTL.view.admin.adminUserManager" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder" runat="server">
    <div class="container-fluid">
        <div class="row" id="userList" clientIdMode="static" runat="server">
            <div class="text-primary text-center col-sm-12">
                <h2>Danh sách người dùng</h2>
            </div>
        </div>
        <div class="position-fixed" style="bottom: 2vh; right: 2vh;">
            <button type="button" class="btn btn-success" data-toggle='modal' data-target='#createUserModal'>Thêm người dùng</button>
        </div>
    </div>
    <div class="modal fade" id="createUserModal" tabindex="-1" role="dialog" data-backdrop="static" data-keyboard="false" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h3 class="modal-title text-center text-primary w-100" id="exampleModalLabel">Thông tin về người dùng</h3>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body row">
                    <div class="col-sm-6">
                        <div class="row">
                            <div class="col-sm-12 mb-2">
                                <div class="row">
                                    <div class="col-sm-5">
                                        Họ và tên:
                                    </div>
                                    <div class="col-sm-7">
                                        <input class="form-control" type="text" id="name" />
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-12 mb-2">
                                <div class="row">
                                    <div class="col-sm-5">
                                        Tên tài khoản:
                                    </div>
                                    <div class="col-sm-7">
                                        <input class="form-control" type="text" oninput="checkUserExistence(this)" id="username" />
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-12 mb-2">
                                <div class="row">
                                    <div class="col-sm-5">
                                        Mật khẩu:
                                    </div>
                                    <div class="col-sm-7">
                                        <input class="form-control" type="text" id="password" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-6">
                        <div class="row">
                            <div class="col-sm-12 mb-2">
                                <div class="row">
                                    <div class="col-sm-5">
                                        Số điện thoại:
                                    </div>
                                    <div class="col-sm-7">
                                        <input class="form-control" type="text" id="phoneNumber" />
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-12 mb-2">
                                <div class="row">
                                    <div class="col-sm-5">
                                        Email:
                                    </div>
                                    <div class="col-sm-7">
                                        <input class="form-control" type="text" id="email" />
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-12 mb-2">
                                <div class="row">
                                    <div class="col-sm-5">
                                        Nhập lại mật khẩu:
                                    </div>
                                    <div class="col-sm-7">
                                        <input class="form-control" type="text" id="rePassword" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-danger" data-dismiss="modal">Đóng</button>
                    <button type="button" class="btn btn-success" id="addUserBtn">Thêm người dùng</button>
                </div>
            </div>
        </div>
    </div>
    <script>
        var usernameFlag = true;
        var delayTimer;
        $(document).ready(function () {
            $("#addUserBtn").on("click", function () {
                if (validateField()) {
                    createNewClient();
                    clearField();
                }
            });
        });

        function validateField() {
            let flag = true;
            let n = $("#name").val().trim();
            let p = $("#password").val().trim();
            let rep = $("#rePassword").val().trim();
            let un = $("#username").val().trim();
            let phone = $("#phoneNumber").val().trim();
            let em = $("#email").val().trim();
            if (n !== "") {
                if (n.split(" ").length < 2) {
                    showErrorToast("Lỗi", "Hãy nhập đầy đủ họ tên!");
                    flag = false;
                }
            } else {
                showErrorToast("Lỗi", "Bạn chưa nhập tên!");
                flag = false;
            };
            if (p !== "") {
                if (p.length < 6 || p.length > 16) {
                    showInfoToast("Lưu ý", "Mật khẩu yêu cầu có độ dài từ 6 đến 16 ký tự");
                    flag = false;
                }
            } else {
                showErrorToast("Lỗi", "Bạn chưa nhập mật khẩu!");
                flag = false;
            };
            if (rep !== "") {
                if (rep !== p) {
                    showErrorToast("Lỗi", "Mật khẩu nhập lại không trùng khớp với mật khẩu ban đầu!");
                    flag = false;
                }
            } else {
                showErrorToast("Lỗi", "Bạn chưa nhập xác nhận mật khẩu!");
            };
            if (un !== "") {
                if (usernameFlag) {
                    showErrorToast("Lỗi", "Tên tài khoản đã tồn tại!");
                    flag = false;
                }
            } else {
                showErrorToast("Lỗi", "Bạn chưa nhập tên tài khoản!");
                flag = false;
            };
            if (phone !== "") {
                let patt = /^(\+?\d{11})$|^(\d{10})$/;
                if (!patt.test(phone)) {
                    showErrorToast("Lỗi", "Số điện thoại không đúng định dạng!");
                    flag = false;
                };
            } else {
                showErrorToast("Lỗi", "Bạn chưa nhập số điện thoại!");
                flag = false;
            };
            if (em !== "") {
                let patt = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
                if (!patt.test(em)) {
                    showErrorToast("Lỗi", "Email không đúng định dạng!");
                    flag = false;
                };
            } else {
                showErrorToast("Lỗi", "Bạn chưa nhập email!");
                flag = false;
            };
            return flag;
        };

        function convertString(str) {
            if (str === null || str === undefined) return str;
            str = str.toLowerCase();
            str = str.replace(/à|á|ạ|ả|ã|â|ầ|ấ|ậ|ẩ|ẫ|ă|ằ|ắ|ặ|ẳ|ẵ/g, "a");
            str = str.replace(/è|é|ẹ|ẻ|ẽ|ê|ề|ế|ệ|ể|ễ/g, "e");
            str = str.replace(/ì|í|ị|ỉ|ĩ/g, "i");
            str = str.replace(/ò|ó|ọ|ỏ|õ|ô|ồ|ố|ộ|ổ|ỗ|ơ|ờ|ớ|ợ|ở|ỡ/g, "o");
            str = str.replace(/ù|ú|ụ|ủ|ũ|ư|ừ|ứ|ự|ử|ữ/g, "u");
            str = str.replace(/ỳ|ý|ỵ|ỷ|ỹ/g, "y");
            str = str.replace(/đ/g, "d");
            return str;
        };

        function clearField() {
            $("#name").val("");
            $("#password").val("");
            $("#rePassword").val("");
            $("#username").val("");
            $("#phoneNumber").val("");
            $("#email").val("");
            $('#createUserModal').modal('hide');
        };

        function checkUserExistence() {
            if ($("#username").val().trim() !== "") {
                clearTimeout(delayTimer);
                delayTimer = setTimeout(function () {
                    let data = { "username": $("#username").val().trim() };
                    $.ajax({
                        type: "POST",
                        url: window.location.origin + "/Services/UserServices.asmx/CheckUserExistence",
                        data: JSON.stringify(data),
                        contentType: "application/json; charset=utf-8",
                        dataType: "json"
                    }).then(response => {
                        if (response.d !== true)
                            usernameFlag = false;
                        else
                            usernameFlag = true;
                    });
                }, 2000);
            } else return;
        };

        function createNewClient() {
            let data = {
                "username": $("#username").val().trim(), "password": $("#password").val().trim(),
                "displayname": $("#name").val().trim(), "phonenumber": $("#phoneNumber").val().trim(),
                "email": $("#email").val().trim()
            };
            $.ajax({
                type: "POST",
                url: window.location.origin + "/Services/UserServices.asmx/AddNewClient",
                data: JSON.stringify(data),
                contentType: "application/json; charset=utf-8",
                dataType: "json"
            }).then(response => {
                if (response.d !== true)
                    showErrorToast("Lỗi!", "Không thể tạo được người dùng mới");
                else {
                    showSucceedToast("Thành công!", "Đã tạo người dùng mới");
                    refreshUserList();
                }
            });
        };

        function refreshUserList() {
            $.ajax({
                type: "POST",
                url: window.location.origin + "/Services/UserServices.asmx/GetClient",
                contentType: "application/json; charset=utf-8",
                dataType: "json"
            }).then(response => {
                $(".userCard").remove();
                response.d.forEach(item => {
                    $("#userList").append(
                        "<div class=\"card col-sm-4 userCard\"><img class=\"card-img-top w-75\" style=\"align-self: center;\" src=\"/../../../../Assets/autoUser.png\" alt=''>"
                        + "<div class=\"card-body\"><h5 class=\"card-title text-center\">" + item.Displayname + "</h5>"
                        + "<div class=\"row\"><div class=\"card-text col-sm-5\">Chức danh:</div><div class=\"card-text col-sm-7\">"
                        + (item.Role == 0 ? "Người dùng" : "Quản trị viên") + "</div></div><hr class=\"my-1\"/>"
                        + "<div class=\"row\"><div class=\"card-text col-sm-5\">Email:</div><div class=\"card-text col-sm-7\">"
                        + item.Email + "</div></div><hr class=\"my-1\"/>"
                        + "<div class=\"row\"><div class=\"card-text col-sm-5\">Số điện thoại:</div><div class=\"card-text col-sm-7\">"
                        + item.Phonenumber + "</div></div><hr class=\"my-1\"/>"
                        + "<button type=\"button\" id=\"" + item.Id + "\" onClick=\"deactiveUser(this.id)\" class=\"btn btn-outline-danger\" style=\"float: right;\">Deactivate</button></div></div>"
                    );
                });
            });
        };
    </script>
</asp:Content>
