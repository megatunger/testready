module Admin
  class CourseManagementController < DashboardAdminController
    append_before_action :set_instance_course, only: [:edit, :update, :destroy, :show]
    respond_to :html, :json, :js

    def index
    end

    def new
      @course = @courses.new
      respond_modal_with @course
    end

    def create
      @course = @courses.create(course_params)
      respond_modal_with @course, location: admin_course_index_path
    end

    def edit
      respond_modal_with @course
    end

    def update
      @course.update(course_params)
      respond_modal_with @course, location: admin_course_index_path(@course)
    end

    def destroy
      @courses.destroy(@course.id)
      @courses.reload
      render json: {status: 'success'}, status: 200
    end

    def show
      @lastest_exam_of_course = @course.exams.last
      @registrations = get_registrations_of_course
      respond_modal_with @course
    end

    private
    def course_params
      params.require(:course).permit(:courseID, :name, :credit)
    end

    def set_instance_course
      @course = @courses.find(params.require(:id))
    end

    def get_registrations_of_course
      @registration_array = Array.new
      unless @lastest_exam_of_course.nil?
        @exam_schedules = @lastest_exam_of_course.exam_schedules.where(course_id: @course.id)
        @exam_schedules.each do |exam_schedule|
          exam_schedule.registrations.each do |registration|
            @registration_array << registration
          end
        end
      end
      @registration_array
    end
  end
end
