class DashboardController < ApplicationController
  before_action :setInstance
  def index
    if current_user.role == "admin"
      redirect_to admin_dashboard_admin_index_path
    end
  end

  def fallback_permission
    respond_to do |format|
      format.html { render :template => 'layouts/fallback/permission' }
    end
  end

  private
  def setInstance
    @students = Student.all
  end
end
