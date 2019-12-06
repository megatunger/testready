!function ($) {
    "use strict";

    var AdvancedForm = function () {
    };

    AdvancedForm.prototype.init = function () {
//creating various controls
        jQuery('#datepicker-autoclose').datepicker({
            autoclose: true,
            todayHighlight: true
        });
    }
    //init
    $.AdvancedForm = new AdvancedForm, $.AdvancedForm.Constructor = AdvancedForm
}(window.jQuery),

//initializing
    function ($) {
        "use strict";
        $.AdvancedForm.init();
    }(window.jQuery);