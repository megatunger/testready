module Admin
  class DashboardAdminController < DashboardController
    layout 'dashboard_admin'
    before_action :checkRole

    def index
      respond_to do |format|
        format.html { render :template => "dashboard_admin/index" }
      end
    end

    private
    def checkRole
      redirect_to error_permission_path unless current_user.role == "admin"
    end
  end
end
