<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="libraryB22.aspx.cs" Inherits="LapTrinhWebNangCao.View.BTTH.Bai22.libraryB22" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Bài 22</title>
    <asp:PlaceHolder runat="server">
        <%: Scripts.Render("~/bundles/modernizr") %>
    </asp:PlaceHolder>
    <webopt:BundleReference runat="server" Path="~/Content/css" />
    <link href="~/favicon.ico" rel="shortcut icon" type="image/x-icon" />
    <link rel="stylesheet" type='text/css' href="/Content/fontawesome-all.css" />
    <style>
        .marginRightPlease input[type="radio"] {
            margin-left: 10px;
            margin-right: 1px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager runat="server">
            <Scripts>
                <asp:ScriptReference Name="MsAjaxBundle" />
                <asp:ScriptReference Name="jquery" />
                <asp:ScriptReference Name="WebForms.js" Assembly="System.Web" Path="~/Scripts/WebForms/WebForms.js" />
                <asp:ScriptReference Name="WebUIValidation.js" Assembly="System.Web" Path="~/Scripts/WebForms/WebUIValidation.js" />
                <asp:ScriptReference Name="MenuStandards.js" Assembly="System.Web" Path="~/Scripts/WebForms/MenuStandards.js" />
                <asp:ScriptReference Name="GridView.js" Assembly="System.Web" Path="~/Scripts/WebForms/GridView.js" />
                <asp:ScriptReference Name="DetailsView.js" Assembly="System.Web" Path="~/Scripts/WebForms/DetailsView.js" />
                <asp:ScriptReference Name="TreeView.js" Assembly="System.Web" Path="~/Scripts/WebForms/TreeView.js" />
                <asp:ScriptReference Name="WebParts.js" Assembly="System.Web" Path="~/Scripts/WebForms/WebParts.js" />
                <asp:ScriptReference Name="Focus.js" Assembly="System.Web" Path="~/Scripts/WebForms/Focus.js" />
                <asp:ScriptReference Name="WebFormsBundle" />
            </Scripts>
        </asp:ScriptManager>
        <div class="container-fluid">
            <div class="row">
                <div class="col-sm-6">
                    <div class="container">
                        <div class="row">
                            <h2 class="text-primary text-center col-sm-12">Danh mục loại sách</h2>
                            <div class="divTable">
                                <div class="divTableBody" id="danhMucLoaiSach">
                                    <div class="divTableRow">
                                        <div class="divTableCell text-center text-primary">Mã Loại</div>
                                        <div class="divTableCell text-center text-primary">Loại Sách</div>
                                    </div>
                                </div>
                            </div>
                            <button type="button" id="danhmuc_0" onclick="getDetail(this.id)" class="btn btn-info col-sm-12 mt-3">Chọn tất cả</button>
                        </div>
                    </div>
                </div>
                <div class="col-sm-6">
                    <div class="container">
                        <div class="row">
                            <h2 class="text-primary text-center col-sm-12">Danh mục sách</h2>
                            <div class="divTable">
                                <div class="divTableBody" id="danhMucSach">
                                    <div class="divTableRow ">
                                        <div class="divTableCell text-center text-primary">Mã Sách</div>
                                        <div class="divTableCell text-center text-primary">Mã Loại</div>
                                        <div class="divTableCell text-center text-primary">Tên Sách</div>
                                    </div>
                                </div>
                            </div>
                            <div hidden class="w-100 text-center text-danger noData">Không có dữ liệu</div>
                        </div>
                    </div>
                </div>
                <div class="col-sm-12 mt-5">
                    <div class="container">
                        <div class="row">
                            <h2 class="text-primary text-center col-sm-12">Thông tin chi tiết về danh mục sách</h2>
                            <div class="divTable">
                                <div class="divTableBody" id="chiTietDanhMucSach">
                                    <div class="divTableRow">
                                        <div class="divTableCell text-center text-primary">Mã Sách</div>
                                        <div class="divTableCell text-center text-primary">Loại Sách</div>
                                        <div class="divTableCell text-center text-primary">Tên Sách</div>
                                    </div>
                                </div>
                            </div>
                            <div hidden class="w-100 text-center text-danger noData">Không có dữ liệu</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
    <script>
        $(document).ready(function () {
            getLoaiSachData();
            <%--var totalRecords = parseInt(<%=totalPage%>);
            var pagesize = 10;
            var pageIndex = 1;
            var totalPages = totalRecords / pagesize;
            var end = (pagesize * pageIndex) - 1;
            var start = end - pagesize;
            if (start < 0) start = 0;
            alert("from " + start + " to " + end);--%>
        });

        function getLoaiSachData() {
            $.ajax({
                type: "POST",
                url: window.location.origin + "/Services/BTTHService.asmx/getB22LoaiSach",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    appendDanhMucLoaiSach(response.d);
                }
            });
        };

        function appendDanhMucLoaiSach(arr) {
            arr.forEach(item => {
                $("#danhMucLoaiSach").append("<div class=\"divTableRow\" style=\"cursor: pointer;\" id=\"danhmuc_" + item.Id + "\" onClick=\"getDetail(this.id)\">"
                    + "<div class= \"divTableCell text-center \">" + item.Id + "</div>"
                    + "<div class=\"divTableCell\">" + item.LoaiSach + ".</div></div>");
            });
        };

        function getDetail(value) {
            let data = { "id": value.split("_")[1] };
            $.ajax({
                type: "POST",
                url: window.location.origin + "/Services/BTTHService.asmx/getB22Sach",
                data: JSON.stringify(data),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    anppendResult(response.d);
                }
            });
        };

        function anppendResult(arr) {
            $(".danhMucSach").remove();
            $(".chiTietDanhMucSach").remove();
            $(".noData").prop("hidden", true);
            if (arr.length > 0) {
                arr.forEach(item => {
                    $("#danhMucSach").append("<div class=\"divTableRow danhMucSach\">"
                        + "<div class= \"divTableCell text-center\">" + item.MaSach + "</div>"
                        + "<div class=\"divTableCell text-center\">" + item.MaLoai + "</div>"
                        + "<div class=\"divTableCell\">" + item.TenSach + "</div>"
                        + "</div>");
                    $("#chiTietDanhMucSach").append("<div class=\"divTableRow chiTietDanhMucSach\">"
                        + "<div class= \"divTableCell text-center\">" + item.MaSach + "</div>"
                        + "<div class=\"divTableCell\">" + item.TenLoai + "</div>"
                        + "<div class=\"divTableCell\">" + item.TenSach + "</div>"
                        + "</div>");
                });
            } else {
                $(".noData").removeAttr("hidden");
            };
        };
    </script>
</body>
</html>
