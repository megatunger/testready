class CreateExamSchedules < ActiveRecord::Migration[5.2]
  def change
    create_table :exam_schedules do |t|
      t.belongs_to :exam
      t.belongs_to :course
      t.date :start
      t.date :finish
      t.timestamps
    end
  end
end
