module Admin::ScheduleManagementHelper
  def active_course_index_path
    (@course==nil) ? "active" : ""
  end

  def active_course_path(course)
    (@course&.id==course.id)? "active" : ""
  end
end
