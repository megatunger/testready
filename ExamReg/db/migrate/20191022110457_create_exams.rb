class CreateExams < ActiveRecord::Migration[5.2]
  def change
    create_table :exams do |t|
      t.string :name
      t.boolean :closed, default: false
      t.timestamps
    end

    create_table :exam_courses do |t|
      # t.integer :id, primary_key: true
      t.belongs_to :exam
      t.belongs_to :course
      t.timestamps
    end

    create_table :exam_schedules do |t|
      t.belongs_to :exam
      t.belongs_to :course
      t.belongs_to :room
      t.date :date
      t.time :start
      t.time :finish
      t.time :duration
      t.timestamps
    end
  end
end