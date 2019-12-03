"use strict";

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

    var ga = ga || function() {};
})();
