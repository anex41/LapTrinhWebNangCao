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
        <asp:UpdatePanel runat="server">
            <ContentTemplate>
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-sm-12 form-group mt-3">
                            <div class="row">
                                <asp:DropDownList CssClass="form-control col-sm-3 offset-sm-1" runat="server" ID="producerList" OnSelectedIndexChanged="producerList_SelectedIndexChanged"></asp:DropDownList>
                                <div class="col-sm-8">
                                    <div class="row">
                                        <div class="input-group col-sm-5">
                                            <div class="input-group-prepend">
                                                <span class="input-group-text">Giá</span>
                                            </div>
                                            <asp:TextBox CssClass="form-control" runat="server" ID="txtSPrice"></asp:TextBox>
                                        </div>
                                        <div class="col-sm-5 input-group">
                                            <div class="input-group-prepend">
                                                <span class="input-group-text">Đến</span>
                                            </div>
                                            <asp:TextBox CssClass="form-control" runat="server" ID="txtEPrice"></asp:TextBox>
                                        </div>
                                        <div class="col-sm-2">
                                            <asp:Button CssClass="btn btn-success" runat="server" ID="serachB23" Text="Tìm" />
                                        </div>
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
                        <div class="col-sm-4 input-group my-4">
                            <div class="input-group-prepend">
                                <span class="input-group-text">Số trang muốn đến</span>
                            </div>
                            <asp:TextBox CssClass="form-control" runat="server" TextMode="Number"></asp:TextBox>
                        </div>
                        <asp:Button hidden runat="server" ID="changePage" ClientIDMode="Static" OnClick="changePage_Click" />
                    </div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </form>
</body>
</html>
