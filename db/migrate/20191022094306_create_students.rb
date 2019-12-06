class CreateStudents < ActiveRecord::Migration[5.2]
  def change
    create_table :students do |t|
      t.integer :studentID, null: false
      t.string :firstName, null: false
      t.string :lastName, null: false
      t.date :birthday
      t.boolean :sex
      t.string :classID
      t.string :major
      t.string :faculty
      t.string :password
      t.string :token
      t.timestamps
    end
  end
end
