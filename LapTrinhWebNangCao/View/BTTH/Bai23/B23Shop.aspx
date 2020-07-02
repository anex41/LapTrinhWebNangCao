<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="B23Shop.aspx.cs" Inherits="LapTrinhWebNangCao.View.BTTH.Bai23.B23Shop" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Bài 23</title>
    <asp:PlaceHolder runat="server">
        <%: Scripts.Render("~/bundles/modernizr") %>
    </asp:PlaceHolder>
    <webopt:BundleReference runat="server" Path="~/Content/css" />
    <link href="~/favicon.ico" rel="shortcut icon" type="image/x-icon" />
    <link rel="stylesheet" type='text/css' href="/Content/fontawesome-all.css" />
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager runat="server">
            <Scripts>
                <asp:ScriptReference Name="MsAjaxBundle" />
                <asp:ScriptReference Name="jquery" />
            </Scripts>
        </asp:ScriptManager>
        <asp:UpdatePanel runat="server">
            <ContentTemplate>
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-sm-12 form-group mt-3">
                            <div class="row">
                                <asp:DropDownList AutoPostBack="True" CssClass="form-control col-sm-3 offset-sm-1" runat="server" ID="producerList" OnSelectedIndexChanged="producerList_SelectedIndexChanged"></asp:DropDownList>
                                <div class="col-sm-8">
                                    <div class="row">
                                        <div class="col-sm-5">
                                            <div class="input-group">
                                                <div class="input-group-prepend">
                                                    <span class="input-group-text">Giá</span>
                                                </div>
                                                <input class="form-control" runat="server" type="number" id="inputSPrice" onkeypress="validatePageValue(event)" />
                                            </div>
                                            <div hidden id="inputSPriceError" class="text-center w-100 text-danger">Không hợp lệ!</div>
                                        </div>
                                        <div class="col-sm-4">
                                            <div class="input-group">
                                                <div class="input-group-prepend">
                                                    <span class="input-group-text">Đến</span>
                                                </div>
                                                <input class="form-control" runat="server" type="number" id="inputEPrice" onkeypress="validatePageValue(event)" />
                                            </div>
                                            <div hidden id="inputEPriceError" class="text-center w-100 text-danger">Không hợp lệ!</div>
                                        </div>
                                        <div class="col-sm-3">
                                            <button type="button" onclick="validatePrice()" class="btn btn-success">Tìm</button>
                                            <button id="refreshPriceButton" visible="false" runat="server" type="button" onclick="refreshPriceSearch()" class="btn btn-outline-info">Xóa điều kiện</button>
                                            <asp:Button hidden CssClass="btn btn-success" runat="server" ID="serachB23" ClientIDMode="Static" OnClick="serachB23_Click" />
                                        </div>
                                        <div hidden id="priceCompareError" class="w-100 text-center text-danger">Giá điền vào sai quy định (vế trái lớn hơn vế phải)</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-12 mt-3">
                            <div class="col-sm-12 text-center" style="position: relative;">
                                <h2 class="text-primary">Danh sách điện thoại</h2>
                                <div style="top: 0; position: absolute; right: 0;">
                                    <asp:Button CssClass="btn btn-info mr-1" runat="server" Text="30" OnClick="changePageSize" />
                                    <asp:Button CssClass="btn btn-info mr-1" runat="server" Text="60" OnClick="changePageSize" />
                                    <asp:Button CssClass="btn btn-info mr-1" runat="server" Text="120" OnClick="changePageSize" />
                                </div>
                            </div>
                            <div runat="server" id="phoneData" class="row">
                            </div>
                        </div>
                        <div class="col-sm-8 my-4" runat="server" id="pageButton">
                        </div>
                        <div id="pageInput" runat="server" class="col-sm-4 input-group my-4">
                            <div class="input-group-prepend">
                                <span class="input-group-text bg-success text-white">Số trang muốn đến</span>
                            </div>
                            <input runat="server" class="form-control" id="inputPageValue" type="number" onkeypress="validatePageValue(event)" />
                            <div class="input-group-append">
                                <button onclick="confirmPageChange()" class="btn btn-outline-success" type="button"><i class="fas fa-arrow-alt-circle-right "></i></button>
                            </div>
                            <div id="noPageFound" runat="server" visible="false" class="text-center text-danger w-100">
                                Số trang không tồn tại
                            </div>
                        </div>
                        <input hidden runat="server" id="pageValue" type="text" />
                        <asp:Button Text="" hidden runat="server" ID="changePage" ClientIDMode="Static" OnClick="changePage_Click" />
                    </div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </form>
    <%: Scripts.Render("~/bundles/modernizrr") %>
    <script>
        $(document).ready(function () {
            $("#inputPageValue").on("paste", function (e) {
                e.preventDefault();
            });
            $("#inputPageValue").on("drop", function (e) {
                e.preventDefault();
            });
            $("#inputEPrice").on("paste", function (e) {
                e.preventDefault();
            });
            $("#inputEPrice").on("drop", function (e) {
                e.preventDefault();
            });
            $("#inputSPrice").on("paste", function (e) {
                e.preventDefault();
            });
            $("#inputSPrice").on("drop", function (e) {
                e.preventDefault();
            });
        });

        function confirmPageChange() {
            if ($("#inputPageValue").val() == "") return false;
            else {
                $("#pageValue").val($("#inputPageValue").val());
                $("#inputPageValue").val("");
                $("#changePage").click();
            }
        };

        function refreshPriceSearch() {
            $("#inputSPrice").val("-1");
            $("#inputEPrice").val("-1");
            $("#serachB23").click();
        };

        function getPageIndex(value) {
            let identity = value.split("_")[1];
            $("#pageValue").val(identity + '');
            $("#changePage").click();
        };

        function validatePageValue(e) {
            if (e.key == "e" || e.key == "-")
                e.preventDefault();
        };

        function validatePrice() {
            let flag = true;
            let valueA = $("#inputSPrice").val();
            let valueB = $("#inputEPrice").val();
            if (valueA == "" || valueA < 0) {
                $("#inputSPriceError").removeAttr("hidden");
                flag = false;
            } else {
                $("#inputSPriceError").prop("hidden", true);
                flag = true;
            };
            if (valueB == "" || valueB < 0) {
                $("#inputEPriceError").removeAttr("hidden");
                flag = false;

            } else {
                $("#inputEPriceError").prop("hidden", true);
                flag = true;
            };
            if (parseFloat(valueA) > parseFloat(valueB)) {
                $("#priceCompareError").removeAttr("hidden");
                flag = false;
            }
            else {
                $("#priceCompareError").prop("hidden", true);
                flag = true;
            };
            if (flag) {
                $("#serachB23").click();
            };
        };
    </script>
</body>
</html>
