class CourseStudent < ApplicationRecord
  belongs_to :course, class_name: 'Course', foreign_key: "course_id"
  belongs_to :student, class_name: 'Student', foreign_key: "student_id"
end
