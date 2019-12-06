class Student < ApplicationRecord
  has_many :exam_schedules
  has_many :course_students
  has_many :courses, through: :course_students
  has_many :registrations
  has_one :user
  
  validates :firstName, :lastName,format: { with: /[a-zA-Z]/}, presence: true
  validates :studentID, :classID, presence: true
  validates :studentID, uniqueness: true

  after_create do
    student_account = User.create(email: "#{self.studentID}@abc.edu.vn", password: self.studentID, role: "student")
    student_account.student_id = self.id
    student_account.save
  end

  def full_name
    return "#{self.lastName} #{self.firstName}"
  end
end
