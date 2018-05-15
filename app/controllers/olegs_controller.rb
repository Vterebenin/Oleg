class OlegsController < ApplicationController
	include OlegsHelper
	before_action :find_oleg, only: [:show, :edit, :update, :destroy]
	
	def index
		@name = get_random_film_name
		@oleg = Oleg.new
	end

	def new
		@oleg = Oleg.new
		@oleg.filmTitle = film_to_oleg(get_random_film_name)
	end


	def create
		@oleg = Oleg.new(params.require(:oleg).permit(:answer))		
		if @oleg.save
			flash[:notice] = good_notice
			redirect_to new_oleg_path
		else
			flash[:alert] = bad_notice
			redirect_to root_path
		end
	end

	def show
		#
	end

	def edit
		#
	end

	def update
		#
	end

	def destroy
		#
	end

	private

		def find_oleg
			@oleg = Oleg.find(params[:id])
		end
end


