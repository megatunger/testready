class Exam < ApplicationRecord
  has_many :exam_courses
  has_many :courses, through: :exam_courses

  has_many :exam_schedules
  validates :name, :presence => true
end
