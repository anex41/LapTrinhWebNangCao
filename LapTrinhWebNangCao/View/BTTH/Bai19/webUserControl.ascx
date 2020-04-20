<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="webUserControl.ascx.cs" Inherits="LapTrinhWebNangCao.View.BTTH.Bai19.webUserControl" %>
<div class="container-fluid border border-secondary rounded">
    <div class="row">
        <div class="col-sm-12 mb-3">
            <h1 class="text-primary text-center">Register Form</h1>
        </div>
        <div class="col-sm-12 mb-3">
            <div class="row">
                <div class="col-sm-4">
                    Username
                </div>
                <div class="col-sm-8 input-group">
                    <asp:TextBox CssClass="form-control" ID="txtUsername" runat="server"></asp:TextBox>
                </div>
                <asp:RequiredFieldValidator CssClass="m-auto text-danger" ID="usernameRequired" runat="server" ErrorMessage="The Name does not allow null" Display="Dynamic" ControlToValidate="txtUsername"></asp:RequiredFieldValidator>
            </div>
        </div>
        <div class="col-sm-12 mb-3">
            <div class="row">
                <div class="col-sm-4">
                    Password
                </div>
                <div class="col-sm-8 input-group">
                    <asp:TextBox CssClass="form-control" ID="txtPassword" runat="server"></asp:TextBox>
                </div>
                <asp:RequiredFieldValidator CssClass="m-auto text-danger" ID="passwordRequired" runat="server" ErrorMessage="The Password does not allow null" Display="Dynamic" ControlToValidate="txtPassword"></asp:RequiredFieldValidator>
            </div>
        </div>
        <div class="col-sm-12 mb-3">
            <div class="row">
                <div class="col-sm-4">
                    Email
                </div>
                <div class="col-sm-8 input-group">
                    <asp:TextBox CssClass="form-control" ID="txtEmail" runat="server"></asp:TextBox>
                </div>
                <asp:RequiredFieldValidator CssClass="m-auto text-danger" ID="emailRequired" runat="server" ErrorMessage="The Email does not allow null" Display="Dynamic" ControlToValidate="txtEmail"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator CssClass="m-auto text-danger" ID="EmailValidator" runat="server" ErrorMessage="Your entry is not a valid email address" Display="Dynamic" ControlToValidate="txtEmail" ValidationExpression="^([\w\.\-]+)@([\w\-]+)((\.(\w){2,})+)$"></asp:RegularExpressionValidator>
            </div>
        </div>
        <div class="col-sm-12 mb-3">
            <div class="row">
                <div class="col-sm-4">
                    Retype Email
                </div>
                <div class="col-sm-8 input-group">
                    <asp:TextBox CssClass="form-control" ID="txtReEmail" runat="server"></asp:TextBox>
                </div>
                <asp:CompareValidator CssClass="m-auto text-danger" ControlToCompare="txtEmail" ID="reEmailValidator" runat="server" ErrorMessage="Does not match!!" Display="Dynamic" ControlToValidate="txtReEmail"></asp:CompareValidator>
            </div>
        </div>
        <div class="col-sm-12 mb-3">
            <div class="row">
                <div class="col-sm-4">
                    Age
                </div>
                <div class="col-sm-8 input-group">
                    <asp:TextBox CssClass="form-control" ID="txtAge" runat="server" TextMode="Number"></asp:TextBox>
                </div>
                <asp:RangeValidator Type="Integer" MinimumValue="0" MaximumValue="100" CssClass="m-auto text-danger" ID="ageValidator" runat="server" ErrorMessage="Age out of range !!" Display="Dynamic" ControlToValidate="txtAge"></asp:RangeValidator>
            </div>
        </div>
        <div class="col-sm-12 mb-3">
            <div class="row">
                <div class="col-sm-4">
                    Sex
                </div>
                <div class="col-sm-8 input-group">
                    <asp:RadioButtonList RepeatDirection="Horizontal" ID="txtSex" runat="server" CellSpacing="10" >
                        <asp:ListItem>Male</asp:ListItem>
                        <asp:ListItem>Female</asp:ListItem>
                    </asp:RadioButtonList>
                </div>
                <asp:RequiredFieldValidator CssClass="m-auto text-danger" ID="sexRequired" runat="server" ErrorMessage="Missing info !!" Display="Dynamic" ControlToValidate="txtSex"></asp:RequiredFieldValidator>
            </div>
        </div>
        <div class="col-sm-12 mb-3">
            <div class="row">
                <div class="col-sm-4">
                    Class name:
                </div>
                <div class="col-sm-8 input-group">
                    <asp:DropDownList CssClass="form-control" runat="server" ID="classList"></asp:DropDownList>
                </div>
            </div>
        </div>
        <div class="col-sm-12 mb-3">
            <div class="row">
                <div class="col-sm-4">
                    Subject
                </div>
                <div class="col-sm-8 input-group">
                    <asp:ListBox CssClass="form-control" ID="subjectList" runat="server" SelectionMode="Multiple" Rows="2"></asp:ListBox>
                </div>
                <asp:RequiredFieldValidator CssClass="m-auto text-danger" ID="subjectRequired" runat="server" ErrorMessage="Missing info !!" ControlToValidate="subjectList" Display="Dynamic"></asp:RequiredFieldValidator>
            </div>
        </div>
        <div class="col-sm-12 mb-3 text-danger">
            <asp:ValidationSummary ID="validationSum" runat="server" ShowMessageBox="false" ShowSummary="true" />
        </div>
        <div class="col-sm-12 text-center">
            <asp:Button CssClass="btn btn-primary" ID="btnSubmit" runat="server" Text="Submit" />
        </div>
    </div>
</div>

