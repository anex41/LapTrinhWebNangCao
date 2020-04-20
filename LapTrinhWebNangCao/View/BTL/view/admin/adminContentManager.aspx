<%@ Page Title="Quản lý nội dung" Language="C#" MasterPageFile="~/View/BTL/view/admin/adminMaster.Master" AutoEventWireup="true" CodeBehind="adminContentManager.aspx.cs" Inherits="LapTrinhWebNangCao.View.BTL.view.admin.adminContentManager" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder" runat="server">
    <div class="container-fluid">
        <div class="row">
            <div class="col-sm-3">
            </div>
            <div class="col-sm-9">
                <h3 class="text-primary text-center">Nội dung Trang web</h3>
                <textarea cols="80" rows="10" id="content" name="content"> </textarea>
                <button id="saveCKData" class="btn btn-success" type="button">Lưu</button>
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
