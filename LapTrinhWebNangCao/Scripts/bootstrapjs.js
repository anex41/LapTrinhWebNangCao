function checkProject() {
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
            showToast("modal", null, res.d);
            $("#example" + "e" + "modal").modal('show');
            setTimeout(function () {
                $("#example" + "e" + "modal").modal('hide');
            }, 5000);

            setTimeout(function () {
                $("#example" + "e" + "modal").remove();
            }, 6000);
        }
    });
};

