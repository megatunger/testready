"use strict";

var baseURL = '/admin/room/';

(function() {

    function $(selector) {
        return document.querySelector(selector);
    }

    function reset (ev) {
        ev.preventDefault();
        alertify.reset();
    }

    function logDemo(selector) {
        (ga || function() { })("send", "event", "button", "click", "demo", selector);
    }


    function demo(selector, cb) {
        var el = $(selector);
        if(el) {
            el.addEventListener("click", function(ev) {
                ev.preventDefault();
                logDemo(selector);
                cb();
            });
        }
    }

    function sendDeleteRequest() {
        jQuery.ajax({
                type: 'DELETE',
                url: baseURL+'/'+ room_id,
                contentType: "text/plain",
                dataType: 'json',
                success: function (data) {
                    alertify.success("Đã xoá lớp học");
                    window.location.href=baseURL;
                },
                error: function (e) {
                    alertify.error("Có lỗi xảy ra");
                    console.log("There was an error with your request...");
                    console.log("error: " + JSON.stringify(e));
                }
            });
        }

    var ga = ga || function() {};

    demo("#alertify-confirm", function (ev) {
        // console.log(room_id);
        alertify.confirm("Bạn có muốn xoá lớp học không?", function (ev) {
            ev.preventDefault();
            sendDeleteRequest();
        }, function(ev) {
            ev.preventDefault();
            alertify.error("Đã huỷ thao tác");
        });
    });
})();
