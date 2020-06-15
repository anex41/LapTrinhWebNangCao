<%@ Page Title="Thông tin cá nhân" Language="C#" MasterPageFile="~/View/BTL/BTL.Master" AutoEventWireup="true" CodeBehind="ClientProfile.aspx.cs" Inherits="LapTrinhWebNangCao.View.BTL.view.client.ClientProfile" %>

<%@ Register TagPrefix="User" TagName="ChangePassword" Src="~/View/BTL/userControl/ChangePassword.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder" runat="server">
    <div class="row mx-0 mt-2">
        <div class="col-sm-12 text-center">
            <h1 class="text-primary">Thông tin cá nhân</h1>
        </div>
        <div class="col-sm-12">
            <div class="row m-0">
                <div class="col-sm-4 p-3">
                    <img class="w-100" src="../../../../Assets/autoUser.png" alt="" />
                </div>
                <div class="col-sm-8">
                    <div class="row m-0 mb-3">
                        <div class="col-sm-3 m-auto">
                            Họ và tên
                        </div>
                        <div class="col-sm-9 input-group">
                            <input readonly style="min-width: 75%;" id="profileNameTxt" class="form-control" />
                        </div>
                    </div>
                    <div class="row m-0 mb-3">
                        <div class="col-sm-3 m-auto">
                            Tài khoản
                        </div>
                        <div class="col-sm-9 input-group">
                            <input readonly style="min-width: 75%;" id="profileUsernameTxt" class="form-control" />
                        </div>
                    </div>
                    <div class="row m-0 mb-3">
                        <div class="col-sm-3 m-auto">
                            Số điện thoại
                        </div>
                        <div class="col-sm-9 input-group">
                            <input readonly style="min-width: 75%;" id="profilePhoneTxt" class="form-control" />
                        </div>
                    </div>
                    <div class="row m-0 mb-3">
                        <div class="col-sm-3 m-auto">
                            Tài khoản Email
                        </div>
                        <div class="col-sm-9 input-group">
                            <input readonly style="min-width: 75%;" id="profileEmailTxt" class="form-control" />
                        </div>
                    </div>
                    <div class="row m-0 mb-3">
                        <div class="col-sm-3 m-auto">
                            Chức vụ
                        </div>
                        <div class="col-sm-9 input-group">
                            <input readonly style="min-width: 75%;" id="profileRoleTxt" class="form-control" />
                        </div>
                    </div>
                    <div class="row m-0 mb-3">
                        <div class="col-sm-3 m-auto">
                            Trạng thái
                        </div>
                        <div class="col-sm-9 input-group">
                            <input readonly style="min-width: 75%;" id="profileStatusTxt" class="form-control" />
                        </div>
                    </div>
                </div>
                <div class="col-sm-8 offset-sm-4">
                    <button id="profileEdit" type="button" class="btn btn-success mx-2" style="width: 150px" onclick="startEdit()">
                        Sửa
                    </button>
                    <button hidden id="profileCancelEdit" type="button" class="btn btn-danger mx-2" style="width: 150px" onclick="cancelEdit()">
                        Hủy
                    </button>
                    <button type="button" class="btn btn-outline-success mx-2" style="width: 150px">
                        Kích hoạt
                    </button>
                    <button type="button" class="btn btn-outline-danger mx-2" style="width: 150px">
                        Hủy Kích hoạt
                    </button>
                </div>
            </div>
        </div>
    </div>
    <User:ChangePassword ID="ChangeUserPassword" ClientIDMode="static" runat="server"></User:ChangePassword>
    <script>
        var profileEditFlag = false;
        $(document).ready(function () {
            getCurrentUserProfile();
        });

        function getCurrentUserProfile() {
            $.ajax({
                type: "POST",
                url: window.location.origin + "/Services/UserServices.asmx/GetUserProfile",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
            }).then(res => {
                $("#profileNameTxt").val(res.d.Displayname);
                $("#profileUsernameTxt").val(res.d.Username);
                $("#profileRoleTxt").val(getRole(res.d.Role));
                $("#profileEmailTxt").val(res.d.Email);
                $("#profileStatusTxt").val(res.d.StatusFlag == 1 ? "Đã xác nhận" : "Chưa xác nhận");
                $("#profilePhoneTxt").val(res.d.Phonenumber);
            });
        };

        function getRole(str) {
            switch (str) {
                case 1:
                    return "Quản trị viên";
                    break;
                case 0:
                    return "Người dùng";
                    break;
            }
        };

        function startEdit() {
            if (!profileEditFlag) {
                toggleEditBorder();
                showInfoToast("Thông báo!", "Bạn đang ở chê độ sửa");
                $("#profileNameTxt").removeAttr("readonly");
                $("#profilePhoneTxt").removeAttr("readonly");
                $("#profileEmailTxt").removeAttr("readonly");
                $("#profileCancelEdit").removeAttr("hidden");
                profileEditFlag = true;
            } else {
                if (validateEditField()) {
                    profileEditFlag = false;
                    // chưa sửa, muốn sửa thì viết code vào đây mà xử lý
                } else {
                    return;
                }
            };

        };

        function cancelEdit() {
            toggleEditBorder();
            showInfoToast("Thông báo!", "Bạn đang hủy lựa chọn sửa");
            $("#profileNameTxt").prop("readonly", true);
            $("#profilePhoneTxt").prop("readonly", true);
            $("#profileEmailTxt").prop("readonly", true);
            $("#profileCancelEdit").prop("hidden", true);
            getCurrentUserProfile();
        };

        function toggleEditBorder() {
            document.getElementById("profileNameTxt").classList.toggle('border-limegreen');
            document.getElementById("profilePhoneTxt").classList.toggle('border-limegreen');
            document.getElementById("profileEmailTxt").classList.toggle('border-limegreen');
        };

        function validateEditField() {
            let flag = true;
            let name = $("#profileNameTxt").val().trim();
            let phone = $("#profilePhoneTxt").val().trim();
            let email = $("#profileEmailTxt").val().trim();
            if (name !== "") {
                if (n.split(" ").length < 2) {
                    showErrorToast("Lỗi", "Hãy nhập đầy đủ họ tên!");
                    flag = false;
                }
            } else {
                showErrorToast("Lỗi", "Bạn chưa nhập tên!");
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
            if (email !== "") {
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
    </script>
</asp:Content>
