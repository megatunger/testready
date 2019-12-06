class Course < ApplicationRecord
  has_many :course_students
  has_many :students, through: :course_students

  has_many :exam_schedules
  has_many :exams, through: :exam_schedules, dependent: :destroy

  validates :courseID, :name, :credit, presence: true
  validates :courseID, uniqueness: true
  validates :courseID, format: { with: /[a-zA-Z0-9]/}, presence: true
  validates :credit, numericality: { less_than_or_equal_to: 10, only_integer: true}

  has_one :exam_course

  def course_full_name
    "#{self.courseID} - #{self.name}"
  end
end
