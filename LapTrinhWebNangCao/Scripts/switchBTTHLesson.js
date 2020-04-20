function getLesson() {
    let lesson = $("#BTTHLessonSelect").val();
    switch (lesson) {
        case "1":
            $(".divAll").hide();
            $("#divBai13").show();
            $("#divBai14").show();
            break;
        case "2":
            $(".divAll").hide();
            $("#divBai15").show();
            $("#divBai16").show();
            break;
        case "3":
            $(".divAll").hide();
            $("#divBai17").show();
            $("#divBai18").show();
            break;
        case "4":
            $(".divAll").hide();
            $("#divBai19").show();
            $("#divBai20").show();
            break;
        case "5":
            $(".divAll").hide();
            $("#divBai21").show();
            $("#divBai22").show();
            break;
        case "6":
            $(".divAll").hide();
            $("#divBai23").show();
            $("#divBai24").show();
            break;
        case "all":
            $(".divAll").show();
            break;
        default:
            break;
    }
};