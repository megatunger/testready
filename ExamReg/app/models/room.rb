class Room < ApplicationRecord
  belongs_to :exam_schedule, class_name: 'ExamSchedule', foreign_key: 'exam_schedule_id'
  validates :roomID, uniqueness: true

end
