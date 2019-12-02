require 'delayed_job_active_record'
module Admin
  class ScheduleManagementController < ExamManagementController
    append_before_action :set_instance_exam, :set_instance_schedule

    def index
      respond_to do |format|
        format.html { render :template => "admin/schedule_management/index.html.erb" }
        format.json { render 'admin/schedule_management/index/index.json.jbuilder'}
      end
    end

    def showExam
      @exam = @exams.find(params[:examID].to_i)
      @exam_courses = Array.new
      @exam.exam_courses.each do |ec|
        @exam_courses << @courses.find(ec.course_id)
      end
      if (params[:courseID] == nil)
        @exam_schedules = ExamSchedule.where(exam_id: params[:examID].to_i).to_a
      else
        @exam_schedules = ExamSchedule.where(course_id: params[:courseID].to_i, exam_id: params[:examID].to_i).to_a
      end
      respond_to do |format|
        format.html { render :template => "admin/schedule_management/show.html.erb" }
      end
    end
    def showSchedule
      # @exam_courses = Array.new
      # @exam_schedules = []
      # @exam.exam_courses.each do |ec|
      #   @exam_courses << @courses.find(ec.course_id)
      #   @exam_schedules.push(ExamSchedule.where(course_id: ec.course_id, exam_id: ec.exam_id).to_a)
      # end


      respond_to do |format|
        format.html { render :template => "dashboard_admin/schedule_management/show.html.erb" }
      end
    end

    def create
      # @exam_schedule = @exam_schedules.new(exam_schedule_params)
      # if @exam_schedule.valid?
      #   @exam_schedule.save
      #   puts "SAVED!!!"
      # else
      # end
      # puts @exam_schedule.course_id.name;
      render plain: params.inspect
    end

    private
    def set_instance_exam
      @exam = @exams.find(params.require(:exam_id))
    end

    def set_instance_schedule
      @exam_schedules = @exam.exam_schedules
    end
  end
end