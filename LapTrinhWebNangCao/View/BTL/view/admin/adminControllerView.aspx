﻿<%@ Page Title="Trang Quản Trị" Language="C#" MasterPageFile="~/View/BTL/view/admin/adminMaster.Master" AutoEventWireup="true" CodeBehind="adminControllerView.aspx.cs" Inherits="LapTrinhWebNangCao.View.BTL.view.adminControllerView" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder" runat="server">
    <div class="card">
        <div class="card-header">
            Danh sách chức năng
        </div>
        <div class="card-body">
            <h5 class="card-title">Trò chuyện với khách hàng</h5>
            <p class="card-text">Sử dụng SignalR, chức năng này cho phép người quản trị trò chuyện với người dùng để hỗ trợ và trả lời thắc mắc</p>
            <button type="button" id="chatATag" class="btn btn-primary">Chuyển đến chức năng trò chuyện</button>
        </div>
        <div class="card-body">
            <h5 class="card-title">Quản lý tài khoản</h5>
            <p class="card-text">Tạo thêm tài khoản, sửa thông tin tài khoản, vô hiệu hóa tài khoản khách hàng</p>
            <button type="button" id="userManageATag" class="btn btn-primary">Chuyển đến chức năng quản lý khách hàng</button>
        </div>
        <div class="card-body">
            <h5 class="card-title">Quản lý nội dung</h5>
            <p class="card-text">Chỉnh sửa những nội dung hiển thị trên trang web</p>
            <button type="button" id="contentManager" class="btn btn-primary">Chuyển đến chức năng quản lý nội dung</button>
        </div>
    </div>
    <script>
        $(document).ready(function () {
            $("#chatATag").on("click", function () {
                window.location.replace(window.location.origin + "/View/BTL/view/admin/adminChatController");
            });
            $("#userManageATag").on("click", function () {
                window.location.replace(window.location.origin + "/View/BTL/view/admin/adminUserManager");
            });
            $("#contentManager").on("click", function () {
                window.location.replace(window.location.origin + "/View/BTL/view/admin/adminContentManager");
            });
        });
    </script>
</asp:Content>
