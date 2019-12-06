module Admin
  class ScheduleManagementController < ExamManagementController
    append_before_action :set_instance_exam
    append_before_action :set_instance_schedule, only: [:show, :edit, :update]
    append_before_action :set_instance_new_exam_schedule, only: [:new, :create]
    respond_to :html, :json, :js, :pdf

    def index
      if params[:course] != nil
        @course = @courses.find(params[:course].to_i)
        @exam_schedules = @exam_schedules.where(course_id: params.require(:course))
      end
    end

    def show
      respond_modal_with @exam_schedule
    end

    def export_pdf
      @exam_schedule = @exam.exam_schedules.find(params[:schedule_id])
      @course = @exam_schedule.course
      @room = @exam_schedule.room
      respond_to do |format|
        format.pdf do
          render pdf: "Export",
                 template: "admin/schedule_management/show/print.html.erb",
                 layout: 'pdf.html.erb', show_as_html: params.key?("debug"),
                 dpi: 100
        end
      end
    end

    def new
      respond_modal_with @exam_schedule
    end

    def create
      params[:exam_schedule][:room_id].each do |room_id|
        if room_id.to_i!=0
          room = @rooms.find(room_id.to_i)
          @exam_schedule = ExamSchedule.new(exam_schedule_params)
          @exam_schedule.exam_id = @exam.id
          @exam_schedule.room_id = room.id
          @exam_schedule.save
        end
      end
      respond_modal_with @exam_schedule, location: admin_exam_schedule_index_path
    end

    def edit
      respond_modal_with @exam_schedule
    end

    def update
      @exam_schedule.update(exam_schedule_params_update)
      respond_modal_with @exam_schedule, location: admin_exam_schedule_index_path
    end

    def delete
      @exam_schedule = @exam.exam_schedules.find(params[:schedule_id])
      @course = @exam_schedule.course
      @room = @exam_schedule.room
      respond_modal_with @exam_schedule
    end

    def destroy
      @exam_schedule = @exam.exam_schedules.find(params[:id])
      @course = @exam_schedule.course
      @room = @exam_schedule.room
      @exam_schedules.destroy(@exam_schedule)
    end

    private
    def set_instance_exam
      @exam = @exams.find(params.require(:exam_id))
      @exam_schedules = @exam.exam_schedules
      @exam_courses = @exam.courses
      @rooms = Room.all
    end

    def set_instance_schedule
      @exam_schedule = @exam.exam_schedules.find(params[:id])
      @course = @exam_schedule.course
      @room = @exam_schedule.room
    end

    def exam_schedule_params
      params.require(:exam_schedule).permit(:exam_id, :course_id, :date, :start, :finish)
    end

    def exam_schedule_params_update
      params.require(:exam_schedule).permit(:exam_id, :room_id, :course_id, :date, :start, :finish)
    end

    def set_instance_new_exam_schedule
      @exam_schedule = ExamSchedule.new
      @exam_schedule.exam_id = @exam.id
    end
  end
end