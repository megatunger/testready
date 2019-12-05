class Registration < ApplicationRecord
  belongs_to :exam_schedule, class_name: 'ExamSchedule', foreign_key: "exam_schedule_id"
  belongs_to :student, class_name: 'Student', foreign_key: "student_id"
  # has_one :student
  # has_one :exam_schedule

  validates_uniqueness_of :student_id, :scope => :exam_schedule_id

  # validate :check_student_in_course, :check_student_banned
  #
  # private
  # def check_student_in_course
  #   student = self.student
  #   course = self.exam_schedule.course
  #   if course.students.include?(student) != false
  #     return
  #   else
  #     self.status ||= "Sinh viên này không có tên trong danh sách môn đó."
  #   end
  # end
  #
  # def check_student_banned
  #   student = self.student
  #   course = self.exam_schedule.course
  #   flag = CourseStudent.where(student_id: student.id, course_id: course.id).first.banned
  #   if flag
  #     return
  #   else
  #     self.status ||= "Sinh viên này bị cấm thi môn đó."
  #   end
  # end
end
