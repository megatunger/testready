class Student < ApplicationRecord
  has_many :exam_schedules
  has_many :course_students
  has_many :courses, through: :course_students
  has_many :registrations
  has_many :registrations, through: :registrations
  has_one :user
  
  validates :firstName, :lastName, :studentID, :classID, presence: true
  validates :studentID, uniqueness: true

  def full_name
    return "#{self.lastName} #{self.firstName}"
  end
end
