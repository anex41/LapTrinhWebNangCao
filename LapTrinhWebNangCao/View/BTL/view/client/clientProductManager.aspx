<%@ Page Title="Quản lý nội dung" Language="C#" MasterPageFile="~/View/BTL/BTL.Master" AutoEventWireup="true" CodeBehind="clientProductManager.aspx.cs" Inherits="LapTrinhWebNangCao.View.BTL.view.client.clientProductManager" %>

<%@ Register TagPrefix="Product" TagName="Add" Src="~/View/BTL/userControl/AddProduct.ascx" %>
<%@ Register TagPrefix="Product" TagName="Edit" Src="~/View/BTL/userControl/EditProduct.ascx" %>
<%@ Register TagPrefix="Product" TagName="Approve" Src="~/View/BTL/userControl/ApproveProduct.ascx" %>
<%@ Register TagPrefix="Product" TagName="Disapprove" Src="~/View/BTL/userControl/DisapproveProduct.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder" runat="server">
    <link rel="stylesheet" type="text/css" href="../../../../Content/productmanagerstyle.css" />
    <div id="productSideNav" class="productSideNav position-fixed border-right border-secondary" style="height: calc(100% - 80px);">
        <div class="row m-0">
            <div class="col-sm-12" style="height: 50px;">
                <div class="row mx-0 my-auto h-100" onclick="changeView('add')" style="cursor: pointer;">
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
                <div class="row mx-0 my-auto h-100" onclick="changeView('edit')" style="cursor: pointer;">
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
                <div class="row mx-0 my-auto h-100" onclick="changeView('disapprove')" style="cursor: pointer;">
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
                <div class="row mx-0 my-auto h-100" onclick="changeView('approve')" style="cursor: pointer;">
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
            <div id="productAddDiv" class="addProductDiv container-fluid">
                <div class="text-primary text-center col-sm-12 position-relative">
                    <h1>Nội dung</h1>
                </div>
                <Product:Add ID="ProductAdd" ClientIDMode="static" runat="server"></Product:Add>
            </div>
            <div hidden id="productEditDiv" class="editProductDiv container-fluid">
                <Product:Edit ID="Edit" ClientIDMode="static" runat="server"></Product:Edit>
            </div>
            <div hidden id="productApproveDiv" class="deactivateProductDiv container-fluid">
                <Product:Approve ID="Approve" ClientIDMode="static" runat="server"></Product:Approve>
            </div>
            <div hidden id="productDisapproveDiv" class="activateProductDiv container-fluid">
                <Product:Disapprove ID="Disapprove" ClientIDMode="static" runat="server"></Product:Disapprove>
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

        function changeView(value) {
            switch (value) {
                case "add":
                    $("#productAddDiv").removeAttr("hidden");
                    $("#productEditDiv").prop("hidden", true);
                    $("#productApproveDiv").prop("hidden", true);
                    $("#productDisapproveDiv").prop("hidden", true);
                    break;
                case "edit":
                    $("#productEditDiv").removeAttr("hidden");
                    $("#productApproveDiv").prop("hidden", true);
                    $("#productAddDiv").prop("hidden", true);
                    $("#productDisapproveDiv").prop("hidden", true);
                    break;
                case "approve":
                    $("#productApproveDiv").removeAttr("hidden");
                    $("#productDisapproveDiv").prop("hidden", true);
                    $("#productEditDiv").prop("hidden", true);
                    $("#productAddDiv").prop("hidden", true);
                    break;
                case "disapprove":
                    $("#productDisapproveDiv").removeAttr("hidden");
                    $("#productEditDiv").prop("hidden", true);
                    $("#productAddDiv").prop("hidden", true);
                    $("#productApproveDiv").prop("hidden", true);
                    break;
                default:
                    showInfoToast("Thông báo!", "Đường dẫn không tồn tại");
                    break;
            };
        };

        function formatDate(str) {
            return new Date(parseInt(str.replace(/\//g, "").replace(/Date/, "").replace(/\(/g, "").replace(/\)/g, "")));
        };

        function refreshAllList() {
            getApproveProductList();
            getDisapproveProductList();
            getEditProductList();
        };

        function toggleEditState() {
            if (editFlag) {
                document.getElementById("titleTxt").classList.toggle('border-limegreen');
                document.getElementById("priceTxt").classList.toggle('border-limegreen');
                document.getElementById("catalogTxt").classList.toggle('border-limegreen');
                document.getElementById("addressTxt").classList.toggle('border-limegreen');
                document.getElementById("cityTxt").classList.toggle('border-limegreen');
                document.getElementById("districtTxt").classList.toggle('border-limegreen');
                document.getElementById("descriptionTxt").classList.toggle('border-limegreen');
                document.getElementById("cke_ckEditorTxt").classList.toggle('border-limegreen');
            } else {
                document.getElementById("titleTxt").classList.toggle('border-limegreen');
                document.getElementById("priceTxt").classList.toggle('border-limegreen');
                document.getElementById("catalogTxt").classList.toggle('border-limegreen');
                document.getElementById("addressTxt").classList.toggle('border-limegreen');
                document.getElementById("cityTxt").classList.toggle('border-limegreen');
                document.getElementById("districtTxt").classList.toggle('border-limegreen');
                document.getElementById("descriptionTxt").classList.toggle('border-limegreen');
                document.getElementById("cke_ckEditorTxt").classList.toggle('border-limegreen');
            };
        };

    </script>
</asp:Content>
