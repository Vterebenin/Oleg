class OlegsController < ApplicationController
	include OlegsHelper
	before_action :find_oleg, only: [:show, :edit, :update, :destroy]
	def index
		@name = get_random_film_name
		@oleg = Oleg.new
	end

	def new
		@oleg = Oleg.new
		@oleg.filmTitle = film_to_oleg(get_valid_film_name(get_random_film_name))
		
	end


	def create
		@oleg = Oleg.new(params.require(:oleg).permit(:filmTitle, :answer))

		if @oleg.save
			redirect_to @oleg
		else
			render 'New'
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


