class ProposalsController < ApplicationController
	include SessionsHelper
	include ProposalsHelper
	before_action :logged_in_participant, only: [:index, :new, :create, :edit, :update, :destroy]
	before_action :no_proposal, only: [:new, :create]
	before_action :correct_participant, only: [:edit, :update, :destroy]

	def new
		@proposal = current_participant.build_proposal()
	end 

	def create
		@proposal = current_participant.build_proposal(proposal_params)
		@proposal.theme = params[:proposal][:theme].to_i()
		if @proposal.save
			redirect_to proposals_path
		else
			render :new
		end 
	end 

	def index
		@participant = current_participant
		@proposals = Proposal.all 

		if has_proposal?
			@pending_lists = current_participant.proposal.pendings
		else 
			@pending_lists = current_participant.pendings
		end 
	end 

	def edit 
		@proposal = Proposal.find_by(participant_id: current_participant.id)
	end 

	def update
		@proposal = Proposal.find_by(participant_id: current_participant.id)
		@proposal.update_attributes(proposal_params)
		@proposal.update_attribute(:theme, params[:proposal][:theme].to_i())
		redirect_to proposals_path
	end 


	def destroy 
		@proposal = Proposal.find_by(participant_id: current_participant.id)
		if @proposal.has_member?
			redirect_to proposals_path
		else
			@proposal.destroy
			redirect_to proposals_path
		end 
	end 

	private 
		def proposal_params
			params.require(:proposal).permit(:title, :description)
		end 

		def no_proposal
			redirect_to proposals_path unless current_participant.proposal.nil?
		end 

		def correct_participant
			redirect_to proposals_path unless current_participant.proposal.id.to_s == params[:id]
		end 
		
end
