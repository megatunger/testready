$(document).ready(function() {
    var table = $("#datatable-buttons").DataTable({
        lengthChange: false,
        buttons: ['copy', 'excel', 'pdf', 'colvis'],
    });
    table.buttons().container()
        .appendTo('#datatable-buttons_wrapper .col-md-6:eq(0)');

    var testDataUrl = "/admin/student.json"
    loadData();

    $("#refresh-button").click(function() {
        loadData();
    });

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
            ]);
        }
    }

});