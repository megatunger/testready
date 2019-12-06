class Room < ApplicationRecord
  has_many :exam_schedules, dependent: :destroy
  validates :name, :slot, :presence => true
  validates :slot, numericality: { greater_than_or_equal_to: 0,  only_integer: true }
  validates :name, :uniqueness => {:scope => :name}
end

