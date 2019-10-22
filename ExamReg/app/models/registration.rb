class Registration < ApplicationRecord
  belongs_to :exam_schedule, class_name: 'ExamSchedule', foreign_key: "exam_schedule_id"
  belongs_to :student, class_name: 'Student', foreign_key: "student_id"

end
