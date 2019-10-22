class ExamSchedule < ApplicationRecord
  belongs_to :exam, class_name: 'Exam', foreign_key: "exam_id"
  belongs_to :course, class_name: 'Course', foreign_key: "course_id"
  has_many :registrations
  has_many :students
  has_many :rooms
end
