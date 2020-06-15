<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="EditProduct.ascx.cs" Inherits="LapTrinhWebNangCao.View.BTL.userControl.EditProduct" %>
<div class="row m-0">
    <div class="col-sm-12 text-primary text-center">
        <h1>Danh sách nội dung</h1>
    </div>
    <div class="col-sm-12">
        <div class="row m-0" id="editProductList">
        </div>
    </div>
</div>
<script>
    $(document).ready(function () {
        getEditProductList();
    });

    function getEditProductList() {
        $.ajax({
            type: "POST",
            url: window.location.origin + "/Services/ProductService.asmx/GetEditProductList",
            contentType: "application/json; charset=utf-8",
            dataType: "json"
        }).then(res => {
            appendEditProductList(res.d);
        });
    };

    function appendEditProductList(arr) {
        let divvar = $("#editProductList");
        $(".editProductItem").remove();
        arr.forEach(item => {
            divvar.append("<div class=\"row m-0 mb-2 editProductItem\"><div class=\"col-sm-2\"><img class=\"w-100 h-100\" alt=\"\" src=\"/../../../../Assets/nhaDep1.jpg\"/></div>"
                + "<div class=\"col-sm-10\"><div class=\"row m-0\">"
                + "<div class=\"col-sm-12\"><div class=\"row m-0\"><h3 class=\"col-sm-6 px-0 text-primary\">" + item.Name + "</h3><div class=\"col-sm-6 px-0 m-auto\">"
                + "<button type=\"button\" id=\"" + item.Id + "\" class=\"float-right btn btn-success\" onclick=\"editSelected(this.id)\">Sửa"
                + "</button></div></div></div>"
                + "<div class=\"col-sm-12 productDescription\">" + item.Description + "</div><div class=\"col-sm-12\"><div class=\"row m-0\"><div class=\"col-sm-6 p-0\">"
                + "Đăng bởi: " + item.User + "</div><div class=\"col-sm-6 p-0 text-right\">Ngày : " + formatDate(item.AddedDate).toLocaleDateString()
                + "</div></div ></div ><div class=\"col-sm-12 text-right\">"
                + "Lượt xem: " + item.SeenNumber + "</div></div></div></div>");
        });
    };

    function editSelected(value) {
        currentProductId = value;
        editFlag = true;
        let data = { "id": "" + value };
        $.ajax({
            type: "POST",
            url: window.location.origin + "/Services/ProductService.asmx/GetEditProductById",
            data: JSON.stringify(data),
            contentType: "application/json; charset=utf-8",
            dataType: "json"
        }).then(res => {
            $("#titleTxt").val(res.d.Name);
            $("#priceTxt").val(res.d.Price);
            $("#catalogTxt").val(res.d.Catalog);
            $("#addressTxt").val(res.d.Address);
            $("#cityTxt").val(res.d.City);
            $("#districtTxt").val(res.d.District);
            $("#descriptionTxt").val(res.d.Description);
            CKEDITOR.instances.ckEditorTxt.setData(res.d.Content);
            changeView("add");
            showInfoToast("Thông báo", "Bạn đang ở chế độ sửa");
            toggleEditState();
        });
    };
</script>
