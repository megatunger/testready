# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'rubyXL/convenience_methods'

@workbook = RubyXL::Parser.parse("MockData/Database_ver1.xlsx")

def parseStudent
  worksheet = @workbook['SINHVIEN']
  rows = worksheet.map {|row| row && row.cells.each { |cell| cell && cell.value != nil}}
  last_row = rows.size
  last_column = rows.compact.max_by{|row| row.size}.size
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
  end
  puts "Student count: #{Student.count}"
end

def parseCourse
  worksheet = @workbook['MONHOC']
  rows = worksheet.map {|row| row && row.cells.each { |cell| cell && cell.value != nil}}
  last_row = rows.size
  last_column = rows.compact.max_by{|row| row.size}.size
  (1..last_row-1).each do |i|
    maMH = rows[i][0].value
    tenMonHoc = rows[i][1].value
    soTinChi = rows[i][2].value
    soTinChi = soTinChi
    Course.create(courseID: maMH, name: tenMonHoc, credit: soTinChi.to_i)
  end
  puts "Course count: #{Course.count}"
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
    puts "CHECK --> #{student.id} --> #{course.id}"
    x = CourseStudent.where(student_id: student.id, course_id: course.id).first
    puts x.id
    if !x.nil?
      puts "OKAY"
      x.banned = 1
      x.save
    end
  end
end

parseStudent
parseCourse
parseStudentCourse
parseStudentCourseBanned