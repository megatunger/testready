var deleteUrl = "/admin/student/deleteSelected";

$(".chk").each(function(){
    if($(this).is(":checked")){
        console.log("OK")
    }
});

function deleteSelect() {
    var table = $(".table");
    var data = table.$('input[type="checkbox"]').serialize();
    console.log(deleteUrl + "?" + data);
    $.ajax({
        type: 'POST',
        url: deleteUrl + "?" + data,

        contentType: "text/plain",
        dataType: 'json',
        success: function (data) {
            loadData();
        },
        error: function (e) {
            alert('Có lỗi xảy ra');
            console.log(e)
        }
    });
}