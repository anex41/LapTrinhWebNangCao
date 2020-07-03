<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="KiemDuyet.aspx.cs" Inherits="LapTrinhWebNangCao.View.BTTH.Bai24.KiemDuyet" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Bài 24</title>
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
    </form>
    <div class="container-fluid">
        <div class="row p-3">
            <div class="col-sm-6 p-3 border-right border-bottom border-secondary">
                <div class="row">
                    <div class="col-sm-12 text-center text-primary">
                        <h2>Bảng kiểm duyệt</h2>
                    </div>
                    <div class="col-sm-12">
                        <div class="divTable">
                            <div class="divTableBody" id="disApprovedDiv">
                                <div class="divTableRow">
                                    <div class="divTableCell text-center">Tên Chuyên Mục</div>
                                    <div class="divTableCell text-center">Tiêu đề</div>
                                    <div class="divTableCell text-center">Hành động</div>
                                </div>
                            </div>
                        </div>
                        <div id="disapprovedListEmpty" class="w-100 text-center text-danger" hidden>
                            <h4>Không có dữ liệu</h4>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-sm-6 p-3 border-left border-bottom border-secondary">
                <div class="row">
                    <div class="col-sm-12 text-center text-primary">
                        <h2>Bảng hủy kiểm duyệt</h2>
                    </div>
                    <div class="col-sm-12">
                        <div class="divTable">
                            <div class="divTableBody" id="approvedDiv">
                                <div class="divTableRow">
                                    <div class="divTableCell text-center">Tên Chuyên Mục</div>
                                    <div class="divTableCell text-center">Tiêu đề</div>
                                    <div class="divTableCell text-center">Hành động</div>
                                </div>
                            </div>
                        </div>
                        <div id="approvedListEmpty" class="w-100 text-center text-danger" hidden>
                            <h4>Không có dữ liệu</h4>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-sm-12 text-center my-3">
                <a href="./View.aspx" class="btn btn-info text-white">Danh sách bản tin</a>
            </div>
        </div>
    </div>
    <script type="text/javascript" src="/Scripts/umd/popper.js"></script>
    <script type="text/javascript" src="/Scripts/bootstrap.js"></script>
    <script type="text/javascript" src="/Scripts/toastController.js"></script>
    <script>
        $(document).ready(function () {
            getDisapprovedList(-1);
            getApprovedList(-1);
        });

        function getDisapprovedList(id) {
            let data = { "id": id };
            $.ajax({
                type: "POST",
                url: window.location.origin + "/Services/BTTHService.asmx/GetB24DisapprovedList",
                data: JSON.stringify(data),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    anppendDisapprovedResult(response.d);
                }
            });
        };

        function getApprovedList(id) {
            let data = { "id": id };
            $.ajax({
                type: "POST",
                url: window.location.origin + "/Services/BTTHService.asmx/GetB24ApprovedList",
                data: JSON.stringify(data),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    anppendApprovedResult(response.d);
                }
            });
        };

        function anppendDisapprovedResult(arr) {
            $(".b24DDataRow").remove();
            if (arr != undefined) {
                if (arr.length > 0) {
                    $("#disapprovedListEmpty").prop("hidden", true);
                    arr.forEach(item => {
                        $("#disApprovedDiv").append("<div class=\"divTableRow b24DDataRow\"><div class= \"divTableCell text-center\" >" + item.CategoryName + "</div>"
                            + "<div class=\"divTableCell text-center\">" + item.Name + "</div>"
                            + "<div class=\"divTableCell text-center\">"
                            + "<button id=\"button_" + item.Id + "\" class=\"btn btn-success\" type=\"button\" onclick=\"approveNews(this.id)\">Duyệt</button>"
                            + "</div></div >");
                    });
                }
                else {
                    $("#disapprovedListEmpty").removeAttr("hidden");
                }
            } else {
                $("#disapprovedListEmpty").removeAttr("hidden");
            }
        };

        function anppendApprovedResult(arr) {
            $(".b24ADataRow").remove();
            if (arr != undefined) {
                if (arr.length > 0) {
                    $("#approvedListEmpty").prop("hidden", true);
                    arr.forEach(item => {
                        $("#approvedDiv").append("<div class=\"divTableRow b24ADataRow\"><div class= \"divTableCell text-center\" >" + item.CategoryName + "</div>"
                            + "<div class=\"divTableCell text-center\">" + item.Name + "</div>"
                            + "<div class=\"divTableCell text-center\">"
                            + "<button id=\"button_" + item.Id + "\" class=\"btn btn-outline-danger\" type=\"button\" onclick=\"disApproveNews(this.id)\">Hủy Duyệt</button>"
                            + "</div></div >");
                    });
                } else {
                    $("#approvedListEmpty").removeAttr("hidden");
                }
            } else {
                $("#approvedListEmpty").removeAttr("hidden");
            }
        };

        function approveNews(id) {
            let data = { "id": id.split("_")[1] };
            $.ajax({
                type: "POST",
                url: window.location.origin + "/Services/BTTHService.asmx/B24ApprovedNews",
                data: JSON.stringify(data),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function () {
                    refreshData();
                }
            });
        };

        function disApproveNews(id) {
            let data = { "id": id.split("_")[1] };
            $.ajax({
                type: "POST",
                url: window.location.origin + "/Services/BTTHService.asmx/B24DisApprovedNews",
                data: JSON.stringify(data),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function () {
                    refreshData();
                }
            });
        };

        function refreshData() {
            getDisapprovedList(-1);
            getApprovedList(-1);
        }
    </script>
</body>
</html>
