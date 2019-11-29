require 'delayed_job_active_record'
module Admin
  class StudentManagementController < DashboardAdminController

    respond_to :html, :json, :js
    append_before_action :setStudent, only: [:edit, :update]

    def index
      respond_to do |format|
        format.html { render :template => "admin/student_management/index.html.erb" }
        format.json { render 'admin/student_management/index/index.json.jbuilder'}
      end
    end

    def new
      @student = @students.new
      respond_modal_with @student
    end

    def edit
      respond_modal_with @student
    end

    def update
      @student.update(student_params)
      respond_modal_with @student, location: admin_student_management_index_path
    end

    def create
      @student = @students.create(student_params)
      respond_modal_with @student, location: admin_student_management_index_path
    end

    def deleteAll
      @students.destroy_all
      @students.reload
      render json: {status: 'success'}, status: 200
    end

    def deleteSelected
      list = params[:id]
      list.each do |student_id = student_id.to_i|
        @students.where(studentID: student_id).destroy_all
      end
      render json: {status: 'success'}, status: 200
    end

    def uploadData
      @file = params[:file]
      @job = Delayed::Job.enqueue ImportData.new(@file)
    end

    def importData
    end

    private
    def student_params
      params.require(:student).permit(:studentID,
                                      :firstName,
                                      :lastName,
                                      :birthday,
                                      :sex,
                                      :classID,
                                      :major,
                                      :faculty)
    end

    def setStudent
      @student = @students.find(params[:id])
    end
  end


  class ImportData < ProgressJob::Base
    def initialize(file)
      @workbook = RubyXL::Parser.parse(file)
      perform
    end

    def perform
      # update_stage('Đang nhập danh sách học sinh')
      parseStudent
      parseStudentCourse
      parseStudentCourseBanned
    end

    private
    def parseStudent
      worksheet = @workbook['SINHVIEN']
      rows = worksheet.map {|row| row && row.cells.each { |cell| cell && cell.value != nil}}
      last_row = rows.size
      (1..last_row-1).each do |i|
        mssv = rows[i][0].value
        ho = rows[i][1].value
        ten = rows[i][2].value
        ngaysinh = rows[i][3].value
        gioitinh = rows[i][4].value
        gioitinh = (gioitinh=="Nam") ? 0 : 1
        lopkhoahoc = rows[i][5].value
        khoa = rows[i][6].value
        nganh = rows[i][7].value
        Student.create(studentID: mssv.to_i,
                       firstName: ten,
                       lastName: ho,
                       birthday: ngaysinh,
                       sex: gioitinh,
                       classID: lopkhoahoc,
                       major: nganh,
                       faculty: khoa
        )
        # update_progress
      end
      puts "Student count: #{Student.count}"
    end

    def parseStudentCourse
      worksheet = @workbook['DAHOC']
      rows = worksheet.map {|row| row && row.cells.each { |cell| cell && cell.value != nil}}
      last_row = rows.size
      last_column = rows.compact.max_by{|row| row.size}.size
      (1..last_row-1).each do |i|
        student = Student.find_by_studentID(worksheet[i][0].value.to_i)
        course =  Course.find_by_courseID(worksheet[i][1].value)
        if !course.nil?
          # puts "OKAY"
          course.students << student
        end
      end
    end

    def parseStudentCourseBanned
      worksheet = @workbook['CAMTHI']
      rows = worksheet.map {|row| row && row.cells.each { |cell| cell && cell.value != nil}}
      last_row = rows.size
      last_column = rows.compact.max_by{|row| row.size}.size
      (1..last_row-1).each do |i|
        student = Student.find_by_studentID(worksheet[i][0].value.to_i)
        course =  Course.find_by_courseID(worksheet[i][1].value)
        x = CourseStudent.where(student_id: student.id, course_id: course.id).first
        if !x.nil?
          x.banned = 1
          x.save
        end
      end
      puts "Student Banned Updated"
    end
  end
end

