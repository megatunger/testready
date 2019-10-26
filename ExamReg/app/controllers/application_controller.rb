class ApplicationController < ActionController::Base
  include Clearance::Controller
  before_action :require_login, :set_constant

  def set_constant
    @App_Name = "TestReady"
  end
end
