<%@ Page Title="Quản lý của người dùng" Language="C#" MasterPageFile="~/View/BTL/BTL.Master" AutoEventWireup="true" CodeBehind="clientControllerView.aspx.cs" Inherits="LapTrinhWebNangCao.View.BTL.view.client.clientControllerView" %>

<%@ Register TagPrefix="User" TagName="ChangePassword" Src="~/View/BTL/userControl/ChangePassword.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder" runat="server">
    <div class="row m-0 mt-2">
        <h1 class="col-sm-12 text-center text-primary">Hãy chọn chức năng</h1>
        <div class="card col-sm-12 p-0">
            <div class="card-header">
                Danh sách chức năng
            </div>
            <div class="card-body">
                <h5 class="card-title">Đổi mật khẩu</h5>
                <p class="card-text">Chức năng này giúp người dùng đổi mật khẩu hiện tại của mình</p>
                <button type="button" id="changePasswordBtn" class="btn btn-primary" data-toggle="modal" data-target="#changePasswordModal">Đổi mật khẩu của bạn</button>
            </div>
            <div class="card-body">
                <h5 class="card-title">Quản lý nội dung</h5>
                <p class="card-text">Tạo thêm các bài viết về sản phẩm (Nhà đất, chung cư, ...) cần được bán, thuê ...</p>
                <button type="button" id="productManager" class="btn btn-primary">Chuyển đến chức năng quản lý sản phẩm</button>
            </div>
            <div class="card-body">
                <h5 class="card-title">Thông tin cá nhân</h5>
                <p class="card-text">Xem, sửa, thay đổi thông tin cá nhân của người dùng cung cấp.</p>
                <button type="button" id="userProfile" class="btn btn-primary">Chuyển đến chức năng xem thông tin cá nhân</button>
            </div>
        </div>
    </div>
    <User:ChangePassword ID="ChangeUserPassword" ClientIDMode="static" runat="server"></User:ChangePassword>
    <script>
        $(document).ready(function () {
            $("#productManager").on("click", function () {
                window.location.replace(window.location.origin + "/View/BTL/view/client/clientProductManager");
            });
            $("#userProfile").on("click", function () {
                window.location.replace(window.location.origin + "/View/BTL/view/client/ClientProfile");
            });
        });
    </script>
</asp:Content>
