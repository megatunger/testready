class DashboardStudentController < ApplicationController
    #before_action :checkRole
    before_action :setInstance

    private
    def setInstance
      #@courses = Student.find(current_user.student_id).courses;
      #puts @courses.to_yaml
    end
end

