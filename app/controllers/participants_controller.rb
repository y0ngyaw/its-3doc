class ParticipantsController < ApplicationController
	before_action :correct_participant, only: [:edit, :update]
	
	def new
		@participant = Participant.new
	end 

	def create
		@participant = Participant.new(participant_params)
		@password = @participant.password
		if @participant.save
			ParticipantMailer.participant_created(@participant, @password).deliver_later
			redirect_to root_path
		else 
			flash.now[:error] = "Error!"
			render 'new'
		end 
	end 

	def index
	end 

	def edit
		@participant = Participant.find(params[:id])
	end

	def update
		@participant = Participant.find(params[:id])
		if @participant.update_attributes(participant_params)
			redirect_to proposals_path
		else 
			render 'edit'
		end 
	end 


	private
	def participant_params
		params.require(:participant).permit(:name, :email, :password, :phone_num)
	end 

	def correct_participant
		@participant = Participant.find(params[:id])
		redirect_to edit_participant_path(current_participant) unless current_participant?(@participant)
	end 
end
