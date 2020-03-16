<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Login.ascx.cs" Inherits="LapTrinhWebNangCao.View.BTL.userControl.Login" %>
<div class="row col-sm-12">
    <div class="col-sm-12 row mb-3">
        <div class="col-sm-4 m-auto">
            Tài khoản
        </div>
        <div class="col-sm-8 input-group">
            <%--<asp:TextBox CssClass="form-control" ID="txtName" runat="server"></asp:TextBox>--%>
            <input type="text" id="txtName" class="form-control">
        </div>
        <div class="offset-sm-4 col-sm-8 text-center text-danger">
            <span id="txtNameLength">Độ dài chỉ trong khoảng 6 đến 12 ký tự</span>
            <span id="txtNameRequired">Chưa nhập tên</span>
        </div>
    </div>
    <div class="col-sm-12 row mb-3">
        <div class="col-sm-4 m-auto">
            Mật khẩu
        </div>
        <div class="col-sm-8 input-group">
            <%--<asp:TextBox CssClass="form-control" ID="txtPassword" runat="server" TextMode="Password"></asp:TextBox>--%>
            <input type="text" id="txtPassword" class="form-control">
        </div>
        <div class="offset-sm-4 col-sm-8 text-center text-danger">
            <span id="txtPasswordLength">Độ dài chỉ trong khoảng 6 đến 12 ký tự</span>
            <span id="txtPasswordRequired">Chưa nhập mật khẩu</span>
        </div>
    </div>
    <div class="col-sm-12 mb-3 text-right">
        <button type="button" class="btn btn-primary" id="btnLogin">Đăng nhập</button>
    </div>

</div>
<script>
    $(document).ready(function () {
        $("#txtPasswordRequired").hide();
        $("#txtPasswordLength").hide();
        $("#txtNameLength").hide();
        $("#txtNameRequired").hide();
        $("#btnLogin").on("click", function () {
            if (!validateRequired()) {
                $('.toastError').toast('show');
            } else {
                if (validateLength()) {
                    let data = { "username": $("#txtName").val().trim(), "password": $("#txtPassword").val() };
                    $.ajax({
                        type: "POST",
                        url: window.location.origin + "/Services/Login.asmx/UserLogin",
                        data: JSON.stringify(data),
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (response) {
                            if (response.d == null) {
                                $('#exampleModal').modal('hide')
                                $('.toastError').toast('show');
                            }
                            else {
                                createSession(data, (response.d).toString());
                            }
                        }
                    });
                } else {
                    $('.toastError').toast('show');
                }
            }
        });
    });

    function validateRequired() {
        let result = true;
        let name = $("#txtName").val();
        let pass = $("#txtPassword").val();
        if (name == undefined || name == "") {
            $("#txtNameRequired").show();
            result = false;
        } else {
            $("#txtNameRequired").hide();
            result = true;
        }
        if (result) {
            if (pass == undefined || pass == "") {
                $("#txtPasswordRequired").show();
                result = false;
            } else {
                $("#txtPasswordRequired").hide();
                result = true;
            }
        }
        return result;
    }

    function validateLength() {
        let result = true;
        let name = $("#txtName").val().trim();
        let pass = $("#txtPassword").val().trim();
        if (name.length < 4 || name.length > 12) {
            $("#txtNameLength").show();
            result = false;
        } else {
            $("#txtNameLength").hide();
            result = true;
        }
        if (result) {
            if (pass.length < 6 || pass.length > 12) {
                $("#txtPasswordLength").show();
                result = false;
            } else {
                $("#txtPasswordLength").hide();
                result = true;
            }
        }
        return result;
    }

    function redirectPage(str) {
        if (str == "1") {
            window.location.replace(window.location.origin + "/View/BTL/view/admin/adminControllerView");
        } else if (str == "0") {
            window.location.replace(window.location.origin + "/View/BTL/view/client/clientControllerView");
        } else {
            $('.toastError').toast('show');
        }
    }

    function createSession(obj, str) {
        $.ajax({
            type: "POST",
            url: window.location.origin + "/Services/Login.asmx/createSession",
            data: JSON.stringify(obj),
            contentType: "application/json; charset=utf-8",
            dataType: "json"
        }).then(redirectPage(str));
    }
</script>
