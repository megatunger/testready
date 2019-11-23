module DashboardStudentHelper
  def checkBanned(course)
    return CourseStudent.where(student_id: @student.id, course_id: course.id).first.banned
  end

  def returnColor(course)
    return checkBanned(course)? "danger" : "success"
  end

  def returnText(course)
    return checkBanned(course)? "Bạn đã bị cấm thi!" : "Đăng ký"
  end
end
