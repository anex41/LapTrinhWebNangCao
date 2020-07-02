<%@ Page Title="Chi Tiết Sản Phẩm" Language="C#" MasterPageFile="~/View/BTL/BTL.Master" AutoEventWireup="true" CodeBehind="productsDetail.aspx.cs" Inherits="LapTrinhWebNangCao.View.BTL.view.common.productsDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder" runat="server">
    <div class="row m-0 mt-2">
        <div class="col-sm-12 text-primary text-center mb-2" id="objTitle">
        </div>
        <div class="col-sm-12 text-justify mb-2" id="objDescription">
        </div>
        <div class="col-sm-12 text-justify mb-2">
            <div class="row m-0">
                <div class="col-sm-6 p-0">
                    Địa chỉ: <span class="text-success" id="objAddress"></span>
                    , Thuộc: <span class="text-success" id="objDistrict"></span>
                    <span class="text-success" id="objCity"></span>

                </div>
                <div class="col-sm-6 text-right">
                    Thuộc loại: <span class="text-success" id="objCatalog"></span>
                </div>
            </div>
        </div>
        <div class="col-sm-12 text-justify" id="objPrice">
            Giá:
        </div>
        <div class="col-sm-12 text-justify mb-2" id="objContent">
        </div>
        <div class="col-sm-12 text-justify mb-2">
            <div class="seenNumberDiv float-right">
                Được đăng ngày: <span class="text-primary mx-1" id="objAddedDate"></span>
                Bởi: <span class="text-primary mx-1" id="objUser"></span>
                Số lượt người xem: <span class="text-primary mx-1" id="objSeenNumber"></span>
            </div>
        </div>
        <div class="col-sm-12">
            <div id="productAlike" class="row m-0">
                <h1 class="text-center text-primary col-sm-12">Các sản phẩm tương tự</h1>
                <h5 class="col-sm-12">Các sản phẩm có khoảng giá tương tự</h5>
            </div>
        </div>
    </div>
    <script>
        var currentProductID = null;
        $(document).ready(function () {
            getCurrentId();
        });

        function getCurrentId() {
            let currentUrl = window.location.href.split("?")[1];
            let id = decodeURIComponent(currentUrl).split("=")[1];
            currentProductID = id;
            getProductDetail(id);
        };

        function getProductDetail(value) {
            let data = { "id": "" + value };
            $.ajax({
                type: "POST",
                url: window.location.origin + "/Services/ProductService.asmx/GetProductById",
                data: JSON.stringify(data),
                contentType: "application/json; charset=utf-8",
                dataType: "json"
            }).then(res => {
                appendProduct(res.d);
            });
        };

        function appendProduct(obj) {
            $("#objTitle").append("<h2>" + obj.Name + "</h2>");
            $("#objDescription").append(obj.Description);
            $("#objAddress").html(obj.Address);
            $("#objDistrict").html(obj.District + ", ");
            $("#objCity").html(obj.City);
            $("#objCatalog").html(formatCatalog(obj.Catalog));
            $("#objPrice").html("Giá từ: " + obj.Price + " vnđ");
            $("#objContent").append(obj.Content);
            $("#objAddedDate").html(formatDate(obj.AddedDate).toLocaleDateString());
            $("#objUser").html(obj.User);
            $("#objSeenNumber").html(obj.SeenNumber);
            getProductAlikeList(parseFloat(obj.Price) - 1000, parseFloat(obj.Price) + 1000);
        };

        function formatDate(str) {
            return new Date(parseInt(str.replace(/\//g, "").replace(/Date/, "").replace(/\(/g, "").replace(/\)/g, "")));
        };

        function formatCatalog (value) {
            switch (parseInt(value)) {
                case 1:
                    return "Bán Chung Cư";
                    break;
                case 2:
                    return "Bán Nhà Riêng";
                    break;
                case 3:
                    return "Bán Biệt Thự Liền Kề";
                    break;
                case 4:
                    return "Bán Đất";
                    break;
                case 5:
                    return "Bán Nhà Kho";
                    break;
                case 6:
                    return "Thuê Chung Cư";
                    break;
                case 7:
                    return "Thuê Nhà Riêng";
                    break;
                case 8:
                    return "Thuê Nhà Trọ, Phòng Trọ";
                    break;
                case 9:
                    return "Thuê Văn Phòng";
                    break;
                case 10:
                    return "Thuê Cửa Hàng";
                    break;
            };
        };

        function getProductAlikeList(begin, end) {
            //$("#productAlike").append("");
            let data = { "priceBegin": begin, "priceEnd": end, "identity": currentProductID};
            $.ajax({
                type: "POST",
                url: window.location.origin + "/Services/ProductService.asmx/GetProductAlike",
                data: JSON.stringify(data),
                contentType: "application/json; charset=utf-8",
                dataType: "json"
            }).then(res => {
                appendProductAlikeList(res.d);
            });
        };

        function appendProductAlikeList(arr) {
            arr.forEach(item => {
                $("#productAlike").append("<div class=\col-sm-3 card\">"
                    + "<img class=\card-img-top w-100\" src=\"/../../../../Assets/nhaDep1.jpg\" alt=\"Card image cap\">"
                    + "<div class=\"card-body\"><h5 class=\"card-title\">"+ item.Name +"</h5>"
                    + "<p class=\"card-text\">" + item.Description +"</p>"
                    + "<button type=\"button\" id=\"" + item.Id + "\" onclick=\"getDetailProduct(this.id)\" href=\"#\" class=\"btn btn-primary text-center\">Xem chi tiết</button>"
                    + "</div></div>");
            });
        };

        function getDetailProduct(value) {
            let x = encodeURIComponent("id=" + value);
            window.location.replace(window.location.origin + "/View/BTL/view/common/productsDetail?" + x);
        };
    </script>
</asp:Content>
