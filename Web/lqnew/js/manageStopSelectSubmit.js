﻿
$(document).ready(function () {
    $("#TextBox1").keypress(function (event) {
        if (event.keyCode == 13) {
            event.preventDefault();
        }
    });
});