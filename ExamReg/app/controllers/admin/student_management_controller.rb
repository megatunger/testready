require 'delayed_job_active_record'
module Admin
  class StudentManagementController < DashboardAdminController

    def index
      @student = @students.new
      respond_to do |format|
        format.html { render :template => "dashboard_admin/student_management/index/index.html.erb" }
        format.json { render 'dashboard_admin/student_management/index/index.json.jbuilder'}
      end
    end

    def create
      @student.save
    end

    def deleteAll
      @students.destroy_all
      @students.reload
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

