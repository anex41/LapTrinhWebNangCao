<%@ Page Title="Quản lý nội dung" Language="C#" MasterPageFile="~/View/BTL/view/admin/adminMaster.Master" AutoEventWireup="true" CodeBehind="adminContentManager.aspx.cs" Inherits="LapTrinhWebNangCao.View.BTL.view.admin.adminContentManager" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder" runat="server">
    <div class="container-fluid">
        <div class="row">
            <div class="col-sm-3">
            </div>
            <div class="col-sm-9">
                <div class="row">
                    <h3 class="text-primary text-center col-sm-12">Nội dung Trang web</h3>
                    <textarea class="col-sm-12" cols="80" rows="10" id="content" name="content"> </textarea>
                    <div class="col-sm-12 text-center py-3">
                        <button id="saveCKData" class="btn btn-success w-25" type="button">Lưu</button>
                        <button id="cacelCKData" class="btn btn-outline-danger w-25" type="button">Hủy</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript" src="/../../../../Scripts/ckeditor/ckeditor.js"></script>
    <script>
        $(document).ready(function () {
            $("#saveCKData").on("click", function () {
                //console.log(CKEDITOR.instances.content.getData());
                let data = { "identity": "introduction", "content": CKEDITOR.instances.content.getData(), "activateFlagValue": true };
                $.ajax({
                    type: "POST",
                    url: window.location.origin + "/Services/contentManagerService.asmx/addWebContent",
                    data: JSON.stringify(data),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        if (response.d == true) {
                            alert(response.d);
                        }
                        else {
                            alert('null');
                        }
                    }
                });
            });
        });
        CKEDITOR.replace('content', {
            height: '500px',
            resize_enabled: 'false',
            uiColor: '#cccccc'
        });
    </script>
</asp:Content>
