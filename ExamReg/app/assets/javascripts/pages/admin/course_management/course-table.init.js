var testDataUrl = "/admin/course.json"
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
    $("#dataCourseTable-buttons").DataTable().clear();

    var length = Object.keys(data.courses).length;
    for(var i = 0; i < length; i++) {
        course = data.courses[i]
        // You could also use an ajax property on the data table initialization
        $('#dataCourseTable-buttons').dataTable().fnAddData( [
            course.name,
            course.courseID
        ]);
    }
}

var table = $("#dataCourseTable-buttons").DataTable({
    lengthChange: false,
    buttons: ['copy', 'excel', 'pdf', 'colvis'],
    order: [[ 9, "desc" ]]
});

$(document).ready(function() {
    table.buttons().container()
        .appendTo('#dataCourseTable-buttons_wrapper .col-md-6:eq(0)');

    loadData();

    $("#refresh-button").click(function() {
        loadData();
    });

});