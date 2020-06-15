<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ChangePassword.ascx.cs" Inherits="LapTrinhWebNangCao.View.BTL.userControl.ChangePassword" %>
<div class="modal fade" id="changePasswordModal" tabindex="-1" role="dialog" data-backdrop="static" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title text-center text-primary w-100" id="exampleModalLabel">Đổi mật khẩu</h3>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="row m-0">
                    <div class="col-sm-12 mt-4">
                        <div class="row m-0">
                            <div class="col-sm-4 m-auto">
                                Người dùng
                            </div>
                            <div class="col-sm-8 input-group">
                                <input readonly id="currentUsername" class="form-control" />
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-12 mt-4">
                        <div class="row m-0">
                            <div class="col-sm-4 m-auto">
                                Mật khẩu cũ
                            </div>
                            <div class="col-sm-8 input-group">
                                <input id="oldPasswordTxt" class="form-control" />
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-12 mt-4">
                        <div class="row m-0">
                            <div class="col-sm-4 m-auto">
                                Mật khẩu mới
                            </div>
                            <div class="col-sm-8 input-group">
                                <input id="newPasswordTxt" class="form-control" />
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-12 mt-4">
                        <div class="row m-0">
                            <div class="col-sm-4 m-auto">
                                Xác nhận mật khẩu mới
                            </div>
                            <div class="col-sm-8 input-group">
                                <input id="reNewPasswordTxt" class="form-control" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-outline-danger" data-dismiss="modal">Đóng</button>
                <button type="button" class="btn btn-success" id="confirmChangePasswordBtn">Xác nhận</button>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" data-backdrop="static" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title text-center text-primary w-100">Đổi mật khẩu thành công</h3>
            </div>
            <div class="modal-body">
                <img class="m-auto w-50 d-block" alt="" src="../../../../Assets/check.gif" />
            </div>
            <div class="modal-footer">
                <div class="text-center text-info w-100">
                    Tài khoản sẽ tự đăng xuất trong <span id="countDownSpan" class="text-warning"></span>giây
                </div>
                <div class="w-100 text-center">
                    <button type="button" class="btn btn-outline-danger" id="clientLogoutBtn">
                        Đăng xuất ngay
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    $(document).ready(function () {
        getCurrentUser();
        $("#confirmChangePasswordBtn").on("click", function () {
            if (validateField()) {
                changePassword();
                //showSucceedToast("Thành công","Đã thực hiện thành công");
            };
        });
        $("#clientLogoutBtn").on("click", function () {
            $("#logoutModal").modal("hide");
            $("#logoutBtn").click();
        });
    });

    function getCurrentUser() {
        $.ajax({
            type: "POST",
            url: window.location.origin + "/Services/Login.asmx/GetCurrentUser",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
        }).then(res => {
            $("#currentUsername").val(res.d);
        });
    };

    function validateField() {
        let flag = true;
        let oldPassword = $("#oldPasswordTxt").val().trim();
        let newPassword = $("#newPasswordTxt").val().trim();
        let reNewPassword = $("#reNewPasswordTxt").val().trim();
        if (oldPassword == null || oldPassword == "") {
            flag = false;
            showErrorToast("Lỗi!", "Chưa điền mật khẩu cũ!");
        };
        if (newPassword == null || oldPassword == "") {
            flag = false;
            showErrorToast("Lỗi!", "Chưa điền mật khẩu mới!");
        };
        if (reNewPassword == null || oldPassword == "") {
            flag = false;
            showErrorToast("Lỗi!", "Chưa điền xác nhận mật khẩu mới!");
        };
        if (newPassword.length < 6 || newPassword.length > 16) {
            showInfoToast("Lưu ý", "Mật khẩu yêu cầu có độ dài từ 6 đến 16 ký tự");
            flag = false;
        };
        if (reNewPassword !== newPassword) {
            showErrorToast("Lỗi", "Mật khẩu xác nhận không trùng khớp với mật khẩu ban đầu!");
            flag = false;
        };
        return flag;
    };

    function changePassword() {
        let data = { "username": $("#currentUsername").val().trim(), "password": $("#newPasswordTxt").val().trim(), "oldpassword": $("#oldPasswordTxt").val().trim() };
        $.ajax({
            type: "POST",
            url: window.location.origin + "/Services/Login.asmx/ChangeCurrentUserPassword",
            data: JSON.stringify(data),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
        }).then(res => {
            switch (parseInt(res.d)) {
                case -3:
                    showInfoToast("Thông báo", "Sai tên người dùng hiện tại đang đăng nhập");
                    break;
                case -2:
                    showErrorToast("Lỗi", "Mật khẩu cũ sai");
                    break;
                case -1:
                    showInfoToast("Lưu ý!", "Mật khẩu mới không được trùng với mật khẩu cũ");
                    break;
                case 0:
                    showErrorToast("Lỗi!", "Không tìm thấy tài khoản");
                    break;
                case 1:
                    showSucceedToast("Thành công!", "Thay đổi mật khẩu thành công!");
                    startLogoutCountDown(11, document.querySelector('#countDownSpan'));
                    break;
            }
        });
    };


    function startLogoutCountDown(duration, display) {
        $("#logoutModal").modal("show");
        display.textContent = duration + " ";
        function timer() {
            if (duration <= 0) {
                return;
            };
            duration--;
            display.textContent = duration + " ";

            if (duration <= 0) {
                //console.log("com pờ le te");
                display.textContent = duration + " ";
                $("#logoutModal").modal("hide");
                $("#logoutBtn").click();
            }
        };
        timer();
        setInterval(timer, 1000);
    };
</script>
