class Course < ApplicationRecord
  has_many :course_students
  has_many :students, through: :course_students

  has_many :exam_schedules
  has_many :exams, through: :exam_schedules, dependent: :destroy

  validates :courseID, :name, :credit, presence: true
  validates :courseID, uniqueness: true

  belongs_to :exam_course

  def course_full_name
    "#{self.courseID} - #{self.name}"
  end
end
