<%@ Page Title="Danh sách sản phẩm" Language="C#" MasterPageFile="~/View/BTL/BTL.Master" AutoEventWireup="true" CodeBehind="products.aspx.cs" Inherits="LapTrinhWebNangCao.View.BTL.view.common.products" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder" runat="server">
    <div class="row m-0">
        <h1 class="col-sm-12 text-center text-primary">Danh sách sản phẩm</h1>
        <div class="col-sm-9 p-2" id="productListDiv">
            
        </div>
        <div class="col-sm-3 border border-secondary rounded">
            filter tool
        </div>
    </div>
    <script>
        $(document).ready(function () {
            getProductList();
        });

        function getProductList() {
            let data = { "type": "default" };
            $.ajax({
                type: "POST",
                url: window.location.origin + "/Services/ProductService.asmx/GetAllProducts",
                data: JSON.stringify(data),
                contentType: "application/json; charset=utf-8",
                dataType: "json"
            }).then(res => {
                appendProductList(res.d);
            });
        };

        function appendProductList(arr) {
            arr.forEach(item => {
                $("#productListDiv").append("<div class=\"row m-0 mb-2\"><div class=\"col-sm-2\"><img class=\"w-100 h-100\" alt=\"\" src=\"/../../../../Assets/nhaDep1.jpg\"/></div>"
                    + "<div class=\"col-sm-10\"><div class=\"row m-0\">"
                    + "<h3 class=\"col-sm-12 text-primary\" style=\"cursor: pointer;\" id=\"" + item.Id + "\" onclick=\"getDetailProduct(this.id)\">"
                    + item.Name + "<span class=\"starSpan\">&#9734;</span></h3>"
                    + "<div class=\"col-sm-12 productDescription\">" + item.Description + "</div><div class=\"col-sm-12\"><div class=\"row m-0\"><div class=\"col-sm-6 p-0\">"
                    + "Đăng bởi: " + item.User + "</div><div class=\"col-sm-6 p-0 text-right\">Ngày : " + formatDate(item.AddedDate).toLocaleDateString()
                    + "</div></div ></div ><div class=\"col-sm-12 text-right\">"
                    + "Lượt xem: " + item.SeenNumber + "</div></div></div></div>");
            });
        };

        function formatDate(str) {
            return new Date(parseInt(str.replace(/\//g, "").replace(/Date/, "").replace(/\(/g, "").replace(/\)/g, "")));
        };

        function getDetailProduct(value) {
            let x = encodeURIComponent("id=" + value);
            window.location.replace(window.location.origin + "/View/BTL/view/common/productsDetail?" + x);
        };
    </script>
</asp:Content>
