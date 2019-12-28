module Admin
  class CourseManagementController < DashboardAdminController
    append_before_action :set_instance_course, only: [:edit, :update, :destroy, :show]
    respond_to :html, :json, :js

    # Trang quản lí khoá học
    def index
      @last_exam_schedules = Exam&.last&.exam_schedules
    end

    # Trang tạo khoá học
    def new
      @course = @courses.new
      respond_modal_with @course
    end

    # Tạo khoá học
    def create
      @course = @courses.create(course_params)
      respond_modal_with @course, location: admin_course_index_path
    end

    # Sửa khoa học
    def edit
      respond_modal_with @course
    end

    # Cập nhật khoá học
    def update
      @course.update(course_params)
      respond_modal_with @course, location: admin_course_index_path(@course)
    end

    # Xoá khoá học
    def destroy
      @courses.destroy(@course.id)
      @courses.reload
      render json: {status: 'success'}, status: 200
    end

    # Xem trang khoá học cụ thể
    def show
      @registrations = get_registrations_of_course
      respond_modal_with @course
    end

    private
    def course_params
      params.require(:course).permit(:courseID, :name, :credit)
    end

    def set_instance_course
      @course = @courses.find(params.require(:id))
      @last_exam_schedules = Exam&.last&.exam_schedules&.where(course_id: @course.id)
    end

    def get_registrations_of_course
      @registration_array = Array.new
      @last_exam_schedules&.each do |exam_schedule|
        registrations_of_es = exam_schedule.registrations
        registrations_of_es.each do |registration|
          @registration_array << registration
        end
      end
      @registration_array
    end
  end
end
