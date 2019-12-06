var baseURL = '/admin/course/';

!function ($) {
    "use strict";

    var SweetAlert = function () {
    };

    //examples
    SweetAlert.prototype.init = function () {

        $('.deleteButton').click(function(e) {
            // console.log($(this).data("exam-id"));
            var course_id = $(this).data("course-id");
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
                        jQuery.ajax({
                            type: 'DELETE',
                            url: baseURL + course_id,
                            contentType: "text/plain",
                            dataType: 'json',
                            success: function (data) {
                                alertify.success("Đã xoá khoá học");
                                $("#card_"+course_id).remove();
                                resolve();
                            },
                            error: function (e) {
                                alertify.error("Có lỗi xảy ra");
                                console.log("There was an error with your request...");
                                console.log("error: " + JSON.stringify(e));
                            }
                        });
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