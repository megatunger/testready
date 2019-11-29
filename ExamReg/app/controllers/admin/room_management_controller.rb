module Admin
  class RoomManagementController < DashboardAdminController
    append_before_action :setRoomManagementVariables
    def index
      redirect_to admin_room_management_path(@rooms.first)
    end

    def new

    end

    def destroy

    end

    def create

    end

    def edit

    end

    def update

    end

    private
    def setRoomManagementVariables
      @rooms = Room.all
    end
  end
end