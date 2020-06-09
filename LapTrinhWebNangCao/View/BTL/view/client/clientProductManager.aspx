<%@ Page Title="Quản lý nội dung" Language="C#" MasterPageFile="~/View/BTL/BTL.Master" AutoEventWireup="true" CodeBehind="clientProductManager.aspx.cs" Inherits="LapTrinhWebNangCao.View.BTL.view.client.clientProductManager" %>
<%@ Register TagPrefix="Product" TagName="Add" Src="~/View/BTL/userControl/AddProduct.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder" runat="server">
    <link rel="stylesheet" type="text/css" href="../../../../Content/productmanagerstyle.css" />
    <div id="productSideNav" class="productSideNav position-fixed border-right border-secondary" style="height: calc(100% - 80px);">
        <div class="row m-0">
            <div class="col-sm-12" style="height: 50px;">
                <div class="row mx-0 my-auto h-100">
                    <div class="sideNavTitle col-sm-10 m-auto">
                        <a class="text-white col-sm-12 my-2">Thêm sản phẩm</a>
                    </div>
                    <div class=" p-0 my-auto text-center">
                        <i class="text-white fas fa-plus-square" style="font-size: 25px;"></i>
                    </div>
                </div>
            </div>
            <hr class="w-100 bg-white my-1" />
            <div class="col-sm-12" style="height: 50px;">
                <div class="row mx-0 my-auto h-100">
                    <div class="sideNavTitle col-sm-10 m-auto">
                        <a class="text-white col-sm-12 my-2">Sửa nội dung sản phẩm</a>
                    </div>
                    <div class=" p-0 my-auto text-center">
                        <i class="text-white fas fa-pen" style="font-size: 25px;"></i>
                    </div>
                </div>
            </div>
            <hr class="w-100 bg-white my-1" />
            <div class="col-sm-12" style="height: 50px;">
                <div class="row mx-0 my-auto h-100">
                    <div class="sideNavTitle col-sm-10 m-auto">
                        <a class="text-white col-sm-12 my-2">Hủy duyệt sản phẩm</a>
                    </div>
                    <div class=" p-0 my-auto text-center">
                        <i class="text-white fas fa-times-circle" style="font-size: 25px;"></i>
                    </div>
                </div>
            </div>
            <hr class="w-100 bg-white my-1" />
            <div class="col-sm-12" style="height: 50px;">
                <div class="row mx-0 my-auto h-100">
                    <div class="sideNavTitle col-sm-10 m-auto">
                        <a class="text-white col-sm-12 my-2">Duyệt sản phẩm</a>
                    </div>
                    <div class=" p-0 my-auto text-center">
                        <i class="text-white fas fa-check-double" style="font-size: 25px;"></i>
                    </div>
                </div>
            </div>
            <hr class="w-100 bg-white my-1" />
        </div>
    </div>
    <div id="productContent" class="productContent">
        <div id="sideNavToogleBtn" class="position-fixed text-danger toogleButtonStyle p-2" style="z-index: 2;" onclick="toggleSideNav()">
            <i id="faId" class="text-white fas fa-caret-left"></i>
        </div>
        <div class="row mx-0">
            <div class="text-primary text-center col-sm-12 position-relative">
                <h1>Nội dung</h1>
            </div>
            <div class="addProductDiv container-fluid">
                <Product:Add ID="ProductAdd" runat="server"></Product:Add>
            </div>
            <div hidden class="editProductDiv">
            </div>
            <div hidden class="deactivateProductDiv">
            </div>
            <div hidden class="activateProductDiv">
            </div>
        </div>
    </div>
    <script>
        var sideNavFlag = true;
        var fontAwesome = document.getElementById("faId");
        $(document).ready(function () {

        });

        function toggleSideNav() {
            sideNavFlag == true ? closeSideNav() : openSideNave();
        };

        function openSideNave() {
            sideNavFlag = true;
            $(".sideNavTitle ").show();
            $("#sideNavCloseBtn").removeAttr("hidden");
            $("#sideNavOpenBtn").attr("hidden", true);
            document.getElementById("productSideNav").classList.toggle('sideNavTog');
            document.getElementById("productContent").classList.toggle('productContentTog');
            document.getElementById("sideNavToogleBtn").classList.toggle('toogleButtonTog');
            fontAwesome.classList.remove("fa-caret-right");
            fontAwesome.classList.add("fa-caret-left");
        };
        function closeSideNav() {
            sideNavFlag = false;
            $(".sideNavTitle ").hide();
            $("#sideNavOpenBtn").removeAttr("hidden");
            $("#sideNavCloseBtn").attr("hidden", true);
            document.getElementById("productSideNav").classList.toggle('sideNavTog');
            document.getElementById("productContent").classList.toggle('productContentTog');
            document.getElementById("sideNavToogleBtn").classList.toggle('toogleButtonTog');
            fontAwesome.classList.remove("fa-caret-left");
            fontAwesome.classList.add("fa-caret-right");
        };
    </script>
</asp:Content>
