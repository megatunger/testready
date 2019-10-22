class CreateRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :rooms do |t|
      t.string :roomID
      t.integer :slot
      t.belongs_to :exam_schedules
      t.timestamps
    end
  end
end
