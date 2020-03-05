<%@ Page Title="Bài 1" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Bai13.aspx.cs" Inherits="LapTrinhWebNangCao.View.BTTH.Bai1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="col-sm-12 text-center text-primary">
        <h1>Bài 1</h1>
        <button id="startbtn" class="btn btn-primary">Bắt đầu</button>
    </div>
    <h3 class="ml-4 mt-3 text-danger" id="endChosen">Bạn đã chọn kết thúc</h3>
    <script>
        $(document).ready(function () {
            $("#endChosen").hide();
            $("#startbtn").on("click", function () {
                let x = prompt("Điền vào đoạn văn bản", "");
                if (x) {
                    let newX = x.trim().replace(/ {1,}/g, " ").split(" ");
                    let shortest = Infinity, longest = -Infinity;
                    newX.forEach(o => {
                        if (o.length < shortest) shortest = o.length;
                        if (o.length > longest) longest = o.length;
                    });
                    alertResult(shortest, longest, newX);
                } else {
                    alert("not ok");
                }
            });
        })
        function alertResult(short, long, arr) {
            let longList = [], shortList = [];
            arr.forEach(e => {
                if (e.length == short) shortList.push(e);
                if (e.length == long) longList.push(e);
            });
            alert("Từ dài nhất là: " + longList + "\nTừ Ngắn nhất là: " + shortList);
            doAgain();
        };
        function doAgain() {
            if (confirm("Bạn có muốn thực hiện lại ?")) {
                $("#startbtn").click();
            } else {
                $("#endChosen").show();
            }
        };
    </script>
</asp:Content>
