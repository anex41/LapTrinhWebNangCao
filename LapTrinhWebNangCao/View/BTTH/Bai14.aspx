<%@ Page Title="Bài 2" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Bai14.aspx.cs" Inherits="LapTrinhWebNangCao.View.BTTH.Bai2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="w-100 text-center text-primary mb-3">
        <h1>Bài 2</h1>
        <button id="startbtn" class="btn btn-primary">Bắt đầu</button>
    </div>
    <div class="container-fluid" id="bai2Content">
        <div class="col-sm-6 border border-dark m-auto p-4">
            <div class="row">
                <div class="mb-3 col-sm-12 row">
                    <div class="col-sm-4">
                        Chiều cao
                    </div>
                    <div class="input-group col-sm-8">
                        <input id="inputHeight" type="text" class="form-control">
                        <div class="input-group-append">
                            <span class="input-group-text">m</span>
                        </div>
                    </div>
                </div>
                <div class="mb-3 col-sm-12 row">
                    <div class="col-sm-4">
                        Cân nặng
                    </div>
                    <div class="input-group col-sm-8">
                        <input id="inputWeight" type="text" class="form-control">
                        <div class="input-group-append">
                            <span class="input-group-text">kg</span>
                        </div>
                    </div>
                </div>
                <div id="BMIResult" class="col-sm-12 mb-3">
                    BMI của bạn là <span id="BMINumber"></span>, bạn ở <span id="result"></span>
                </div>
                <div class="col-sm-12 mb-2 text-right">
                    <button id="btnAction" class="btn btn-primary">Thực hiện</button>
                    <button id="btnCancel" class="btn btn-danger">Hủy</button>
                </div>
            </div>
        </div>
    </div>
    <script>
        $(document).ready(function () {
            $("#bai2Content").hide();
            $("#startbtn").on("click", function () {
                $("#bai2Content").show();
            });
            $("#btnAction").on("click", function () {
                let str1 = $("#inputHeight").val();
                let str2 = $("#inputWeight").val();
                if (!validateInput(str1 || !validateInput(str2))) {
                    $('.toastError').toast('show');
                    $("#BMIResult").html("Hãy kiểm tra lại các trường nhập vào!");
                    $("#BMIResult").addClass("text-danger");
                } else {
                    let BMI = calculateBMI(str1, str2);
                    $("#BMIResult").removeClass("text-danger");
                    $("#BMIResult").html("BMI của bạn là: " + BMI + ", bạn ở mức " + getReview(BMI));
                }
            });
            $("#btnCancel").on("click", function () {
                $("#bai2Content").hide();
                clearInput();
            });
        });

        function clearInput() {
            $("#inputHeight").val("");
            $("#inputWeight").val("");
        }

        function validateInput(str) {
            let patt = /^\d+(\.\d{1,4})?$/;
            let result = true;
            if (str == "") {
                result = false;
            } else {
                result = true;
            }
            if (patt.test(str)) {
                result = true;
            } else {
                result = false;
            }
            return result;
        }

        function calculateBMI(height, weight) {
            h = parseFloat(height);
            w = parseFloat(weight);
            return (w / (h * h)).toFixed(1);
        }

        function getReview(num) {
            let re = "";
            let x = parseFloat(num);
            if (x < 18.5) {
                re = "Dưới chuẩn";
            }
            if (x >= 18.5 && x <= 25) {
                re = "Chuẩn";
            }
            if (x > 25 && x < 30) {
                re = "Thừa cân";
            }
            if (x >= 30 && x <= 40) {
                re = "Béo, cần giảm cân";
            }
            else {
                re = "Rất béo, cần giảm cân ngay"
            }
            return re;
        }
    </script>
</asp:Content>
