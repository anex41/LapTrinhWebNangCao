<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="LapTrinhWebNangCao.View.BTTH.Bai18.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid w-50 mt-5 border p-4 border-dark rounded-lg">
        <div class="row">
            <div class="col-sm-12 row mb-3">
                <div class="col-sm-4 m-auto">
                    Tài khoản
                </div>
                <div class="col-sm-8 input-group">
                    <input type="text" id="txtName" class="form-control">
                </div>
                <div class="col-sm-12 text-center text-danger">
                    <span hidden id="txtNameLength">Độ dài chỉ trong khoảng 6 đến 12 ký tự</span>
                    <span hidden id="txtNameRequired">Chưa nhập tên</span>
                </div>
            </div>
            <div class="col-sm-12 row mb-3">
                <div class="col-sm-4 m-auto">
                    Mật khẩu
                </div>
                <div class="col-sm-8 input-group">
                    <input type="text" id="txtPassword" class="form-control">
                </div>
                <div class="col-sm-12 text-center text-danger">
                    <span hidden id="txtPasswordLength">Độ dài chỉ trong khoảng 6 đến 12 ký tự</span>
                    <span hidden id="txtPasswordRequired">Chưa nhập mật khẩu</span>
                </div>
            </div>
            <div class="col-sm-12 mb-3 text-right">
                <button type="button" class="btn btn-primary w-100" id="btnLogin">Đăng nhập</button>
                <form hidden action="https://localhost:44322/View/BTTH/Bai18/DoLogin" method="post" accept-charset="UTF-8">
                    <input hidden id="submitUsername" name="submitUsername" value="" />
                    <input hidden id="submitPassword" name="sumbitPassword" value="" />
                    <button hidden id="b18SubmitButton" type="submit"></button>
                </form>
            </div>
        </div>
    </div>
    <div class="container-fluid">
        <div id="LoginDetail" class="row" runat="server" style="overflow-y: scroll;">
        </div>
    </div>
    <div id="timmer" runat="server" clientidmode="Static" hidden></div>
    <div id="result"></div>
    <script>
        $(document).ready(function () {
            if ($.trim($('#timmer').html()).length > 0) {
                let distance = (new Date($.trim($('#timmer').html())) - Date.now() + 1000) / 1000 | 0;
                display = document.querySelector('#result');
                startTimer(distance, display);
            };
            //if ($.trim($('#timmer').html()).length > 0) {
            //    var x = new Date($("#timmer").html());
            //    var now = new Date().getTime();

            //    // Find the distance between now and the count down date
            //    var distance = x - now;

            //    // Time calculations for days, hours, minutes and seconds
            //    var days = Math.floor(distance / (1000 * 60 * 60 * 24));
            //    var hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
            //    var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
            //    var seconds = Math.floor((distance % (1000 * 60)) / 1000);

            //    alert(days + "d " + hours + "h "+ minutes + "m " + seconds + "s ");
            //};


            $("#btnLogin").on("click", function () {
                if (!validateRequired()) {
                    $('.toastError').toast('show');
                } else {
                    if (validateLength()) {
                        $("#submitUsername").val($("#txtName").val().trim());
                        $("#submitPassword").val($("#txtPassword").val());
                        $("#b18SubmitButton").click();
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
                $("#txtNameRequired").removeAttr("hidden");
                result = false;
            } else {
                $("#txtNameRequired").attr("hidden", "true");
                result = true;
            }
            if (result) {
                if (pass == undefined || pass == "") {
                    $("#txtPasswordRequired").removeAttr("hidden");
                    result = false;
                } else {
                    $("#txtPasswordRequired").attr("hidden", "true");
                    result = true;
                }
            }
            return result;
        }

        function validateLength() {
            let result = true;
            let name = $("#txtName").val().trim();
            let pass = $("#txtPassword").val().trim();
            if (name.length < 6 || name.length > 12) {
                $("#txtNameLength").removeAttr("hidden");
                result = false;
            } else {
                $("#txtNameLength").attr("hidden", "true");
                result = true;
            }
            if (result) {
                if (pass.length < 6 || pass.length > 12) {
                    $("#txtPasswordLength").removeAttr("hidden");
                    result = false;
                } else {
                    $("#txtPasswordLength").attr("hidden", "true");
                    result = true;
                }
            }
            return result;
        }

        function startTimer(duration, display) {
            var start = Date.now(),
                diff,
                minutes,
                seconds;
            function timer() {
                diff = duration - (((Date.now() - start) / 1000) | 0);
                minutes = (diff / 60) | 0;
                seconds = (diff % 60) | 0;
                minutes = minutes < 10 ? "0" + minutes : minutes;
                seconds = seconds < 10 ? "0" + seconds : seconds;
                display.textContent = "Bạn hãy chờ: " + minutes + ":" + seconds + " trước khi đăng nhập lại";

                if (diff <= 0) {
                    //start = Date.now() + 1000;
                    display.textContent = "Hãy đăng nhập lại";
                }
            };
            timer();
            setInterval(timer, 1000);
        }
    </script>
</asp:Content>
