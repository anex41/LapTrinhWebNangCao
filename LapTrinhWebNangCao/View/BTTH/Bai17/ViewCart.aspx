<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ViewCart.aspx.cs" Inherits="LapTrinhWebNangCao.View.BTTH.Bai17.ViewCart" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid">
        <div class="row">
            <div class="col-sm-12">
                <h3 class="text-primary text-center">Danh sách các vật phẩm đã chọn</h3>
                <div id="contentDiv" runat="server" class="row p-3">
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" data-backdrop="static" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h3 class="modal-title text-center text-primary w-100" id="exampleModalLabel">Chỉnh sửa số lượng</h3>
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
                    <button type="button" id="deleteButton" class="btn btn-danger" data-dismiss="modal">Xóa</button>
                    <button class="btn btn-success" id="editBtn" data-dismiss="modal">Chỉnh sửa</button>
                </div>
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
    <script>
        var currentID = "";
        $(document).ready(function () {
            $("#editBtn").on("click", function () {
                if ($("#productAmount").val() == null || $("#productAmount").val() == "") {
                    $('.toastSucceed').toast('hide');
                    $('.toastError').toast('show');
                }
                else {
                    sendFixedData($("#productAmount").val());
                };
            });
            $("#deleteButton").on("click", function () {
                let data = { "id": currentID };
                $.ajax({
                    type: "POST",
                    url: window.location.origin + "/Services/BTTHService.asmx/DeleteB17Data",
                    data: JSON.stringify(data),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        if (response.d) {
                            location.reload();
                        }
                        else {
                            $('.toastSucceed').toast('hide');
                            $('.toastError').toast('show');
                        }
                    }
                });
            });
        });

        function sendFixedData(number) {
            let data = { "id": currentID, "amount": number };
            $.ajax({
                type: "POST",
                url: window.location.origin + "/Services/BTTHService.asmx/EditB17Data",
                data: JSON.stringify(data),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    switch (response.d) {
                        case -2:
                            console.log(-2);
                            break;
                        case -1:
                            console.log(-1);
                            break;
                        case 0:
                            console.log(0);
                            break;
                        case 1:
                            location.reload();
                            break;
                    }
                }
            });
        };

        function getItemID(id) {
            currentID = id;
        };
    </script>
</asp:Content>
