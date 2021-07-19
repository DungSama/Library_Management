class ReservesController < ApplicationController

	 before_action :find_reserve, only: [:edit, :update, :destroy]

	def index
	
			@reserves = Reserve.all
			
	end

	def new
		@reserves = Reserve.new
	end

	def create
		@reserves = Reserve.new(reserve_params)

		@reserve.user_id = current_user.id
		@reserve.request = 'Request'

			if @reserve.save
				redirect_to reserves_path
			else
				render 'new'
			end
	end

	def refuse
			@reserve = Reserve.find(params[:id])
			@reserve.update(request: 'Refuse')
			redirect_back(fallback_location: root_path)
	end

	def destroy
		

    @reserves.destroy
    if @reserves.blank?
    	redirect_to root_path
    else
    	redirect_to reserves_path
    end
  end

	private

	def reserve_params
		params.require(:reserve).permit(:name, :author, :category, :publish, :describe)
	end

	def find_reserve
     @reserves = Reserve.find_by(id: params[:id])
  end
end
