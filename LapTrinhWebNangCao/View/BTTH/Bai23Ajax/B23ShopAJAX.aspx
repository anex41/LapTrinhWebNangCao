<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="B23ShopAJAX.aspx.cs" Inherits="LapTrinhWebNangCao.View.BTTH.Bai23_Ajax.B23ShopAJAX" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Bài 23 Nhưng dùng AJAX</title>
    <asp:PlaceHolder runat="server">
        <%: Scripts.Render("~/bundles/modernizr") %>
    </asp:PlaceHolder>
    <webopt:BundleReference runat="server" Path="~/Content/css" />
    <link href="~/favicon.ico" rel="shortcut icon" type="image/x-icon" />
    <link rel="stylesheet" type='text/css' href="/Content/fontawesome-all.css" />
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager runat="server">
            <Scripts>
                <asp:ScriptReference Name="MsAjaxBundle" />
                <asp:ScriptReference Name="jquery" />
            </Scripts>
        </asp:ScriptManager>
        <div class="container-fluid">
            <div class="row">
                <div class="col-sm-12 form-group mt-3">
                    <div class="row">
                        <select onchange="setProducer(this.value)" class="form-control col-sm-3 offset-sm-1" id="producerList">
                            <option value="-1">Tất cả</option>
                        </select>
                        <div class="col-sm-8">
                            <div class="row">
                                <div class="col-sm-5">
                                    <div class="input-group">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text">Giá</span>
                                        </div>
                                        <input class="form-control" type="number" id="inputSPrice" onkeypress="validatePageValue(event)" />
                                    </div>
                                    <div hidden id="inputSPriceError" class="text-center w-100 text-danger">Không hợp lệ!</div>
                                </div>
                                <div class="col-sm-4">
                                    <div class="input-group">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text">Đến</span>
                                        </div>
                                        <input class="form-control" type="number" id="inputEPrice" onkeypress="validatePageValue(event)" />
                                    </div>
                                    <div hidden id="inputEPriceError" class="text-center w-100 text-danger">Không hợp lệ!</div>
                                </div>
                                <div class="col-sm-3">
                                    <button type="button" onclick="validateAndSearchPrice()" class="btn btn-success">Tìm</button>
                                    <button id="refreshPriceButton" hidden type="button" onclick="refreshPriceSearch()" class="btn btn-outline-info">Xóa điều kiện</button>
                                </div>
                                <div hidden id="priceCompareError" class="w-100 text-center text-danger">Giá điền vào sai quy định (vế trái lớn hơn vế phải)</div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-sm-12 mt-3">
                    <div class="col-sm-12 text-center" style="position: relative;">
                        <h2 class="text-primary">Danh sách điện thoại</h2>
                        <div id="pageSizeButton" style="top: 0; position: absolute; right: 0;">
                            <button type="button" id="size_30" class="btn btn-info mr-1" onclick="changePageSize(this.id)">30</button>
                            <button type="button" id="size_60" class="btn btn-info mr-1" onclick="changePageSize(this.id)">60</button>
                            <button type="button" id="size_120" class="btn btn-info mr-1" onclick="changePageSize(this.id)">120</button>
                        </div>
                    </div>
                    <div id="phoneData" class="row">
                    </div>
                </div>
                <div class="col-sm-8 my-4" runat="server" id="pageButton">
                </div>
                <div id="pageInput" class="col-sm-4 input-group my-4">
                    <div class="input-group-prepend">
                        <span class="input-group-text bg-success text-white">Số trang muốn đến</span>
                    </div>
                    <input class="form-control" id="inputPageValue" type="number" onkeypress="validatePageValue(event)" />
                    <div class="input-group-append">
                        <button onclick="confirmPageChange()" class="btn btn-outline-success" type="button"><i class="fas fa-arrow-alt-circle-right "></i></button>
                    </div>
                    <div id="noPageFound" hidden class="text-center text-danger w-100">
                        Số trang không tồn tại
                    </div>
                </div>
                <input hidden id="pageValue" type="text" />
            </div>
        </div>
    </form>
    <script>
        var currentIndex = 0, currentProducer = -1, tR = 0, currentPageSize = 0, currentTotalPage = 0, currentStartPrice = -1, currentEndPrice = -1;
        $(document).ready(function () {
            populateProducerList();
            setDefaultSetting();
            $("#inputPageValue").on("paste", function (e) {
                e.preventDefault();
            });
            $("#inputPageValue").on("drop", function (e) {
                e.preventDefault();
            });
            $("#inputEPrice").on("paste", function (e) {
                e.preventDefault();
            });
            $("#inputEPrice").on("drop", function (e) {
                e.preventDefault();
            });
            $("#inputSPrice").on("paste", function (e) {
                e.preventDefault();
            });
            $("#inputSPrice").on("drop", function (e) {
                e.preventDefault();
            });
        });

        function changePageSize(value) {
            let pac = {};
            pac.PageSize = currentPageSize = parseInt(value.split("_")[1]);
            pac.PageIndex = currentIndex = 1;
            pac.EndingPoint = pac.PageSize * pac.PageIndex;
            pac.StartingPoint = pac.EndingPoint - (pac.PageSize - 1);
            if (pac.StartingPoint < 0) pac.StartingPoint = 0;
            calculatePaging(pac, currentProducer, currentStartPrice, currentEndPrice);
        };

        function refreshPriceSearch() {
            $("#refreshPriceButton").prop("hidden", true);
            $("#inputSPrice").val("");
            $("#inputEPrice").val("");
            currentStartPrice = -1;
            currentEndPrice = -1;
            let pac = {};
            pac.PageIndex = currentIndex = 1;
            pac.PageSize = currentPageSize;
            pac.EndingPoint = pac.PageSize * pac.PageIndex;
            pac.StartingPoint = pac.EndingPoint - (pac.PageSize - 1);
            if (pac.StartingPoint < 0) pac.StartingPoint = 0;
            calculatePaging(pac, currentProducer, currentStartPrice, currentEndPrice);
        };


        function setProducer(value) {
            currentProducer = parseInt(value);
            let pac = {};
            pac.PageIndex = currentIndex = 1;
            pac.PageSize = currentPageSize;
            pac.EndingPoint = pac.PageSize * pac.PageIndex;
            pac.StartingPoint = pac.EndingPoint - (pac.PageSize - 1);
            if (pac.StartingPoint < 0) pac.StartingPoint = 0;
            calculatePaging(pac, currentProducer, currentStartPrice, currentEndPrice);
        };


        function confirmPageChange() {
            let value = $("#inputPageValue").val();
            if (value == "") return false;
            else {
                if (parseInt(value) > currentTotalPage || parseInt(value) <= 0) {
                    $("#noPageFound").removeAttr("hidden");
                }
                else {
                    currentIndex = value;
                    let pac = {};
                    pac.PageSize = currentPageSize;
                    pac.PageIndex = currentIndex;
                    pac.EndingPoint = pac.PageSize * pac.PageIndex;
                    pac.StartingPoint = pac.EndingPoint - (pac.PageSize - 1);
                    if (pac.StartingPoint < 0) pac.StartingPoint = 0;
                    calculatePaging(pac, currentProducer, currentStartPrice, currentEndPrice);
                }
            }
        };

        function getPageIndex(value) {
            if (parseInt(value.split("_")[1]) > currentTotalPage || parseInt(value.split("_")[1]) <= 0) {
                $("#noPageFound").removeAttr("hidden");
            }
            else {
                currentIndex = value.split("_")[1];
                let pac = {};
                pac.PageSize = currentPageSize;
                pac.PageIndex = currentIndex;
                pac.EndingPoint = pac.PageSize * pac.PageIndex;
                pac.StartingPoint = pac.EndingPoint - (pac.PageSize - 1);
                if (pac.StartingPoint < 0) pac.StartingPoint = 0;
                calculatePaging(pac, currentProducer, currentStartPrice, currentEndPrice);
            }
        };

        function validatePageValue(e) {
            if (e.key == "e" || e.key == "-")
                e.preventDefault();
        };

        function validateAndSearchPrice() {
            let flag = true;
            let valueA = $("#inputSPrice").val();
            let valueB = $("#inputEPrice").val();
            if (valueA == "" || valueA < 0) {
                $("#inputSPriceError").removeAttr("hidden");
                flag = false;
            } else {
                $("#inputSPriceError").prop("hidden", true);
                flag = true;
            };
            if (valueB == "" || valueB < 0) {
                $("#inputEPriceError").removeAttr("hidden");
                flag = false;

            } else {
                $("#inputEPriceError").prop("hidden", true);
                flag = true;
            };
            if (parseFloat(valueA) > parseFloat(valueB)) {
                $("#priceCompareError").removeAttr("hidden");
                flag = false;
            }
            else {
                $("#priceCompareError").prop("hidden", true);
                flag = true;
            };
            if (flag) {
                $("#refreshPriceButton").removeAttr("hidden");
                $("#inputSPrice").val("");
                $("#inputEPrice").val("");
                currentStartPrice = parseFloat(valueA);
                currentEndPrice = parseFloat(valueB);
                let pac = {};
                pac.PageIndex = currentIndex = 1;
                pac.PageSize = currentPageSize;
                pac.EndingPoint = pac.PageSize * pac.PageIndex;
                pac.StartingPoint = pac.EndingPoint - (pac.PageSize - 1);
                if (pac.StartingPoint < 0) pac.StartingPoint = 0;
                calculatePaging(pac, currentProducer, currentStartPrice, currentEndPrice);
            };
        };

        function populateProducerList() {
            $.ajax({
                type: "POST",
                url: window.location.origin + "/Services/BTTHService.asmx/PopulateProducerListB23",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    if (response.d) {
                        response.d.forEach(item => {
                            $("#producerList").append("<option value=\"" + item.Id + "\">" + item.Name + "</option>");
                        });
                    } else {
                        alert("Populate producer list failed");
                    }
                }
            });
        };

        function setDefaultSetting() {
            let pac = {};
            pac.PageSize = currentPageSize = 30;
            pac.PageIndex = currentIndex = 1;
            pac.EndingPoint = pac.PageSize * pac.PageIndex;
            pac.StartingPoint = pac.EndingPoint - (pac.PageSize - 1);
            if (pac.StartingPoint < 0) pac.StartingPoint = 0;
            currentStartPrice = currentEndPrice = -1;
            calculatePaging(pac, currentProducer, currentStartPrice, currentEndPrice);
        };

        function calculatePaging(pac, curProducer, curSPrice, curEPrice) {
            let x = pac;
            let data = { "curProducer": curProducer, "curSPrice": curSPrice, "curEPrice": curEPrice };
            $.ajax({
                type: "POST",
                url: window.location.origin + "/Services/BTTHService.asmx/GetTotalRecordB23",
                data: JSON.stringify(data),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    if (response.d) {
                        tR = parseInt(response.d);
                    } else {
                        alert("Get total record Failed");
                    }
                }
            }).then(function () {
                x.TotalRecord = tR;
                x.EndingPoint = x.PageSize * x.PageIndex;
                x.StartingPoint = x.EndingPoint - (x.PageSize - 1);
                if (x.StartingPoint < 0) x.StartingPoint = 0;
                getDataList(x);
            });
        }

        function getDataList(x) {
            let data = { "start": x.StartingPoint, "end": x.EndingPoint, "priceStart": currentStartPrice, "priceEnd": currentEndPrice, "prducerID": currentProducer };
            $.ajax({
                type: "POST",
                url: window.location.origin + "/Services/BTTHService.asmx/GetB23Data",
                data: JSON.stringify(data),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    if (response.d) {
                        renderDataList(response.d, x);
                    } else {
                        alert("Get phone dât failed");
                    }
                }
            });
        }

        function renderDataList(arr, pac) {
            $(".B23PhoneData").remove();
            let flag = true;
            if (arr.length == 0) {
                $("#phoneData").append("<div class=\"col-sm-12 text-center text-danger\"><h2>Không có dữ liệu</h2></div>");
                flag = false;
            }
            else {
                flag = true;
                arr.forEach(item => {
                    $("#phoneData").append("<div class=\"col-sm-2 text-center p-3 B23PhoneData\"><div class=\"fa-border border-secondary rounded\"><i class=\"fas fa-mobile fa-7x\"></i>"
                        + "<div>" + item.Name + "</div>"
                        + "<div>" + item.Price + " đ</div>"
                        + "<button type=\"button\" class=\"btn btn-outline-primary\">Chi Tiết</button>"
                        + "</div></div>");
                });
            }
            if (flag) {
                renderPageButton(pac, true);
            } else {
                renderPageButton(pac, false);
            }
        };

        function renderPageButton(x, flg) {
            $(".b23PageButton").remove();
            if (flg) {
                let a = parseFloat(x.TotalRecord) / parseFloat(x.PageSize);
                x.TotalPage = parseInt(Math.round(a));
                if (x.TotalPage < a) x.TotalPage++;
                currentTotalPage = x.TotalPage;
                if (x.TotalPage <= 5) {
                    $("#pageInput").prop("hidden", true);
                    for (let i = 0; i < x.TotalPage; i++) {
                        if (currentIndex == (i + 1)) {
                            $("#pageButton").append("<button class=\"btn btn-info b23PageButton\" type=\"button\" id=\"page_" + (i + 1) + "\" onclick=\"getPageIndex(this.id)\">" + (i + 1) + "</button>");
                        }
                        else {
                            $("#pageButton").append("<button class=\"btn btn-outline-info b23PageButton\" type=\"button\" id=\"page_" + (i + 1) + "\" onclick=\"getPageIndex(this.id)\">" + (i + 1) + "</button>");
                        }
                    }
                }
                else {
                    $("#pageInput").removeAttr("hidden");
                    if (currentIndex == 1) {
                        $("#pageButton").append("<button class=\"btn btn-info b23PageButton\" type=\"button\" id=\"page_" + 1 + "\" onclick=\"getPageIndex(this.id)\">" + 1 + "</button>");
                        $("#pageButton").append("<button class=\"btn btn-outline-info b23PageButton\" type=\"button\" id=\"page_" + 2 + "\" onclick=\"getPageIndex(this.id)\">" + 2 + "</button>");
                        $("#pageButton").append("<span class=\"b23PageButton\">&nbsp; ... &nbsp;</span>");
                        $("#pageButton").append("<button class=\"btn btn-outline-info b23PageButton\" type=\"button\" id=\"page_" + (x.TotalPage - 1) + "\" onclick=\"getPageIndex(this.id)\">" + (x.TotalPage - 1) + "</button>");
                        $("#pageButton").append("<button class=\"btn btn-outline-info b23PageButton\" type=\"button\" id=\"page_" + x.TotalPage + "\" onclick=\"getPageIndex(this.id)\">" + x.TotalPage + "</button>");
                    }
                    else if (currentIndex == 2) {
                        $("#pageButton").append("<button class=\"btn btn-outline-info b23PageButton\" type=\"button\" id=\"page_" + 1 + "\" onclick=\"getPageIndex(this.id)\">" + 1 + "</button>");
                        $("#pageButton").append("<button class=\"btn btn-info b23PageButton\" type=\"button\" id=\"page_" + 2 + "\" onclick=\"getPageIndex(this.id)\">" + 2 + "</button>");
                        $("#pageButton").append("<span class=\"b23PageButton\">&nbsp; ... &nbsp;</span>");
                        $("#pageButton").append("<button class=\"btn btn-outline-info b23PageButton\" type=\"button\" id=\"page_" + (x.TotalPage - 1) + "\" onclick=\"getPageIndex(this.id)\">" + (x.TotalPage - 1) + "</button>");
                        $("#pageButton").append("<button class=\"btn btn-outline-info b23PageButton\" type=\"button\" id=\"page_" + x.TotalPage + "\" onclick=\"getPageIndex(this.id)\">" + x.TotalPage + "</button>");
                    }
                    else if (currentIndex == (x.TotalPage - 1)) {
                        $("#pageButton").append("<button class=\"btn btn-outline-info b23PageButton\" type=\"button\" id=\"page_" + 1 + "\" onclick=\"getPageIndex(this.id)\">" + 1 + "</button>");
                        $("#pageButton").append("<button class=\"btn btn-outline-info b23PageButton\" type=\"button\" id=\"page_" + 2 + "\" onclick=\"getPageIndex(this.id)\">" + 2 + "</button>");
                        $("#pageButton").append("<span class=\"b23PageButton\">&nbsp; ... &nbsp;</span>");
                        $("#pageButton").append("<button class=\"btn btn-info b23PageButton\" type=\"button\" id=\"page_" + (x.TotalPage - 1) + "\" onclick=\"getPageIndex(this.id)\">" + (x.TotalPage - 1) + "</button>");
                        $("#pageButton").append("<button class=\"btn btn-outline-info b23PageButton\" type=\"button\" id=\"page_" + x.TotalPage + "\" onclick=\"getPageIndex(this.id)\">" + x.TotalPage + "</button>");
                    }
                    else if (currentIndex == x.TotalPage) {
                        $("#pageButton").append("<button class=\"btn btn-outline-info b23PageButton\" type=\"button\" id=\"page_" + 1 + "\" onclick=\"getPageIndex(this.id)\">" + 1 + "</button>");
                        $("#pageButton").append("<button class=\"btn btn-outline-info b23PageButton\" type=\"button\" id=\"page_" + 2 + "\" onclick=\"getPageIndex(this.id)\">" + 2 + "</button>");
                        $("#pageButton").append("<span class=\"b23PageButton\">&nbsp; ... &nbsp;</span>");
                        $("#pageButton").append("<button class=\"btn btn-outline-info b23PageButton\" type=\"button\" id=\"page_" + (x.TotalPage - 1) + "\" onclick=\"getPageIndex(this.id)\">" + (x.TotalPage - 1) + "</button>");
                        $("#pageButton").append("<button class=\"btn btn-info b23PageButton\" type=\"button\" id=\"page_" + x.TotalPage + "\" onclick=\"getPageIndex(this.id)\">" + x.TotalPage + "</button>");
                    }
                    else {
                        $("#pageButton").append("<button class=\"btn btn-outline-info b23PageButton\" type=\"button\" id=\"page_" + 1 + "\" onclick=\"getPageIndex(this.id)\">" + 1 + "</button>");
                        $("#pageButton").append("<button class=\"btn btn-outline-info b23PageButton\" type=\"button\" id=\"page_" + 2 + "\" onclick=\"getPageIndex(this.id)\">" + 2 + "</button>");
                        $("#pageButton").append("<span class=\"b23PageButton\">&nbsp; ... &nbsp;</span>");
                        $("#pageButton").append("<button class=\"btn btn-info b23PageButton\" type=\"button\" id=\"page_" + currentIndex + "\" onclick=\"getPageIndex(this.id)\">" + currentIndex + "</button>");
                        $("#pageButton").append("<dspaniv class=\"b23PageButton\">&nbsp; ... &nbsp;</span>");
                        $("#pageButton").append("<button class=\"btn btn-outline-info b23PageButton\" type=\"button\" id=\"page_" + (x.TotalPage - 1) + "\" onclick=\"getPageIndex(this.id)\">" + (x.TotalPage - 1) + "</button>");
                        $("#pageButton").append("<button class=\"btn btn-outline-info b23PageButton\" type=\"button\" id=\"page_" + x.TotalPage + "\" onclick=\"getPageIndex(this.id)\">" + x.TotalPage + "</button>");
                    }
                }
            }
            else {
                $("#pageInput").prop("hidden", true);
                $("#pageButton").html("");
            }
        }
    </script>
</body>
</html>

