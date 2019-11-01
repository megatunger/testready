
  class DashboardStudentController < DashboardController
    layout 'dashboard_student'
    before_action :checkRole

    def index

    end

    private
    def checkRole
      redirect_to error_permission_path unless current_user.role == "student"
    end
  end

