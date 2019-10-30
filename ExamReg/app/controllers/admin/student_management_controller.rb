module Admin
  class StudentManagementController < DashboardAdminController

    def index
      respond_to do |format|
        format.html { render :template => "dashboard_admin/student_management/index/index.html.erb" }
        format.json { render 'dashboard_admin/student_management/index/index.json.jbuilder'}
      end
    end

    def deleteAll
          @students.destroy_all
          @students.reload
          render json: {status: 'success'}, status: 200
    end

  end

end