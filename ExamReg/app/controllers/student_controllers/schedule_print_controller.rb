module StudentControllers
  class SchedulePrintController < DashboardStudentController
    append_before_action :setSchedulePrintVariables
    def index
      respond_to do |format|
        format.html { render :template => "dashboard_student/schedulePrint.html.erb" }
       end
    end
    def setSchedulePrintVariables
      @exam_schedules = ExamSchedule.all
    end
  end
end