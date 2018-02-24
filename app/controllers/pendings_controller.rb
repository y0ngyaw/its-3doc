class PendingsController < ApplicationController
	include PendingsHelper
	before_action :logged_in_participant, only: [:create, :destroy]

	def create
		if reach_pending_limit?
			redirect_to root_path
		else 
			@proposal = Proposal.find(params[:proposal_id])
			if !@proposal.nil?
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
	end 

	def destroy
		Pending.find(params[:id]).destroy
		redirect_to root_url
	end 
end
