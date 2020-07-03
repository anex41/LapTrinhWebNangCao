<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="bai21.aspx.cs" Inherits="LapTrinhWebNangCao.View.BTTH.Bai21.bai21" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Bài 21</title>
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
        <asp:UpdatePanel ID="updatepnl" runat="server">
            <ContentTemplate>
                <div class="container-fluid py-3">
                    <div class="row" style="justify-content: center;">
                        <div class="col-sm-5 border border-secondary rounded p-2 mr-1">
                            <div class="row">
                                <h1 class="col-sm-12 text-primary text-center">Bài 21</h1>
                                <div class="col-sm-12 mb-3">
                                    <div class="row">
                                        <div class="col-sm-3">
                                            Lái xe
                                        </div>
                                        <div class="col-sm-9 form-group mb-0">
                                            <asp:DropDownList CssClass="form-control" ID="driverNameList" runat="server" AutoPostBack="true" OnSelectedIndexChanged="driverNameList_SelectedIndexChanged"></asp:DropDownList>
                                        </div>
                                        <div class="col-sm-9 offset-sm-3 text-center">
                                            <asp:RequiredFieldValidator CssClass="text-danger" ID="driverRequired" runat="server" ErrorMessage="Chưa chọn lái xe" Display="Dynamic" ControlToValidate="driverNameList"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-12 mb-3">
                                    <div class="row">
                                        <div class="col-sm-3">
                                            Ngày
                                        </div>
                                        <div class="col-sm-9 form-group mb-0">
                                            <asp:TextBox hidden ClientIDMode="Static" CssClass="form-control" ID="txtDate" runat="server" TextMode="Date"></asp:TextBox>
                                            <input runat="server" class="form-control" id="inputDate" name="inputDate" type="text" onkeypress="changeDate()" />
                                        </div>
                                        <div class="col-sm-9 offset-sm-3 text-center">
                                            <div id="dateValidationDiv" hidden class="text-danger">Ngày nhập vào sai định dạng</div>
                                            <asp:RequiredFieldValidator CssClass="text-danger" ID="dateRequired" runat="server" ErrorMessage="Chưa chọn thông tin ngày" Display="Dynamic" ControlToValidate="txtDate"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-12 mb-3">
                                    <div class="row">
                                        <div class="col-sm-3">
                                            Đánh giá
                                        </div>
                                        <div class="col-sm-9 form-group mb-0">
                                            <asp:RadioButtonList CssClass="marginRightPlease" RepeatDirection="Horizontal" ID="reviewButton" runat="server">
                                                <asp:ListItem Value="1">1 sao</asp:ListItem>
                                                <asp:ListItem Value="2">2 sao</asp:ListItem>
                                                <asp:ListItem Value="3">3 sao</asp:ListItem>
                                                <asp:ListItem Value="4">4 sao</asp:ListItem>
                                                <asp:ListItem Value="5">5 sao</asp:ListItem>
                                            </asp:RadioButtonList>
                                        </div>
                                        <div class="col-sm-9 offset-sm-3 text-center">
                                            <asp:RequiredFieldValidator CssClass="text-danger" ID="reviewButtonRequried" runat="server" ErrorMessage="Yêu cầu điền thông tin đánh giá" Display="Dynamic" ControlToValidate="reviewButton"></asp:RequiredFieldValidator><br />
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-12">
                                    <asp:Button CausesValidation="false" ID="b21CancelBtn" runat="server" CssClass="btn btn-outline-danger float-right ml-3" Text="Hủy" OnClick="b21CancelBtn_Clicked" />
                                    <asp:Button hidden ID="b21SubmitBtn" ClientIDMode="static" runat="server" CssClass="btn btn-success float-right" OnClick="b21SubmitBtn_Clicked" />
                                    <button type="button" id="confirmSubmit" class="btn btn-success">Thực hiện</button>
                                    <%--<input style="float: right;" class="btn btn-outline-danger mx-3" type="reset" value="Hủy" />--%>
                                    <%--<button style="float: right;" type="button" class="btn btn-success">Thực hiện</button>--%>
                                    <%--<asp:Button ID="btnSubmit" runat="server" Text="Thực hiện" OnClick="btnSubmit_Click" OnClientClick="return myFunction();" />--%>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-5 border border-secondary rounded p-2">
                            <div class="row">
                                <h1 class="col-sm-12 text-primary text-center">Thông tin lái xe</h1>
                                <div runat="server" id="driverDiv" class="col-sm-12">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-8 m-auto p-3 fa-border border-secondary rounded" style="margin-top: 2% !important;">
                        <div class="row">
                            <h3 class="text-success text-center col-sm-12">Bảng thông tin đánh giá</h3>
                            <div id="driverInfoContent" runat="server" class="col-sm-12">
                            </div>
                        </div>
                    </div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </form>
    <script type="text/javascript" src="/Scripts/umd/popper.js"></script>
    <script type="text/javascript" src="/Scripts/bootstrap.js"></script>
    <script type="text/javascript" src="/Scripts/toastController.js"></script>
    <script>
        $(document).ready(function () {
            $("#inputDate").on("paste", function (e) {
                e.preventDefault();
            });
            $("#inputDate").on("drop", function (e) {
                e.preventDefault();
            });
            $("#confirmSubmit").on("click", function () {
                var x = confirm("Xác nhận thực hiện ?");
                if (x) {
                    $("#b21SubmitBtn").click();
                } else {
                    return false;
                }
            });
        });
        function changeDate() {
            setTimeout(() => {
                let patt = new RegExp(
                    'q|w|e|r|t|y|u|i|o|p|a|s|d|f|g|h|j|k|l|z|x|c|v|b|n|m'
                );
                const value = convertString($("#inputDate").val());
                if (patt.test(value) === false) {
                    if (value && value.length === 8) {
                        if (value.indexOf("-") === -1 && value.indexOf("/") === -1) {
                            const returnDate = replaceDate(value);
                            if (returnDate && returnDate.length > 0) {
                                $('#inputDate').val(returnDate);
                                let timeArr = returnDate.split('/');
                                let value = "" + (timeArr[2]) + "-" + (timeArr[1]) + "-" + (timeArr[0]);
                                $('#txtDate').val(value);
                                validateInputDate(new Date(timeArr[2],(timeArr[1]-1),timeArr[0]));
                            } else {
                                $('#inputDate').val("");
                            }
                        }
                    } else if (value.length > 10) {
                        $('#inputDate').val("");
                    }
                } else {
                    $('#inputDate').val("");
                };
            }, 200);
        }

        function validateInputDate(t) {
            let vo = new Date();
            if (t > vo) {
                $('#dateValidationDiv').removeAttr('hidden');
                $('#b21SubmitBtn').prop('disabled', true);
            }
            else {
                $('#dateValidationDiv').attr('hidden', true);
                $('#b21SubmitBtn').prop('disabled', false);
                return;
            };
        }

        function replaceDate(date) {
            date = date.toLowerCase();
            var patt = new RegExp(
                'q|w|e|r|t|y|u|i|o|p|a|s|d|f|g|h|j|k|l|z|x|c|v|b|n|m'
            );
            let returnDate = '';
            if (date.indexOf('-') === -1 && date.indexOf('/') === -1 && patt.test(date) === false) {
                let day;
                let month;
                let year;
                if (date.length === 8) {
                    day = date.substr(0, 2);
                    month = date.substr(2, 2);
                    year = date.substr(4, 4);
                } else if (date.length === 6) {
                    day = date.substr(0, 2);
                    month = date.substr(2, 2);
                    year = date.substr(4, 2);
                    if (parseInt(year, 0) < 50) {
                        year = parseInt('20' + year, 0);
                    } else {
                        year = parseInt('19' + year, 0);
                    }
                }
                if (parseInt(day, 0) > 31) {
                    day = 30;
                }
                if (parseInt(month, 0) > 12) {
                    month = 12;
                }
                if (parseInt(year, 0) > 3000) {
                    year = 2020;
                }
                returnDate = day + '/' + month + '/' + year;
            } else {
                returnDate = "";
            }
            return returnDate;
        };

        function convertString(str) {
            if (str === null || str === undefined) return str;
            str = str.toLowerCase();
            str = str.replace(/à|á|ạ|ả|ã|â|ầ|ấ|ậ|ẩ|ẫ|ă|ằ|ắ|ặ|ẳ|ẵ/g, "a");
            str = str.replace(/è|é|ẹ|ẻ|ẽ|ê|ề|ế|ệ|ể|ễ/g, "e");
            str = str.replace(/ì|í|ị|ỉ|ĩ/g, "i");
            str = str.replace(/ò|ó|ọ|ỏ|õ|ô|ồ|ố|ộ|ổ|ỗ|ơ|ờ|ớ|ợ|ở|ỡ/g, "o");
            str = str.replace(/ù|ú|ụ|ủ|ũ|ư|ừ|ứ|ự|ử|ữ/g, "u");
            str = str.replace(/ỳ|ý|ỵ|ỷ|ỹ/g, "y");
            str = str.replace(/đ/g, "d");
            return str;
        }
    </script>
</body>
</html>
