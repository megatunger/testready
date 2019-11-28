class CreateExamCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :exam_courses do |t|
      t.belongs_to :exam
      t.belongs_to :course
      t.timestamps
    end
  end
end
