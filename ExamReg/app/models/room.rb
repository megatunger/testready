class Room < ApplicationRecord
  has_many :exam_schedules, dependent: :destroy
  validates :name, :slot, :presence => true
end
