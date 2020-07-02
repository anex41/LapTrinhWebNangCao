<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ApproveProduct.ascx.cs" Inherits="LapTrinhWebNangCao.View.BTL.userControl.ApproveProduct" %>
<div class="row m-0">
    <div class="col-sm-12 text-center">
        <h1 class="text-success">Chấp thuận nội dung</h1>
    </div>
    <div class="col-sm-12">
        <div class="row m-0" id="disapproveProductList">
        </div>
    </div>
</div>
<script>
    $(document).ready(function () {
        getDisapproveProductList();
    });

    function getDisapproveProductList() {
        $.ajax({
            type: "POST",
            url: window.location.origin + "/Services/ProductService.asmx/GetDisapproveProduct",
            contentType: "application/json; charset=utf-8",
            dataType: "json"
        }).then(res => {
            appendDisapproveProductList(res.d);
        });
    };

    function appendDisapproveProductList(arr) {
        let dDiv = $("#disapproveProductList");
        $(".disapproveProductItem").remove();
        arr.forEach(item => {
            dDiv.append("<div class=\"row m-0 mb-2 disapproveProductItem\"><div class=\"col-sm-2\"><img class=\"w-100 h-100\" alt=\"\" src=\"/../../../../Assets/nhaDep1.jpg\"/></div>"
                + "<div class=\"col-sm-10\"><div class=\"row m-0\">"
                + "<div class=\"col-sm-12\"><div class=\"row m-0\"><h3 class=\"col-sm-6 px-0 text-primary\">" + item.Name + "</h3><div class=\"col-sm-6 px-0 m-auto\">"
                + "<button type=\"button\" id=\"" + item.Id + "\" class=\"float-right btn btn-success\" onclick=\"approveSelected(this.id)\">Duyệt"
                + "</button></div></div></div>"
                + "<div class=\"col-sm-12 productDescription\">" + item.Description + "</div><div class=\"col-sm-12\"><div class=\"row m-0\"><div class=\"col-sm-6 p-0\">"
                + "Đăng bởi: " + item.User + "</div><div class=\"col-sm-6 p-0 text-right\">Ngày : " + formatDate(item.AddedDate).toLocaleDateString()
                + "</div></div ></div ><div class=\"col-sm-12 text-right\">"
                + "Lượt xem: " + item.SeenNumber + "</div></div></div></div>");
        });
    };

    function approveSelected(value) {
        var cf = confirm("Bạn xác có xác nhận duyệt sản phẩm / bài đăng?");
        if (cf) {
            let data = { "value": "" + value };
            $.ajax({
                type: "POST",
                url: window.location.origin + "/Services/ProductService.asmx/ApproveProduct",
                data: JSON.stringify(data),
                contentType: "application/json; charset=utf-8",
                dataType: "json"
            }).then(res => {
                showSucceedToast("Thành công", "Đã duyệt sản phẩm");
                refreshAllList();
            });
        } else {
            return;
        };
    };
</script>
