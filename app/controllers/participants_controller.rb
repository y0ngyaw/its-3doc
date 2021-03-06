class ParticipantsController < ApplicationController
	before_action :logged_in_participant, only: [:new, :create, :edit, :update, :index, :destroy]
	before_action :admin_only, only: [:new, :create, :edit, :update, :index, :destroy]
	
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
			if @participant.sponsor
				ParticipantMailer.sponsor_created_email(@participant, @password).deliver_later
			else 
				ParticipantMailer.participant_created(@participant, @password).deliver_later
			end
			redirect_to participants_path
		else 
			flash.now[:error] = "Failed to create a new participant"
			redirect_to root_path
		end 
	end 

	def index
		@participants = Participant.eager_load(:proposal).order(:id) 
		@proposals = Proposal.eager_load(:team_members).order(:title)
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

	def destroy
		if Participant.exists?(params[:id]) 
			participant = Participant.find(params[:id])
			participant.destroy
		end 

		redirect_to participants_path
	end 

	private
	def participant_params
		params.require(:participant).permit(:name, :email, :phone_num, :sponsor)
	end 

	def admin_only
		redirect_to root_path unless current_participant.admin
	end 
end
