class ExamCourse < ApplicationRecord
  belongs_to :course, class_name: 'Course', foreign_key: "course_id"
  belongs_to :exam, class_name: 'Exam', foreign_key: "exam_id"
end
