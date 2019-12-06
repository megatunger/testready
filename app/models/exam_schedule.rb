class ExamSchedule < ApplicationRecord
  belongs_to :exam, class_name: 'Exam', foreign_key: "exam_id"
  belongs_to :course, class_name: 'Course', foreign_key: "course_id"
  belongs_to :room, class_name: 'Room', foreign_key: "room_id"
  has_many :registrations
  has_many :students

  validates :date, :start, :finish, :presence => true

  before_save :change_time_format

  validate :check_time_available

  def time_combine
    {:start => DateTime.new(self.date.year, self.date.month, self.date.day, self.start.hour, self.start.min),
     :end => DateTime.new(self.date.year, self.date.month, self.date.day, self.finish.hour, self.finish.min)}
  end

  def time_full_string
    time = self.time_combine
    "#{self.date.strftime("%d/%m/%Y")} - (#{time[:start].strftime("%H:%M")} - #{time[:end].strftime("%H:%M")})"
  end


  def check_time_available
    checking_schedules = ExamSchedule.where(exam_id: self.exam_id, room_id: self.room_id).where('start >= ?', self.start).where('finish <= ?', self.finish)
    if checking_schedules.exists?
      errors[:base] << "Tồn tại ca thi trong khoảng thời gian đó."
      false
    else
      true
    end
  end

  private
  def change_time_format
    self.start = self.time_combine[:start]
    self.finish = self.time_combine[:end]
  end
end
