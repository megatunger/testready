module DashboardStudentHelper
  def checkBanned(course)
    return @courseStudents.where(student_id: @student.id, course_id: course.id).first.banned
  end

  def checkRegistration(course)
    @registrations.each_with_index do |registration|
      if registration.student_id == @student.id
          course.exam_schedules.each_with_index do |exam_schedule|
            if registration.exam_schedule_id == exam_schedule.id
              return true
            end
          end
      end
    end
    return false
  end

  def courseSchedule(registration)
      @student.courses.each_with_index do |course|
        course.exam_schedules.each_with_index do |exam_schedule|
          if registration.exam_schedule_id == exam_schedule.id
            return course
          end
        end
      end
    return false
  end

  def returnColor(course)
    # return checkBanned(course)? "danger" : "warning"
    if checkBanned(course)
      return "danger"
    elsif checkRegistration(course)
      return "success"
    else return "warning"
    end
  end

  def returnText(course)
    if checkBanned(course)
      return "Bạn đã bị cấm thi!"
    elsif checkRegistration(course)
      return "Bạn đã đăng ký thành công!"
    else return "Đăng ký"
    end
    # return checkBanned(course)? "Bạn đã bị cấm thi!" : "Đăng ký"
  end

  def checkSex()
    return (@student.sex)? "Nữ" : "Nam"
  end
end
