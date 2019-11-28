var testDataUrl = "/admin/student.json"
var deleteUrl = "/admin/student/deleteSelected"
function loadData() {
    document.getElementById("loading").style.display = "block";
    $.ajax({
        type: 'GET',
        url: testDataUrl,
        contentType: "text/plain",
        dataType: 'json',
        success: function (data) {
            myJsonData = data;
            populateDataTable(myJsonData);
            document.getElementById("loading").style.display = "none";
        },
        error: function (e) {
            console.log("There was an error with your request...");
            console.log("error: " + JSON.stringify(e));
        }
    });
}

// populate the data table with JSON data
function populateDataTable(data) {
    // clear the table before populating it with more data
    $("#datatable-buttons").DataTable().clear();

    var length = Object.keys(data.students).length;
    for(var i = 0; i < length; i++) {
        student = data.students[i]
        // You could also use an ajax property on the data table initialization
        $('#datatable-buttons').dataTable().fnAddData( [
            "",
            student.studentID,
            student.lastName,
            student.firstName,
            student.birthday,
            student.sex,
            student.classID,
            student.major,
            student.faculty,
            student.updated_at,
            '',
            student.edit_link,
            student.id
        ]);
    }
}

$('#select-all').on('click', function(){
    // Get all rows with search applied
    var rows = table.rows({ 'search': 'applied' }).nodes();
    // Check/uncheck checkboxes for all rows in the table
    $('input[type="checkbox"]', rows).prop('checked', this.checked);
});

// Handle click on checkbox to set state of "Select all" control
$('#tbody').on('change', 'input[type="checkbox"]', function(){
    // If checkbox is not checked
    if(!this.checked){
        var el = $('#select-all').get(0);
        // If "Select all" control is checked and has 'indeterminate' property
        if(el && el.checked && ('indeterminate' in el)){
            // Set visual state of "Select all" control
            // as 'indeterminate'
            el.indeterminate = true;
        }
    }
});

function deleteSelect() {
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

function deleteAStudent(id) {
    $.ajax({
        type: 'POST',
        url: deleteUrl + "?id[]=" + id,
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

var table = $("#datatable-buttons").DataTable({
    lengthChange: false,
    buttons: [
        {
            text: 'Xoá đã chọn',
            action: function ( e, dt, node, config ) {
                deleteSelect()
            }
        },
        , 'excel', 'pdf',
    ],
    columnDefs: [{
        'targets': 0,
        'searchable': false,
        'orderable': false,
        'className': 'dt-body-center',
        'render': function (data, type, full, meta){
            return '<input type="checkbox" name="id[]" value="' + $('<div/>').text(full[1]).html() + '">';
        }
    }, {
        'targets': 10,
        'searchable': false,
        'orderable': false,
        'className': 'dt-body-center',
        'render': function (data, type, full, meta){
            var buttons_in_html = '<a id="editStudent" class="btn btn-outline-primary waves-effect waves-light" data-modal = "true" href='+full[11]+'>Sửa</a>';
            buttons_in_html+='<a id="deleteStudent" class="ml-2 btn btn-outline-danger waves-effect waves-light" onclick="deleteAStudent('+full[1]+')">Xoá</a>'
            return buttons_in_html;
        }
    }],
    order: [[ 9, "desc" ]],
});


$(document).ready(function() {
    table.buttons().container()
        .appendTo('#datatable-buttons_wrapper .col-md-6:eq(0)');

    loadData();

    $("#refresh-button").click(function() {
        loadData();
    });

    $('#frm-example').on('submit', function(e){

    });
});