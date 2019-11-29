module StudentControllers
  class SchedulePrintController < DashboardStudentController
    def index
      respond_to do |format|
        format.html { render :template => "dashboard_student/schedulePrint.html.erb" }
       end
    end
  end
end