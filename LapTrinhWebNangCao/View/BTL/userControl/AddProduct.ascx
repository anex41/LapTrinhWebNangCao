<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AddProduct.ascx.cs" Inherits="LapTrinhWebNangCao.View.BTL.userControl.AddProduct" %>
<div class="row mx-0 mt-2">
    <div class="col-sm-12 my-2">
        <div class="row mx-0">
            <div class="col-sm-6">
                <div class="row mx-0 input-group">
                    <div class="col-sm-3 my-auto">
                        Tiêu đề
                    </div>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" id="titleTxt" style="min-width: 100%;" />
                    </div>
                </div>
            </div>
            <div class="col-sm-6">
                <div class="row mx-0 input-group">
                    <div class="col-sm-3 my-auto">
                        Giá
                    </div>
                    <div class="col-sm-9">
                        <input placeholder="Đơn vị: Nghìn đồng" type="number" class="form-control" id="priceTxt" style="min-width: 100%;" />
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="col-sm-12 my-2">
        <div class="row mx-0">
            <div class="col-sm-6">
                <div class="row mx-0 input-group">
                    <div class="col-sm-3 my-auto">
                        Loại
                    </div>
                    <div class="col-sm-9">
                        <select class="form-control" id="catalogTxt" style="min-width: 100%;">
                            <option value="1">Bán chung cư</option>
                            <option value="2">Bán nhà riêng</option>
                            <option value="3">Bán biệt thự liền kề</option>
                            <option value="4">Bán đất</option>
                            <option value="5">Bán nhà kho</option>
                            <option value="6">Thuê chung cư</option>
                            <option value="7">Thuê nhà riêng</option>
                            <option value="8">Thuê nhà trọ, phòng trọ</option>
                            <option value="9">Thuê văn phòng</option>
                            <option value="10">Thuê cửa hàng</option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="col-sm-6">
                <div class="row mx-0 input-group">
                    <div class="col-sm-3 my-auto">
                        Địa chỉ
                    </div>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" id="addressTxt" style="min-width: 100%;" />
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="col-sm-12 my-2">
        <div class="row mx-0">
            <div class="col-sm-6">
                <div class="row mx-0 input-group">
                    <div class="col-sm-3 my-auto">
                        Thành phố
                    </div>
                    <div class="col-sm-9">
                        <select class="form-control" id="cityTxt" style="min-width: 100%;">
                            <option selected value="0"></option>
                            <option value="1">1</option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="col-sm-6">
                <div class="row mx-0 input-group">
                    <div class="col-sm-3 my-auto">
                        Quận
                    </div>
                    <div class="col-sm-9">
                        <select class="form-control" id="districtTxt" style="min-width: 100%;">
                            <option selected value="0"></option>
                            <option value="14">14</option>
                        </select>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="col-sm-12 my-2">
        <div class="row mx-0 form-group">
            <div class="col-sm-12" style="padding-left: 30px; padding-right: 30px;">
                Mô tả
                <textarea placeholder="Tối đa 200 từ." id="descriptionTxt" style="min-width: 100%; resize: none;" class="form-control"></textarea>
            </div>
        </div>
    </div>
    <div class="col-sm-12">
        <div class="row mx-0 form-group">
            <div class="col-sm-12" style="padding-left: 30px; padding-right: 30px;">
                Nội dung chi tiết
                <textarea id="ckEditorTxt" class="form-control"></textarea>
            </div>
        </div>
    </div>
    <div class="col-sm-12 mb-4">
        <div class="row m-0 form-group float-right" style="padding-right: 30px;">
            <button id="addProductBtn" type="button" class="btn btn-success mr-2" style="width: 100px">Thêm</button>
            <button type="button" class="btn btn-outline-danger" style="width: 100px">Hủy</button>
        </div>
    </div>
</div>
<script type="text/javascript" src="/../../../Scripts/ckeditor/ckeditor.js"></script>
<script>
    var currentProductId = 0;
    var editFlag = false;
    CKEDITOR.replace('ckEditorTxt', {
        height: '500px',
        resize_enabled: false,
        uiColor: '#cccccc'
    });

    $(document).ready(function () {
        $("#addProductBtn").on("click", function () {
            let title = $("#titleTxt").val().trim();
            let price = $("#priceTxt").val().trim();
            let catalog = $("#catalogTxt").val().trim();
            let address = $("#addressTxt").val().trim();
            let district = $("#districtTxt").val().trim();
            let description = $("#descriptionTxt").val().trim();
            let content = CKEDITOR.instances.ckEditorTxt.getData();

            if (validateFeild(title, "title") && validateFeild(price, "price")
                && validateFeild(catalog, "catalog") && validateFeild(address, "address")
                && validateFeild(district, "district") && validateFeild(description, "description")
                && validateFeild(content, "content")) {
                addProduct(title, price, catalog, address, district, description, content);
                clearInput();
            } else {
                return;
            };
        });
    });

    function validateFeild(str, type) {
        let flag = true;
        if (str == "" || str == null) {
            showInfoToast("Thông báo", "Hãy điền đầy đủ các trường");
            flag = false;
        } else {
            switch (type) {
                case "title":
                    str = str.split(" ");
                    if (str.length < 2) {
                        showErrorToast("Lỗi!", "Tiêu đề có độ dài tối thiểu 2 từ");
                        flag = false;
                    };
                    break;
                case "catalog":
                    let i = parseInt(str);
                    if (i > 10 || i < 1) {
                        showErrorToast("Lỗi!", "Giá trị loại không tồn tại");
                        flag = false;
                    };
                    break;
                case "address":
                    break;
                case "description":
                    str = str.split(" ");
                    if (str.length > 200) {
                        showErrorToast("Lỗi!", "Độ dài mô tả vượt quá quy định");
                        flag = false;
                    };
                    break;
                case "content":
                    break;
            };
        };
        return flag;
    };

    function clearInput() {
        $("#titleTxt").val("");
        $("#priceTxt").val("");
        $("#catalogTxt").val("1");
        $("#addressTxt").val("");
        $("#cityTxt").val("0");
        $("#districtTxt").val("0");
        $("#descriptionTxt").val("");
        CKEDITOR.instances.ckEditorTxt.setData("");
    };

    function addProduct(t, p, ca, a, dis, des, co) {
        if (!editFlag) {
            let data = {
                "name": t, "des": des, "catalog": ca,
                "date": new Date().toISOString().slice(0, 19).replace('T', ' '),
                "price": p, "address": a, "content": co, "district": dis
            };
            $.ajax({
                type: "POST",
                url: window.location.origin + "/Services/ProductService.asmx/CreateNewProduct",
                data: JSON.stringify(data),
                contentType: "application/json; charset=utf-8",
                dataType: "json"
            }).then(res => {
                showSucceedToast("Thành công!", "Đã thêm sản phẩm thành công");
                refreshAllList();
            });
        } else {
            let data = {
                "name": t, "des": des, "catalog": ca,
                "date": new Date().toISOString().slice(0, 19).replace('T', ' '),
                "price": p, "address": a, "content": co, "district": dis,
                "value": currentProductId
            };
            $.ajax({
                type: "POST",
                url: window.location.origin + "/Services/ProductService.asmx/editProduct",
                data: JSON.stringify(data),
                contentType: "application/json; charset=utf-8",
                dataType: "json"
            }).then(res => {
                showSucceedToast("Thành công!", "Đã sửa sản phẩm thành công");
                refreshAllList();
                editFlag = false;
                toggleEditState();
            });
        };
    };
</script>
