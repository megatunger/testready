class CreateRegistrations < ActiveRecord::Migration[5.2]
  def change
    create_table :registrations do |t|
      t.belongs_to :student
      t.belongs_to :exam_schedule
      t.integer :SBD
      t.timestamps
    end
  end
end
