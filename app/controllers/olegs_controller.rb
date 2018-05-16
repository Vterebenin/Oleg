class OlegsController < ApplicationController
	include OlegsHelper
	before_action :authenticate_user!, except: [:index]
	before_action :find_oleg, only: [:show, :edit, :update, :destroy]
	
	def index
		if user_signed_in? 
			@olegs = Oleg.all.order("created_at DESC")
		else
			@oleg = Oleg.new
			@oleg.filmTitle = film_to_oleg(get_random_film_name)
		end
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
			flash[:notice] = bad_notice
			redirect_to new_oleg_path
		end
	end

	def show
		#
	end

	private

		def find_oleg
			@oleg = Oleg.find(params[:id])
		end
end


