﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Products.aspx.cs" Inherits="LapTrinhWebNangCao.View.BTTH.Bai17.Products" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid">
        <%--<asp:UpdatePanel ID="updatepnl" runat="server" class="container-fluid">
        <ContentTemplate>--%>
        <div class="row">
            <div id="cartChangeDiv" clientidmode="Static" runat="server" class="col-sm-3">
                Thay đổi trong giỏ hàng
            </div>
            <div class="col-sm-9 container-fluid bg-secondary">
                <div id="b17ProductsContent" clientidmode="Static" class="row" runat="server">
                </div>
            </div>
        </div>
        <div class="toastParent position-fixed d-flex flex-column p-4" style="z-index: 1; top: 0; width: 25vw; right: 0;">
            <div class="toast bg-success text-white toastSucceed" role="alert" data-delay="5000" data-autohide="true">
                <div class="toast-header">
                    <strong class="mr-auto text-success">Thành công</strong>
                    <%--<small class="text-muted">3 mins ago</small>--%>
                    <%--<button type="button" class="ml-2 mb-1 close" data-dismiss="toast" aria-label="Close">
                    <span aria-hidden="true">×</span>
                </button>--%>
                </div>
                <div class="toast-body">Thành công!</div>
            </div>
        </div>
        <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" data-backdrop="static" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h3 class="modal-title text-center text-primary w-100" id="exampleModalLabel">Số lượng muốn mua</h3>
                        <%--<button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>--%>
                    </div>
                    <div class="modal-body row">
                        <div class="col-sm-4">
                            Số lượng:
                        </div>
                        <div class="col-sm-8">
                            <input class="form-control" type="number" id="productAmount" />
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-outline-danger" data-dismiss="modal">Đóng</button>
                        <button class="btn btn-success" id="txtbtn" data-dismiss="modal">Thêm vào giỏ hàng</button>
                    </div>
                </div>
            </div>
        </div>
        <%--</ContentTemplate>
    </asp:UpdatePanel>--%>
    </div>
    <div style="position: fixed; bottom: 0; left: 0;" class="col-sm-3">
        <form action="ViewCart.aspx">
            <input hidden id="AddToCartParameter" name="AddToCartParameter" value="" />
            <input hidden id="Button1" type="button" onclick="sendForm1()" value="send" name="send" />
            <input class="btn btn-success d-block m-auto" id="Button1Submit" type="submit" value="Xác nhận giỏ hàng" name="send" />
        </form>
    </div>
    <script>
        var obj = {};
        var lstObj = [];
        var tempObj = {};
        $(document).ready(function () {
            $("#txtbtn").on("click", function () {
                obj.amount = $("#productAmount").val();
                addToLst(obj);
                addToSession(lstObj);
            });
        });

        function addToLst(obj) {
            let flag = true;
            if (lstObj.length > 0) {
                lstObj.forEach(function (item) {
                    if (item.B17id == parseInt(obj.id)) {
                        item.B17Amount++;
                        flag = false;
                    };
                });
            };
            if (flag) {
                let tempValue = {};
                tempValue.B17id = parseInt(obj.id);
                //tempValue.stock = obj.stock;
                tempValue.B17Name = obj.name;
                tempValue.B17Amount = parseInt(obj.amount);
                tempValue.B17Money = parseFloat(obj.price);
                lstObj.push(tempValue);
            }

        }

        function addCartData(id) {
            obj.id = id.split("_")[0];
            obj.stock = id.split("_")[1];
            obj.name = id.split("_")[2];
            obj.price = id.split("_")[3];
        };

        function addToSession(datax) {
            console.log(datax);
            $.ajax({
                type: "POST",
                url: window.location.origin + "/Services/BTTHService.asmx/AddSession",
                data: JSON.stringify({ B17Products: datax }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    if (response.d == null) {
                        alert("failed");
                    }
                    else {
                        addChange(datax);
                    }
                }
            });
        };

        function addChange(datax) {
            datax.forEach(function (item) {
                $("#cartChangeDiv").append("<div>Bạn đã thêm: " + item.B17Name + " với số lượng là: " + item.B17Amount + "</div>");
            });
            $("#cartChangeDiv").append("<hr />");
            $("#AddToCartParameter").val(datax);
            resetFeild();
        };

        function resetFeild() {
            $("#productAmount").val();
        };
    </script>
</asp:Content>
