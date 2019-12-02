module Admin
  class ExamManagementController < DashboardAdminController
    append_before_action :set_variables_exam_management
    append_before_action :set_instance_exam, only: [:edit, :update, :destroy]
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
      @exam.destroy(@exam.id)
      @exams.reload
    end

    private
    def set_variables_exam_management
      @exams = Exam.all
    end

    def exam_params
      params.require(:exam).permit(:name)
    end

    def set_instance_exam
      @exam = @exams.find(params.require(:id))
    end
  end
end
