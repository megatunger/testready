class Course < ApplicationRecord
  has_many :course_students
  has_many :students, through: :course_students
  has_many :exam_schedules
  validates :courseID, :name, :credit, presence: true
  validates :courseID, uniqueness: true

end
