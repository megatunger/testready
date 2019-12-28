module Admin
  class ExamManagementController < DashboardAdminController
    append_before_action :set_variables_exam_management
    append_before_action :set_instance_exam, only: [:edit, :update, :destroy]
    respond_to :html, :json, :js

    # Trang chủ
    def index
    end

    # Trang tạo kỳ thi mới
    def new
      @exam = @exams.new
      respond_modal_with @exam
    end

    # Modal sửa kì thi
    def edit
      respond_modal_with @exam
    end

    # Cập nhật kì thi
    def update
      @exam.update(exam_params)
      respond_modal_with @exam, location: admin_exam_index_path
    end

    # POST Request tạo kỳ thi
    def create
      @exam = @exams.create(exam_params)
      @exam.closed = true
      @exam.save
      respond_modal_with @exam, location: admin_exam_index_path
    end

    # Xoá kì thi
    def destroy
      @exams.destroy(@exam.id)
      @exams.reload
      render json: {status: 'success'}, status: 200
    end

    # Thêm khoá học
    def add_course
      @exam = @exams.find(params.require(:exam_id))
      respond_modal_with @exam
    end

    # Lưu khoá học vào kì thi
    def save_course
      @exam = @exams.find(params.require(:exam_id))
      @exam.courses.clear
      @exam.courses << updated_list_courses
    end

    # Trang đóng thời gian đăng kí
    def closed_prompt
      @exam = @exams.find(params.require(:exam_id))
      respond_modal_with @exam
    end

    # Đóng thời gian đăng kí và tạo SBD
    def closed
      @exam = @exams.find(params.require(:exam_id))
      if @exam&.closed
        @exam.closed = false
        @exam.save
      else
        @exam.closed = true
        @exam.save
        @exam.exam_schedules.each do |exam_schedule|
          registrations = exam_schedule&.registrations.sort_by{ |r| [r.student.firstName, r.student.lastName]}
          registrations&.each_with_index do |registration, index|
            registration&.SBD = index+1
            registration.save
          end
        end
      end
      respond_modal_with @exam, location: admin_exam_schedule_index_path(@exam)
    end

    private
    # Đặt biến cho quản lí kì thi
    def set_variables_exam_management
      @exams = Exam.all
    end

    # Parse params gửi
    def exam_params
      params.require(:exam).permit(:name)
    end

    # Đặt biến cho trang kì thi cụ thể
    def set_instance_exam
      @exam = @exams.find(params.require(:id))
    end

    def updated_list_courses
      @courses.where(id: params.require(:exam).require(:course_ids))
    end

  end
end
