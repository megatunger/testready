class ExamSchedule < ApplicationRecord
  belongs_to :exam, class_name: 'Exam', foreign_key: "exam_id"
  belongs_to :course, class_name: 'Course', foreign_key: "course_id"
  belongs_to :room, class_name: 'Room', foreign_key: "room_id"
  has_many :registrations
  has_many :students
end
