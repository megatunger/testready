module Admin
  class RoomManagementController < DashboardAdminController
    append_before_action :setRoomManagementVariables
    append_before_action :setInstanceRoomManagement, only: [:edit, :update, :show, :destroy]
    respond_to :html, :json, :js

    def index
    end

    def show
    end

    def new
      @room = @rooms.new
      respond_modal_with @room
    end

    def destroy
      @rooms.destroy(@room.id)
      @rooms.reload
    end

    def create
      @room = @rooms.create(room_params)
      respond_modal_with @room, location: admin_room_management_index_path
    end

    def edit
      respond_modal_with @room
    end

    def update
      if check_room_slot_available
        @room.update(room_params)
        respond_modal_with @room, location: admin_room_management_path(@room)
      end
    end

    def room_schedule
      if params[:id].to_i == -1 # All rooms schedule
        @schedules = ExamSchedule.all
      else  # Specific room
        setInstanceRoomManagement
        @schedules = @room.exam_schedules
      end
    end

    private
    def setRoomManagementVariables
      @rooms = Room.all
      @exams = Exam.all
    end

    def room_params
      params.require(:room).permit(:name, :slot)
    end

    def setInstanceRoomManagement
      @room = @rooms.find(params.require(:id))
    end

    def check_room_slot_available
      check = true
      max = params[:room][:slot].to_i
      @room.exam_schedules.each do |exam_schedule|
        if exam_schedule.registrations.count.to_i > max
          check = false
          break
        end
      end
      return check
    end
  end
end