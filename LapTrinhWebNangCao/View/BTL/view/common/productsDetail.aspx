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
    </div>
    <script>
        $(document).ready(function () {
            getCurrentId();
        });

        function getCurrentId() {
            let currentUrl = window.location.href.split("?")[1];
            let id = decodeURIComponent(currentUrl).split("=")[1];
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
    </script>
</asp:Content>
