module Admin
  class DashboardAdminController < DashboardController
    layout 'dashboard_admin'
    before_action :checkRole, :setInstance
    def index
      @exam_schedules = ExamSchedule.all
      @registrations = Registration.all
      @banned = CourseStudent.where(banned: true).select(:id).uniq
      respond_to do |format|
        format.html { render :template => "admin/index" }
      end
    end


    private
    def checkRole
      redirect_to error_permission_path unless current_user.role == "admin"
    end

    def setInstance
      @students = Student.all
      @courses = Course.all
    end
  end
end