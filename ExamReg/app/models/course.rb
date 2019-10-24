class Course < ApplicationRecord
  has_many :course_students
  has_many :students, through: :course_students
  validates :courseID, :name, :credit, presence: true
  validate :courseID, uniqueness: true


end
