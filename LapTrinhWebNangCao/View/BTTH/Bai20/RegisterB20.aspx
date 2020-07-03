<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RegisterB20.aspx.cs" Inherits="LapTrinhWebNangCao.View.BTTH.Bai20.RegisterB20" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Bài 20</title>
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
        <div class="col-sm-6 w-50 m-auto pt-3">
            <div class="row">
                <div class="col-sm-12 mb-3">
                    <div class="input-group" style="justify-content: center;">
                        <asp:TextBox CssClass="form-control" ClientIDMode="Static" ID="txtSearch" runat="server"></asp:TextBox>
                        <div class="input-group-append">
                            <asp:Button CssClass="btn btn-outline-secondary" ID="btnSearch" runat="server" Text="Search" ValidationGroup="Search" />
                        </div>
                    </div>
                    <div class="text-center">
                        <asp:RequiredFieldValidator CssClass="text-danger" ID="RequiredFieldValidator1" runat="server" ErrorMessage="Search Field's Empty" Display="Dynamic" ValidationGroup="Search" ControlToValidate="txtSearch"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="col-sm-12 text-center mb-3">
                    <h2 class="text-primary">Register</h2>
                </div>
                <div class="col-sm-12 mb-3">
                    <div class="row">
                        <div class="col-sm-3">
                            First Name
                        </div>
                        <div class="col-sm-9 form-group">
                            <input class="form-control" id="txtName" type="text" onchange="changeValue()" />
                        </div>
                    </div>
                    <div class="text-center">
                        <asp:TextBox hidden="true" ID="txtFirstName" ClientIDMode="Static" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator CssClass="text-danger" ID="firstNameRequired" runat="server" ErrorMessage="First name missing!" Display="Dynamic" ControlToValidate="txtFirstName"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator CssClass="text-danger" ID="firstNameValidator" runat="server" ErrorMessage="First name Format Error" Display="Dynamic" ControlToValidate="txtFirstName" ValidationExpression="^[A-Za-z]+$"></asp:RegularExpressionValidator>
                    </div>
                </div>
                <div class="col-sm-12 mb-3">
                    <div class="row">
                        <div class="col-sm-3">
                            Last name
                        </div>
                        <div class="col-sm-9 form-group">
                            <asp:TextBox CssClass="form-control" ID="txtLastName" runat="server"></asp:TextBox>
                        </div>
                    </div>
                    <div class="text-center">
                        <asp:RequiredFieldValidator CssClass="text-danger" ID="lastNameRequired" runat="server" ErrorMessage="Last name missing!" ControlToValidate="txtLastName" Display="Dynamic"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="col-sm-12 mb-3">
                    <div class="row">
                        <div class="col-sm-3">
                            Password
                        </div>
                        <div class="col-sm-9 form-group">
                            <asp:TextBox CssClass="form-control" ID="txtPassword" runat="server"></asp:TextBox>
                        </div>
                    </div>
                    <div class="text-center">
                        <asp:RequiredFieldValidator CssClass="text-danger" ID="passwordRequired" runat="server" ErrorMessage="Password name missing!" ControlToValidate="txtPassword" Display="Dynamic"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator CssClass="text-danger" ID="passwordValidator" runat="server" ErrorMessage="Password format error" ControlToValidate="txtPassword" Display="Dynamic" ValidationExpression="^(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{6,}$"></asp:RegularExpressionValidator>
                    </div>
                </div>
                <div class="col-sm-12 mb-3">
                    <div class="row">
                        <div class="col-sm-3">
                            Re-type Password
                        </div>
                        <div class="col-sm-9 form-group">
                            <asp:TextBox CssClass="form-control" ID="txtRePassword" runat="server"></asp:TextBox>
                        </div>
                    </div>
                    <div class="text-center">
                        <asp:RequiredFieldValidator CssClass="text-danger" ID="rePasswordRequired" runat="server" ErrorMessage="Re-type Password name missing!" ControlToValidate="txtRePassword" Display="Dynamic"></asp:RequiredFieldValidator>
                        <asp:CompareValidator ID="rePasswordCompare" runat="server" ErrorMessage="Passwords not match" ForeColor="Red" Display="Dynamic" ControlToValidate="txtRePassword" ControlToCompare="txtPassword"></asp:CompareValidator>
                    </div>
                </div>
                <div class="text-center col-sm-12">
                    <asp:Button CssClass="btn btn-success" ID="btnSubmit" runat="server" Text="Submit" />
                </div>
            </div>
        </div>
    </form>
    <script type="text/javascript" src="/Scripts/umd/popper.js"></script>
    <script type="text/javascript" src="/Scripts/bootstrap.js"></script>
    <script type="text/javascript" src="/Scripts/toastController.js"></script>
    <script>

        function changeValue() {
            let value = $("#txtName").val().trim();
            if (value != null) {
                $("#txtFirstName").val(convertString(value));
            }
            else {
                return;
            }
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
        };
    </script>
</body>
</html>
