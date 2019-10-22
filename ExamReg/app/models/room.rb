class Room < ApplicationRecord
  belongs_to :exam_schedule, class_name: 'ExamSchedule', foreign_key: 'exam_schedule_id'
  validate :roomID, uniqueness: true

end
