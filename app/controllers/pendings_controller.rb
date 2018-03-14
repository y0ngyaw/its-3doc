class PendingsController < ApplicationController
	include PendingsHelper
	before_action :logged_in_participant, only: [:create, :destroy]
	before_action :correct_participant, only: [:destroy]
	before_action :existing_proposal, only: [:create]

	def create
		if reach_pending_limit?
			redirect_to root_path
		else 
			@proposal = Proposal.find(params[:proposal_id])
			if eligible_to_join? @proposal 
				@pending = current_participant.pendings.build(proposal_id: @proposal.id)
				if @pending.save
					ParticipantMailer.request_email(@pending).deliver_later
					redirect_to root_path
				else 
					redirect_to root_path
				end 
			end 
		end 
	end 

	def destroy
		Pending.find(params[:id]).destroy
		redirect_to root_url
	end 

	private 
		def correct_participant
			redirect_to root_path unless current_participant?(Pending.find(params[:id]).participant)
		end 

		def existing_proposal
			redirect_to root_path unless Proposal.exists?(params[:proposal_id])
		end
end
