class DashboardController < ApplicationController
  before_action :setInstance

  private
  def setInstance
    @students = Student.all
    @courses = Course.all
  end
end
