class ExamCourse < ApplicationRecord
  has_one :course
  has_one :exam
end
