class Student < ApplicationRecord
  has_many :course_students
  has_many :exam_schedules
  has_many :courses, through: :course_students
  validates :firstName, :lastName, :studentID, presence: true
  validates :studentID, uniqueness: true

end
