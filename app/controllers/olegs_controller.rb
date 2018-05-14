class OlegsController < ApplicationController
	include OlegsHelper
	before_action :find_oleg, only: [:show, :edit, :update, :destroy]
	def index
		@name = get_random_film_name
		@oleg = Oleg.new
	end

	def new
		@oleg = Oleg.new
		
	end


	def create
		@task = Oleg.new(params.require(:task).permit(:filmTitle, :answer))

		if @task.save
			redirect_to @task
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


