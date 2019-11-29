module Admin
  class RoomManagementController < DashboardAdminController
    append_before_action :setRoomManagementVariables
    append_before_action :setInstanceRoomManagement, only: [:edit, :update, :show]
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

    end

    def create
      @room = @rooms.create(room_params)
      respond_modal_with @room, location: admin_room_management_index_path
    end

    def edit
      respond_modal_with @room
    end

    def update
      @room.update(room_params)
      respond_modal_with @room, location: admin_room_management_path(@room)
    end

    private
    def setRoomManagementVariables
      @rooms = Room.all
    end

    def room_params
      params.require(:room).permit(:name, :slot)
    end

    def setInstanceRoomManagement
      @room = @rooms.find(params.require(:id))
    end
  end
end