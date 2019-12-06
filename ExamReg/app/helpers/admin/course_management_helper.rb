module Admin::CourseManagementHelper
  def registrations_percent(course)
    registrations = Array.new
    @last_exam_schedules&.where(course_id: course.id)&.each do |exam_schedule|
      registrations_of_es = exam_schedule.registrations
      registrations_of_es.each do |registration|
        registrations << registration
      end
    end
    if (course.students.count == 0)
      return 0.0
    else
      return registrations.count.fdiv(course.students.count)*100.to_i
    end
  end

  def check_banned(student)
      flag = CourseStudent.where(student_id: student.id, course_id: @course.id).first.banned
  end

  def check_banned_class(student)
    check_banned(student)?"text-danger font-weight-bold":""
  end
end
