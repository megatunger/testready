class CreateCourseStudents < ActiveRecord::Migration[5.2]
  def change
    create_table :course_students do |t|
      t.belongs_to :student
      t.belongs_to :course
      t.boolean :banned
      #banned = 0 || null: student allow to attend this exam course
      #banned = 1: student is allowed to attend this exam course
      t.timestamps
    end
  end
end
