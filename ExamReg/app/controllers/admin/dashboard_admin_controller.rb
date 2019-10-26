module Admin
  class DashboardAdminController < DashboardController
    layout 'dashboard_admin'

    def index
      respond_to do |format|
        format.html { render :template => "dashboard_admin/index" }
      end
    end
  end
end
