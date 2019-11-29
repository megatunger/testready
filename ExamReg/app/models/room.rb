class Room < ApplicationRecord
  has_many :exam_schedules
  validates :name, :slot, :presence => true
end
