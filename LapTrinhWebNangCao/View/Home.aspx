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
    <section hidden class="col-sm-12" id="sectionBTTH">
        <div class="row">
            <div class="col-sm-11 text-center d-flex mb-2" style="justify-content: center;">
                <h5>Bài tập theo tuần: </h5>
                &nbsp&nbsp&nbsp
            <select id="BTTHLessonSelect" onchange="getLesson()">
                <option selected value="all">Tất cả</option>
                <option value="1">Tuần 1</option>
                <option value="2">Tuần 2</option>
                <option value="3">Tuần 3</option>
                <option value="4">Tuần 4</option>
                <option value="5">Tuần 5</option>
                <option value="6">Tuần 6</option>
            </select>
            </div>
            <span id="closeBTTH" class="col-sm-1 text-danger float-right" style="cursor: pointer;">Đóng   
                <i class="fas fa-times-circle"></i>
            </span>
        </div>
        <div class="row">
            <div class="card col-sm-4 divAll" id="divBai13">
                <div class="card-body">
                    <h5 class="card-title">Bài 13</h5>
                    <h6 class="card-subtitle mb-2 text-muted">Bài tập tuần 1</h6>
                    <p class="card-text">Ngôn Ngữ kịch bản, DOM & events</p>
                    <a href="./BTTH/Bai13.aspx" class="card-link">Đến Bài 13</a>
                </div>
            </div>
            <div class="card col-sm-4 divAll" id="divBai14">
                <div class="card-body">
                    <h5 class="card-title">Bài 14</h5>
                    <h6 class="card-subtitle mb-2 text-muted">Bài tập tuần 1</h6>
                    <p class="card-text">Ngôn Ngữ kịch bản, DOM & events</p>
                    <a href="./BTTH/Bai14.aspx" class="card-link">Đến Bài 14</a>
                </div>
            </div>
            <div class="card col-sm-4 divAll" id="divBai15">
                <div class="card-body">
                    <h5 class="card-title">Bài 15</h5>
                    <h6 class="card-subtitle mb-2 text-muted">Bài tập tuần 2</h6>
                    <p class="card-text">Server Side (Web Application project, Request, Response, Server, Configuration)</p>
                    <a href="./BTTH/bai15.htm" class="card-link">Đến Bài 15</a>
                </div>
            </div>
            <div class="card col-sm-4 divAll" id="divBai16">
                <div class="card-body">
                    <h5 class="card-title">Bài 16</h5>
                    <h6 class="card-subtitle mb-2 text-muted">Bài tập tuần 2</h6>
                    <p class="card-text">Server Side (Web Application project, Request, Response, Server, Configuration)</p>
                    <a href="./BTTH/Bai16/FileChooser.htm" class="card-link">Đến Bài 16</a>
                </div>
            </div>
            <div class="card col-sm-4 divAll" id="divBai17">
                <div class="card-body">
                    <h5 class="card-title">Bài 17</h5>
                    <h6 class="card-subtitle mb-2 text-muted">Bài tập tuần 3</h6>
                    <p class="card-text">Server side (Session, Application)</p>
                    <a href="./BTTH/Bai17/Products.aspx" class="card-link">Đến Bài 17</a>
                </div>
            </div>
            <div class="card col-sm-4 divAll" id="divBai18">
                <div class="card-body">
                    <h5 class="card-title">Bài 18</h5>
                    <h6 class="card-subtitle mb-2 text-muted">Bài tập tuần 3</h6>
                    <p class="card-text">Server side (Session, Application)</p>
                    <a href="./BTTH/Bai18/Login.aspx" class="card-link">Đến Bài 18</a>
                </div>
            </div>
            <div class="card col-sm-4 divAll" id="divBai19">
                <div class="card-body">
                    <h5 class="card-title">Bài 19</h5>
                    <h6 class="card-subtitle mb-2 text-muted">Bài tập tuần 4</h6>
                    <p class="card-text">Server Control</p>
                    <a href="./BTTH/Bai19/webUserControl.aspx" class="card-link">Đến Bài 19</a>
                </div>
            </div>
            <div class="card col-sm-4 divAll" id="divBai20">
                <div class="card-body">
                    <h5 class="card-title">Bài 20</h5>
                    <h6 class="card-subtitle mb-2 text-muted">Bài tập tuần 4</h6>
                    <p class="card-text">Server Control</p>
                    <a href="./BTTH/Bai20/registerB20.aspx" class="card-link">Đến Bài 20</a>
                </div>
            </div>
            <div class="card col-sm-4 divAll" id="divBai21">
                <div class="card-body">
                    <h5 class="card-title">Bài 21</h5>
                    <h6 class="card-subtitle mb-2 text-muted">Bài tập tuần 5</h6>
                    <p class="card-text">ADO.NET & DataBound Controls</p>
                    <a href="./BTTH/Bai21/bai21.aspx" class="card-link">Đến Bài 21</a>
                </div>
            </div>
            <div class="card col-sm-4 divAll" id="divBai22">
                <div class="card-body">
                    <h5 class="card-title">Bài 22</h5>
                    <h6 class="card-subtitle mb-2 text-muted">Bài tập tuần 5</h6>
                    <p class="card-text">ADO.NET & DataBound Controls</p>
                    <a href="./BTTH/Bai22/libraryB22.aspx" class="card-link">Đến Bài 22</a>
                </div>
            </div>
            <div class="card col-sm-4 divAll" id="divBai23">
                <div class="card-body">
                    <h5 class="card-title">Bài 23</h5>
                    <h6 class="card-subtitle mb-2 text-muted">Bài tập tuần 6</h6>
                    <p class="card-text">ADO.NET & DataBound Controls</p>
                    <a href="./BTTH/Bai23/B23Shop.aspx" class="card-link">Đến Bài 23</a>
                </div>
            </div>
            <div class="card col-sm-4 divAll" id="divBai24">
                <div class="card-body">
                    <h5 class="card-title">Bài 24</h5>
                    <h6 class="card-subtitle mb-2 text-muted">Bài tập tuần 6</h6>
                    <p class="card-text">ADO.NET & DataBound Controls</p>
                    <a href="./BTTH/Bai20/registerB20.aspx" class="card-link">Đến Bài 24</a>
                </div>
            </div>
        </div>
    </section>
    <script>
        $(document).ready(function () {
            $("#btnBTL").on("click", function () {
                console.log("btl");
            });
            $("#btnBTTH").on("click", function () {
                $("#sectionBTTH").removeAttr('hidden');
                $("#sectionBTTH").show();
            });
            $("#closeBTTH").on("click", function () {
                $("#sectionBTTH").hide();
            });
        })
    </script>
    <script src="../Scripts/switchBTTHLesson.js" type="text/javascript"></script>
</asp:Content>
