<%@ Page Title="Trang chủ" Language="C#" MasterPageFile="~/View/BTL/BTL.Master" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="LapTrinhWebNangCao.View.BTL.view.index" %>

<asp:Content ID="Content" ContentPlaceHolderID="ContentPlaceHolder" runat="server">
    <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
        <ol class="carousel-indicators">
            <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
            <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
            <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
        </ol>
        <div class="carousel-inner">
            <div class="carousel-item active">
                <img class="d-block w-100" style="height: 90vh;" src="/../../../Assets/nhaDep1.jpg" alt="First slide">
                <div class="carousel-caption d-none d-md-block">
                    <h3>Nhà đẹp quá</h3>
                    <p>Ngôi nhà này thật là đẹp</p>
                </div>
            </div>
            <div class="carousel-item">
                <img class="d-block w-100" style="height: 90vh;" src="/../../../Assets/building1.jpg" alt="Second slide">
                <div class="carousel-caption d-none d-md-block">
                    <h3>Nhiều tòa nhà quá</h3>
                    <p>Toàn nhà màu vàng thôi</p>
                </div>
            </div>
            <div class="carousel-item">
                <img class="d-block w-100" style="height: 90vh;" src="/../../../Assets/nhaDep2.jpg" alt="Third slide">
                <div class="carousel-caption d-none d-md-block">
                    <h3>Úi! Biệt thự</h3>
                    <p>Biệt thự đẹp quá!</p>
                </div>
            </div>
        </div>
        <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="sr-only">Previous</span>
        </a>
        <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="sr-only">Next</span>
        </a>
    </div>
</asp:Content>
