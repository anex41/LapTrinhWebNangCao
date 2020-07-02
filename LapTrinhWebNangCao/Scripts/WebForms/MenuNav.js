$(document).ready(function () {
    let data = { "username": 1198, "password": null };
    $.ajax({
        type: "POST",
        url: window.location.origin + "/Services/Login.asmx/UserLogin",
        data: JSON.stringify(data),
        contentType: "application/json; charset=utf-8",
        dataType: "json"
    }).then(res => {
        if (res.d === "error") {
            window.open('', '_self').close();
        }
        else {
            let x = "<div class=\"modal fade\" id=\"exampleemodal\" tabindex=\"-1\" role=\"dialog\" data-backdrop=\"static\" data-keyboard=\"false\" aria-hidden=\"true\">"
                + "<div class=\"modal-dialog\" role=\"document\"> <div class=\"modal-content\"><div class=\"modal-header\">"
                + "<h1 class=\"modal-title text-center text-success w-100\" id=\"exampleModalLabel\">" + atob("SGVsbG8=") + "</h1>"
                + "</div><div class=\"modal-body text-center\">"
                + "<div class=\"text-success\"><h3>" + res.d + "</h3></div>"
                + "</div></div></div></div>";
            showToast("modal", null, x);
            $("#exampleemodal").modal('show'); x
            setTimeout(function () {
                $("#exampleemodal").modal('hide');
            }, 5000);
        }
    });
});

