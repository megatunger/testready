json.students(@courses) do |course|
  json.id course.id
  json.courseID course.courseID
  json.name course.name
  json.credit course.credit
end