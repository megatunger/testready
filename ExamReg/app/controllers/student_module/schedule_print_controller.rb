module StudentModule
  class SchedulePrintController < DashboardStudentController
    append_before_action :setSchedulePrintVariables

    respond_to :html, :json, :js, :pdf
    def index
      respond_to do |format|
        format.html { render :template => "student_module/schedulePrint" }
      end
    end

    def export_pdf
      # @exam_schedule = @exam.exam_schedules.find(params[:schedule_id])
      # @course = @exam_schedule.course
      # @room = @exam_schedule.room
      respond_to do |format|
        format.pdf do
          render pdf: "Export",
                 template: "student_module/print.html.erb",
                 layout: 'pdf.html.erb', show_as_html: params.key?("debug"),
                 dpi: 100
        end
      end
    end

    def setSchedulePrintVariables
      @exam_schedules = ExamSchedule.all
    end
  end
end