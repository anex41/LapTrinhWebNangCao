<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="DisapproveProduct.ascx.cs" Inherits="LapTrinhWebNangCao.View.BTL.userControl.DisapproveProduct" %>
<div class="row m-0">
    <div class="col-sm-12 text-center">
        <h1 class="text-danger">Hủy chấp thuận nội dung</h1>
    </div>
    <div class="col-sm-12">
        <div class="row m-0" id="approveProductList">
        </div>
    </div>
</div>
<script>
    $(document).ready(function () {
        getApproveProductList();
    });

    function getApproveProductList() {
        $.ajax({
            type: "POST",
            url: window.location.origin + "/Services/ProductService.asmx/getApproveProduct",
            contentType: "application/json; charset=utf-8",
            dataType: "json"
        }).then(res => {
            appendApproveProductList(res.d);
        });
    };

    function appendApproveProductList(arr) {
        let aDiv = $("#approveProductList");
        $(".approveProductItem").remove();
        arr.forEach(item => {
            aDiv.append("<div class=\"row m-0 mb-2 approveProductItem\"><div class=\"col-sm-2\"><img class=\"w-100 h-100\" alt=\"\" src=\"/../../../../Assets/nhaDep1.jpg\"/></div>"
                + "<div class=\"col-sm-10\"><div class=\"row m-0\">"
                + "<div class=\"col-sm-12\"><div class=\"row m-0\"><h3 class=\"col-sm-6 px-0 text-primary\">" + item.Name + "</h3><div class=\"col-sm-6 px-0 m-auto\">"
                + "<button type=\"button\" id=\"" + item.Id + "\" class=\"float-right btn btn-danger\" onclick=\"disapproveSelected(this.id)\">Hủy duyệt"
                + "</button></div></div></div>"
                + "<div class=\"col-sm-12 productDescription\">" + item.Description + "</div><div class=\"col-sm-12\"><div class=\"row m-0\"><div class=\"col-sm-6 p-0\">"
                + "Đăng bởi: " + item.User + "</div><div class=\"col-sm-6 p-0 text-right\">Ngày : " + formatDate(item.AddedDate).toLocaleDateString()
                + "</div></div ></div ><div class=\"col-sm-12 text-right\">"
                + "Lượt xem: " + item.SeenNumber + "</div></div></div></div>");
        });
    };

    function disapproveSelected(value) {
        var cf = confirm("Bạn xác có xác nhận duyệt sản phẩm / bài đăng?");
        if (cf) {
            let data = { "value": "" + value };
            $.ajax({
                type: "POST",
                url: window.location.origin + "/Services/ProductService.asmx/DisapproveProduct",
                data: JSON.stringify(data),
                contentType: "application/json; charset=utf-8",
                dataType: "json"
            }).then(res => {
                showSucceedToast("Thành công", "Đã hủy duyệt sản phẩm");
                refreshAllList();
            });
        } else {
            return;
        }

    };
</script>

