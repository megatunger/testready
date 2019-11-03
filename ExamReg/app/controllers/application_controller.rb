class ApplicationController < ActionController::Base
  include Clearance::Controller
  before_action :require_login, :set_constant
  def index
    if current_user.role == "admin"
      redirect_to admin_dashboard_admin_index_path
    end
    if current_user.role == "student"
      redirect_to dashboard_student_index_path
    end
  end

  def fallback_permission
    respond_to do |format|
      format.html { render :template => 'layouts/fallback/permission' }
    end
  end
  def set_constant
    @App_Name = "TestReady"
  end
end
