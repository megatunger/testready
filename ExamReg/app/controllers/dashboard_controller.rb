class DashboardController < ApplicationController
  def index
    if current_user.role = "admin"
      redirect_to admin_dashboard_admin_index_path
    end
  end
end
