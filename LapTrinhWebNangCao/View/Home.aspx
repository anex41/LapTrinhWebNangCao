<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="LapTrinhWebNangCao._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="jumbotron jumbotron-fluid">
        <div class="container text-center">
            <h1 class="display-4">Xin chào!</h1>
            <p class="lead">Hãy chọn mục bạn muốn xem!</p>
            <hr class="my-4">
            <p class="lead">
                <a id="btnBTL" href="./BTL/view/index.aspx" class="btn btn-primary">Bài tập lớn</a>
                <button id="btnBTTH" type="button" class="btn btn-primary">Bài tập thực hành</button>
            </p>
        </div>
    </div>
    <section class="col-sm-12" id="sectionBTTH">
        <div class="row">
            <div class="col-sm-11 text-center d-flex mb-2" style="justify-content: center;">
                <h5>Bài tập theo tuần: </h5>
                &nbsp&nbsp&nbsp
            <select>
                <option selected value="all">Tất cả</option>
                <option value="1">Tuần 1</option>
                <option value="2">Tuần 2</option>
                <option value="3">Tuần 3</option>
                <option value="4">Tuần 4</option>
                <option value="5">Tuần 5</option>
                <option value="6">Tuần 6</option>
            </select>
            </div>
            <span id="closeBTTH" class="col-sm-1 text-danger float-right" style="cursor: pointer;">
                Đóng   
                <i class="fas fa-times-circle"></i>
            </span>
        </div>
        <div class="row" id="divTuan1">
            <div class="card col-sm-4" id="divBai13">
                <div class="card-body">
                    <h5 class="card-title">Bài 13</h5>
                    <h6 class="card-subtitle mb-2 text-muted">Bài tập tuần 1</h6>
                    <p class="card-text">Ngôn Ngữ kịch bản, DOM & events</p>
                    <a href="./BTTH/Bai13.aspx" class="card-link">Đến Bài 13</a>
                </div>
            </div>
            <div class="card col-sm-4">
                <div class="card-body" id="divBai14">
                    <h5 class="card-title">Bài 14</h5>
                    <h6 class="card-subtitle mb-2 text-muted">Bài tập tuần 1</h6>
                    <p class="card-text">Ngôn Ngữ kịch bản, DOM & events</p>
                    <a href="./BTTH/Bai14.aspx" class="card-link">Đến Bài 14</a>
                </div>
            </div>
            <div class="card col-sm-4">
                <div class="card-body" id="divBai15">
                    <h5 class="card-title">Bài 15</h5>
                    <h6 class="card-subtitle mb-2 text-muted">Bài tập tuần 2</h6>
                    <p class="card-text">Server Side (Web Application project, Request, Response, Server, Configuration)</p>
                    <a href="./BTTH/bai15.htm" class="card-link">Đến Bài 15</a>
                </div>
            </div>
        </div>
    </section>
    <script>
        $(document).ready(function () {
            $("#sectionBTTH").hide();
            $("#btnBTL").on("click", function () {
                console.log("btl");
            });
            $("#btnBTTH").on("click", function () {
                $("#sectionBTTH").show();
            });
            $("#closeBTTH").on("click", function () {
                $("#sectionBTTH").hide();
            });
        })
    </script>
</asp:Content>
