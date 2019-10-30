!function ($) {
    "use strict";

    var SweetAlert = function () {
    };

    //examples
    SweetAlert.prototype.init = function () {

        //Danger
        $('#dynamic-alert').click(function () {
            swal.queue([{
                title: 'Bạn có chắc chắn không?',
                type: 'warning',
                showCloseButton: true,
                confirmButtonClass: 'btn btn-danger ml-2',
                confirmButtonText: 'Chắc chắn',
                text: 'Thao tác này không thể hoàn tác!',
                showLoaderOnConfirm: true,
                preConfirm: function () {
                    return new Promise(function (resolve) {
                        const csrfToken = document.querySelector('[name="csrf-token"]').getAttribute('content');
                        $.get('/admin/student/deleteAll.json')
                            .done(function (data) {
                                swal.insertQueueStep('Đã xoá!')
                                resolve()
                            })
                    })
                }
            }])
        });


    },
        //init
        $.SweetAlert = new SweetAlert, $.SweetAlert.Constructor = SweetAlert
}(window.jQuery),

//initializing
    function ($) {
        "use strict";
        $.SweetAlert.init()
    }(window.jQuery);