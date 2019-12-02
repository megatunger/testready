require 'delayed_job_active_record'
module Admin
  class ScheduleManagementController < ExamManagementController
    append_before_action :set_instance_exam, :set_instance_schedule
    append_before_action :set_instance_course, only: [:index]

    def index

      if (params[:courseID] == nil)
        @exam_schedules = ExamSchedule.where(exam_id: @exam.id).to_a
      else
        @exam_schedules = ExamSchedule.where(course_id: params[:courseID].to_i, exam_id: @exam.id).to_a
      end
      respond_to do |format|
        format.html { render :template => "admin/schedule_management/index.html.erb" }
        format.json { render 'admin/schedule_management/index/index.json.jbuilder'}
      end

    end

    def show
      @regist_schedule = ExamSchedule.find(params[:id])
      @course = Course.find(@regist_schedule.course_id)
      @room = Room.find(@regist_schedule.room_id)
      respond_to do |format|
        format.html { render :template => "admin/schedule_management/show.html.erb" }
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
    def newCourse
      @course = @course.new
      respond_modal_with @course
    end
    private
    def set_instance_exam
      @exam = @exams.find(params.require(:exam_id))
    end

    def set_instance_schedule
      @exam_schedules = @exam.exam_schedules
    end

    def set_instance_course
      @exam_courses = Array.new
      @exam.exam_courses.each do |ec|
        @exam_courses << @courses.find(ec.course_id)
      end
    end
  end
end