module StudentModule
  class DashboardStudentController < DashboardController
    layout 'dashboard_student'
    before_action :checkRole
    append_before_action :set_student_variables

    respond_to :html, :json, :js

    def index
      respond_to do |format|
        format.html { render :template => "student_module/index" }
      end
    end

    def new_registration
      set_instance_course
      @exam_schedules = @exam_schedules.where(course_id: @course.id, exam_id: @exam.id)
      respond_modal_with @course
    end

    def save_registration
      check_if_registered
      if params[:schedule] != nil
        @exam_schedule = @exam_schedules&.find(params[:schedule][:id].last.to_i)
        @exam_schedule.registrations.create(student_id: @student.id)
      end
      respond_modal_with @course, location: student_path
    end

    private

    def checkRole
      redirect_to error_permission_path unless current_user.role == "student"
    end

    def set_student_variables
      @exam = Exam.last
      @exam_schedules = @exam&.exam_schedules
      @student = Student.find(current_user.student_id)
      @courses = @student.courses
      @registrations = Registration.all
      @courseStudents = CourseStudent.all
    end

    def set_instance_course
      @course = Course.find(params.require(:courseID))
    end

    def check_if_registered
      @course = Course.find(params.require(:courseID))
      @exam_schedules = @exam_schedules.where(course_id: @course.id)
      @exam_schedules.each do |exam_schedule|
        if exam_schedule.registrations.map { |r| r.student }.include?(@student)
          old_registration = exam_schedule.registrations.where(student_id: @student.id)
          exam_schedule.registrations.destroy(old_registration)
        end
      end
    end

  end
end
