module StudentControllers
  class DashboardStudentController < DashboardController
    layout 'dashboard_student'
    before_action :checkRole
    append_before_action :setDasboardStudentVariables
    def index

      respond_to do |format|
        format.html { render :template => "dashboard_student/index.html.erb" }
        format.json { render 'dashboard_student/index/index.json.jbuilder'}
      end
    end
    private
    def checkRole
      redirect_to error_permission_path unless current_user.role == "student"
    end
    def setDasboardStudentVariables
      @student = Student.find(current_user.student_id)
      @registrations = Registration.all
      @courseStudents = CourseStudent.all
    end
  end
end
