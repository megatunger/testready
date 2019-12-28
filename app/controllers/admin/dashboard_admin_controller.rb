module Admin
  class DashboardAdminController < DashboardController
    layout 'dashboard_admin'
    before_action :checkRole, :setInstance

    # Trang chủ cho Admin
    def index
      @exam_schedules = ExamSchedule.all
      @registrations = Registration.all
      @banned = CourseStudent.where(banned: true).select(:id).uniq
      respond_to do |format|
        format.html { render :template => "admin/index" }
      end
    end


    private
    # Kiểm tra có đúng quyền admin truy cập
    def checkRole
      redirect_to error_permission_path unless current_user.role == "admin"
    end

    # Set biến cho admin controller
    def setInstance
      @students = Student.all
      @courses = Course.all
    end
  end
end
