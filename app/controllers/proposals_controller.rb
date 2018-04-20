class ProposalsController < ApplicationController
	include SessionsHelper
	include ProposalsHelper
	before_action :logged_in_participant, only: [:index, :new, :create, :edit, :update, :destroy, :top5]
	before_action :no_proposal, only: [:new, :create]
	before_action :correct_participant, only: [:edit, :update, :destroy]
	before_action :admin_only, only: [:top5]

	def new
		if eligible_to_propose_topic?
			@proposal = current_participant.build_proposal()

			respond_to do |format| 
				format.html
				format.js 
			end 
		end
	end 

	def create
		if eligible_to_propose_topic?
			@proposal = current_participant.build_proposal(proposal_params)
			if @proposal.save
				redirect_to proposals_path
			else
				redirect_to proposals_path
			end 
		end
	end 

	def index
		@proposals = Proposal.eager_load(:team_members, :pendings).order(:theme, :title) 

		if has_proposal?
			@pending_lists = current_participant.proposal.pendings.eager_load(:participant, :proposal)
		else 
			@pending_lists = current_participant.pendings.eager_load(:participant, :proposal)
		end 
	end 

	def edit 
		@proposal = Proposal.find_by(participant_id: current_participant.id)

		respond_to do |format|
			format.js
			format.html
		end 
	end 

	def update
		@proposal = Proposal.find_by(participant_id: current_participant.id)
		if @proposal.update_attributes(proposal_params)
			redirect_to proposals_path
		else
			print @proposal.errors.full_messages
			redirect_to proposals_path
		end 
	end 

	def destroy 
		@proposal = Proposal.find_by(participant_id: current_participant.id)
		if @proposal == Proposal.find(params[:id])
			if @proposal.has_member?
				redirect_to proposals_path
			else
				@proposal.destroy
				redirect_to proposals_path
			end 
		end 
	end 

	def top5
		@proposal = Proposal.find(params[:id])
		@proposal.update_attribute(:top5, true)
		@proposal.participant.update_attribute(:vote, false)
		@proposal.team_members.each do |tm|
			tm.participant.update_attribute(:vote, false)
		end 
		redirect_to participants_path
	end 

	private 
		def proposal_params
			params.require(:proposal).permit(:title, :description, :tech, :theme, :documentation)
		end 

		def no_proposal
			redirect_to proposals_path unless current_participant.proposal.nil?
		end 

		def correct_participant
			redirect_to proposals_path unless current_participant.proposal.id.to_s == params[:id]
		end 

		def admin_only
			redirect_to proposals_path unless current_participant.admin 
		end 
		
end
