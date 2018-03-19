class ParticipantsController < ApplicationController
	before_action :only_admin, only: [:new, :create, :edit, :update, :index]
	
	def new
		@participant = Participant.new

		respond_to do |format|
			format.js
			format.html
		end 
	end 

	def create
		@participant = Participant.new(participant_params)
		@password = @participant.generate_password
		if @participant.save
			ParticipantMailer.participant_created(@participant, @password).deliver_later
			redirect_to root_path
		else 
			flash.now[:error] = "Failed to create a new participant"
			redirect_to root_path
		end 
	end 

	def index
		@participants = Participant.eager_load(:proposal) 
	end 

	def edit
		@participant = Participant.find(params[:id])

		respond_to do |format|
			format.js
			format.html
		end 
	end

	def update
		@participant = Participant.find(params[:id])
		if @participant.update_attributes(participant_params)
			redirect_to participants_path
		else 
			redirect_to participants_path
		end 
	end 

	private
	def participant_params
		params.require(:participant).permit(:name, :email, :phone_num)
	end 

	def only_admin
		redirect_to root_path unless current_participant.admin
	end 
end
