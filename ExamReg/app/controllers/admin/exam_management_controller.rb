module Admin
  class ExamManagementController < DashboardAdminController
    append_before_action :set_variables_exam_management
    append_before_action :set_instance_exam, only: [:edit, :update, :destroy, :add_course, :save_course]
    respond_to :html, :json, :js

    def index

    end

    def new
      @exam = @exams.new
      respond_modal_with @exam
    end

    def edit
      respond_modal_with @exam
    end

    def update
      @exam.update(exam_params)
      respond_modal_with @exam, location: admin_exam_index_path
    end

    def create
      @exam = @exams.create(exam_params)
      respond_modal_with @exam, location: admin_exam_index_path
    end

    def destroy
      @exams.destroy(@exam.id)
      @exams.reload
      render json: {status: 'success'}, status: 200
    end
    
    def add_course
      respond_modal_with @exam
    end

    def save_course
      @exam.courses.clear
      @exam.courses << updated_list_courses
    end

    private
    def set_variables_exam_management
      @exams = Exam.all
    end

    def exam_params
      params.require(:exam).permit(:name)
    end

    def set_instance_exam
      @exam = @exams.find(params.require(:exam_id))
    end

    def updated_list_courses
      @courses.where(id: params.require(:exam).require(:course_ids))
    end

  end
end
