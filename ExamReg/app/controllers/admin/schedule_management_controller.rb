require 'delayed_job_active_record'
module Admin
  class ScheduleManagementController < DashboardAdminController
    before_action :setInstance
    def index
      @exam_schedule = @exam_schedules.new
      respond_to do |format|
        format.html { render :template => "admin/schedule_management/index/index.html.erb" }
        format.json { render 'admin/schedule_management/index/index.json.jbuilder'}
      end
    end
    private
    def setInstance
      @exam_schedules = ExamSchedule.all
    end
  end
end