class CreateCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :courses do |t|
      t.string :courseID, null:false
      t.string :name, null:false
      t.integer :credit
      t.timestamps
    end
  end
end
