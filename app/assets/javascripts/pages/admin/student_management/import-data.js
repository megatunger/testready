var $dropZone = $("#dropzone").dropzone({
    acceptedFiles : 'application/vnd.ms-excel,application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
    init: function() {
        this.on("addedfile", function() {
            if (this.files[1]!=null){
                this.removeFile(this.files[0]);
            }
        });
        this.on("success", function(file, response) {
            alertify.success("Import thành công");
            $("#inputXLS").collapse("hide");
            loadData();
        })

        this.on("processing", function(file, response) {
            alertify.log("Đang xử lí dữ liệu...");
        })
    }
});