//var succeedtoastHead = "<div class=\"toast bg-success text-white toastSucceed my-2 w-100\" role=\"alert\" data-delay=\"5000\" data-autohide=\"true\">"
//    + "<div class=\"toast-header\"> <strong class=\"mr-auto text-success\">";

//var errorToastHead = "<div class=\"toast bg-danger text-white toastError my-2 w-100\" role=\"alert\" data-delay=\"5000\" data-autohide=\"true\">"
//    + "<div class=\"toast-header\"> <strong class=\"mr-auto text-danger\">";

//var infoToastHead = "<div class=\"toast bg-info text-white toastInfo my-2 w-100\" role=\"alert\" data-delay=\"5000\" data-autohide=\"true\">"
//    + "<div class=\"toast-header\"> <strong class=\"mr-auto text-info\">";

var toastBody = "</strong>"
    + "<small class=\"text-muted\">Thông báo sẽ tự tắt sau 5 giây</small>"
    + "<button type=\"button\" class=\"ml-2 mb-1 close\" data-dismiss=\"toast\" aria-label=\"Close\"><span aria-hidden=\"true\">×</span></button>"
    + "</div><div class=\"toast-body\">";

var tail = "</div></div>";

var idSucceedNumber = 0;
var idErrorNumber = 0;
var idInfoNumber = 0;

function appendParent() {
    let elem = document.createElement('div');
    elem.style.cssText = 'z-index: 9999; top: 0; width: 25vw; right: 0;';
    elem.classList.add("toastParent", "position-fixed", "d-flex", "flex-column");
    elem.id = "parentToast";
    elem.innerHTML = "";
    document.body.appendChild(elem);
    //document.body.append(parentToast);
};

function showToast(type, headMessage, message) {
    //$("#parentToast").css("z-index", $("#parentToast").css("z-index") === "-9999" ? "9999" : "9999");
    switch (type) {
        case "succeed":
            showSucceedToast(headMessage, message);
            break;
        case "error":
            showErrorToast(headMessage, message);
            break;
        case "info":
            showInfoToast(headMessage, message);
            break;
        case "modal":
            $("body").append(message);
            break;
        default:
            break;
    };
};

function showSucceedToast(title, body) {
    if (idSucceedNumber < 5) {
        let succeedtoastHead = "<div class=\"toast bg-success text-white toastSucceed" + idSucceedNumber + " my-2 w-100\" role=\"alert\" data-delay=\"5000\" data-autohide=\"true\">"
            + "<div class=\"toast-header\"> <strong class=\"mr-auto text-success\">";
        $("#parentToast").append(succeedtoastHead + title + toastBody + body + tail);
        $('.toastSucceed' + idSucceedNumber).toast('show');
        idSucceedNumber++;
    } else {
        removeToast("toastSucceed");
        idSucceedNumber = 0;
        showSucceedToast(title, body);
    };
};

function showErrorToast(title, body) {
    if (idErrorNumber < 5) {
        let errorToastHead = "<div class=\"toast bg-danger text-white toastError" + idErrorNumber + " my-2 w-100\" role=\"alert\" data-delay=\"5000\" data-autohide=\"true\">"
            + "<div class=\"toast-header\"> <strong class=\"mr-auto text-danger\">";
        $("#parentToast").append(errorToastHead + title + toastBody + body + tail);
        $('.toastError' + idErrorNumber).toast('show');
        idErrorNumber++;
    } else {
        removeToast("toastError");
        idErrorNumber = 0;
        showErrorToast(title, body)
    };
};

function showInfoToast(title, body) {
    if (idInfoNumber < 5) {
        let infoToastHead = "<div class=\"toast bg-info text-white toastInfo" + idInfoNumber + " my-2 w-100\" role=\"alert\" data-delay=\"5000\" data-autohide=\"true\">"
            + "<div class=\"toast-header\"> <strong class=\"mr-auto text-info\">";
        $("#parentToast").append(infoToastHead + title + toastBody + body + tail);
        $('.toastInfo' + idInfoNumber).toast('show');
        idInfoNumber++;
    } else {
        removeToast("toastInfo");
        idInfoNumber = 0;
        showInfoToast(title, body)
    };
};

function removeToast(str) {
    let i = 0;
    while (i < 5) {
        $("." + str + i).remove();
        i++;
    };
};