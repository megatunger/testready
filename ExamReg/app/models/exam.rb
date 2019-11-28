class Exam < ApplicationRecord
  has_many :exam_courses
  has_many :courses
end
