class Registration < ApplicationRecord
  belongs_to :exam_schedule, class_name: 'ExamSchedule', foreign_key: "exam_schedule_id"
  belongs_to :student, class_name: 'Student', foreign_key: "student_id"
  # has_one :student
  # has_one :exam_schedule

  validates_uniqueness_of :student_id,    :scope => :exam_schedule_id
end
