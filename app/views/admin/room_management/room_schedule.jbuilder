json.(@schedules) do |schedule|
  json.id schedule.id
  json.title "#{schedule.course.name} - Kì thi: #{@exams.find(schedule.exam_id).name} Phòng: #{@rooms.find(schedule.room_id).name} - Số lượng ĐK: #{schedule.registrations.count}"
  json.start schedule.time_combine[:start]
  json.end schedule.time_combine[:end]
  json.number_registrations
end