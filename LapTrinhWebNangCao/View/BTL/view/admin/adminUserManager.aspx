<%@ Page Title="Quản lý người dùng" Language="C#" MasterPageFile="~/View/BTL/view/admin/adminMaster.Master" AutoEventWireup="true" CodeBehind="adminUserManager.aspx.cs" Inherits="LapTrinhWebNangCao.View.BTL.view.admin.adminUserManager" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder" runat="server">
    <div class="container-fluid">
        <div class="row" id="userList" runat="server">
            <div class="text-primary text-center col-sm-12">
                <h2>Danh sách người dùng</h2>
            </div>
        </div>
        <div class="position-fixed" style="bottom:2vh; right:2vh;">
            <button type="button" id="addUserbtn" class="btn btn-success">Thêm người dùng</button>
        </div>
    </div>
    <script>
        $(document).ready(function () {
            $("#addUserbtn").on("click", function () {
                console.log("do something");
            });
        });
    </script>
</asp:Content>
