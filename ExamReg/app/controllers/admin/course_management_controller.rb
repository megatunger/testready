require 'delayed_job_active_record'
module Admin
  class CourseManagementController < DashboardAdminController

    def index
      @course = @courses.new
      respond_to do |format|
        format.html { render :template => "admin/course_management/index/index.html.erb" }
        format.json { render 'admin/course_management/index/index.json.jbuilder'}
      end
    end
  end
end
