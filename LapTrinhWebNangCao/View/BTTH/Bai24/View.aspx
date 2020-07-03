<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="View.aspx.cs" Inherits="LapTrinhWebNangCao.View.BTTH.Bai24.View" %>

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
    <div class="container-fluid p-3">
        <div class="row">
            <div class="col-sm-12 p-3 border-bottom border-secondary">
                <div class="row">
                    <div class="col-sm-6">
                        <h2 class="text-primary text-center">Nội dung các bài báo</h2>
                    </div>
                    <div hidden id="b24SignInBtn" class="col-sm-6">
                        <button type="button" class="btn btn-info float-right" data-toggle="modal" data-target="#exampleModal">Đăng nhập</button>
                    </div>
                    <div hidden id="b24SignOutBtn" class="col-sm-6">
                        <button type="button" class="btn btn-danger float-right" onclick="signOut()">Đăng xuất</button>
                    </div>
                </div>
            </div>
            <div class="col-sm-12 my-3">
                <div id="NewsList" class="row">
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" data-backdrop="static" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h3 class="modal-title text-center text-primary w-100" id="exampleModalLabel">Đăng nhập</h3>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-sm-12 mb-3">
                            <div class="row">
                                <div class="col-sm-4 m-auto">
                                    Tài khoản
                                </div>
                                <div class="col-sm-8 input-group">
                                    <input type="text" id="txtUsername" class="form-control" />
                                </div>
                                <div class="offset-sm-4 col-sm-8 text-center text-danger">
                                    <span hidden id="txtNameRequired">Chưa nhập tên</span>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-12 mb-3">
                            <div class="row">
                                <div class="col-sm-4 m-auto">
                                    Mật khẩu
                                </div>
                                <div class="col-sm-8 input-group">
                                    <input type="text" id="txtPassword" class="form-control" />
                                </div>
                                <div class="offset-sm-4 col-sm-8 text-center text-danger">
                                    <span hidden id="txtPasswordRequired">Chưa nhập mật khẩu</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-danger" data-dismiss="modal">Đóng</button>
                    <button type="button" onclick="signIn()" class="btn btn-primary">Đăng nhập</button>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript" src="/Scripts/umd/popper.js"></script>
    <script type="text/javascript" src="/Scripts/bootstrap.js"></script>
    <script type="text/javascript" src="/Scripts/toastController.js"></script>
    <script>
        $(document).ready(function () {
            checkLogin();
        });

        function renderNews(flag) {
            let data;
            if (flag) {
                data = { "allFlag": true };
            } else {
                data = { "allFlag": false };
            }
            $.ajax({
                type: "POST",
                url: window.location.origin + "/Services/BTTHService.asmx/GetB24News",
                data: JSON.stringify(data),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    renderList(response.d);
                }
            });
        };

        function renderList(arr) {
            $(".b24NewsContent").remove();
            if (arr != undefined) {
                if (arr.length > 0) {
                    arr.forEach(item => {
                        $("#NewsList").append("<div class=\"b24NewsContent col-sm-4 mb-5\"><div class= \"card\"><div class=\"card-header text-primary text-center\">"
                            + item.CategoryName + "</div><div class=\"card-body\"><h5 class=\"card-title text-center\">"
                            + item.Title + "</h5> <p class=\"card-text\">" + item.Content + "</p><div class=\"row\"><div class= \"col-sm-6\">Ngày đăng: "
                            + item.PostedDate + "</div><div class=\"col-sm-6 text-right\">Người đăng: " + item.UserID
                            + "</div></div></div></div></div>");
                    });
                }
            }
        };

        function checkLogin() {
            let result = false;
            $.ajax({
                type: "POST",
                url: window.location.origin + "/Services/BTTHService.asmx/CheckB24LoginStatus",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    result = response.d;
                }
            }).then(function () {
                if (result == true) {
                    renderNews(true);
                    $("#b24SignOutBtn").removeAttr("hidden");
                    $("#b24SignInBtn").prop("hidden", true);
                }
                else {
                    renderNews(false);
                    $("#b24SignOutBtn").prop("hidden", true);
                    $("#b24SignInBtn").removeAttr("hidden");
                };
            });
        };

        function signIn() {
            let user = $("#txtUsername").val();
            let pass = $("#txtPassword").val();
            if (validateFeild(user, pass)) {
                let data = { "name": user, "password": pass };
                $.ajax({
                    type: "POST",
                    url: window.location.origin + "/Services/BTTHService.asmx/LoginB24",
                    data: JSON.stringify(data),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        switch (parseInt(response.d)) {
                            case -2:
                                alert("Đăng nhập thất bại");
                                break;
                            case -1:
                                alert("Đăng nhập thất bại");
                                break;
                            case 1:
                                checkLogin();
                                $('#exampleModal').modal('hide');
                                $("#txtUsername").val("");
                                $("#txtPassword").val("");
                                break;
                        };
                    }
                });
            } else {
                alert("Đăng nhập thất bại");
            };
        };

        function validateFeild(u, p) {
            if (u.length > 0 && p.length > 0) {
                $("#txtNameRequired").prop("hidden", true);
                $("#txtNameRequired").prop("hidden", true);
                return true;
            } else {
                ("#txtNameRequired").removeAttr("hidden");
                $("#txtNameRequired").removeAttr("hidden");
                return false;
            };
        };

        function signOut() {
            $.ajax({
                type: "POST",
                url: window.location.origin + "/Services/BTTHService.asmx/SignOutB24",
                contentType: "application/json; charset=utf-8",
                dataType: "json"
            }).then(function () {
                checkLogin();
            });
        };
    </script>
</body>
</html>
