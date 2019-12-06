json.students(@students) do |student|
  json.id student.id
  json.studentID student.studentID
  json.firstName student.firstName
  json.lastName student.lastName
  json.birthday student.birthday
  json.sex genderInString(student.sex)
  json.classID student.classID
  json.major student.major
  json.faculty student.faculty
  json.edit_link edit_student_admin_student_management_index_path(student)
  json.updated_at student.updated_at.in_time_zone('Hanoi').strftime("%d-%m-%Y - %H:%M")

end