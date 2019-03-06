class TeamMembersController < ApplicationController
	include PendingsHelper
	include TeamMembersHelper
	before_action :logged_in_participant, only: [:create, :destroy, :leave, :acknowledge, :stay]
	before_action :after_event, only: [:create, :destroy, :leave, :acknowledge, :stay]
	before_action :voting_session, only: [:create, :destroy, :leave, :acknowledge, :stay]
	before_action :leader, only: [:create, :destroy]
	before_action :member, only: [:leave]
	before_action :verify_leader, only: [:acknowledge, :stay]

	def create
		@pending = Pending.find(params[:id])
		proposal = @pending.proposal
		if is_leader? && team_is_available?(proposal)
			@pending.accept
			@team_member = @pending.participant.team_member
			ParticipantMailer.joined_group_email(@team_member).deliver_later
			if is_last_member? proposal 
				pending_full(proposal.id)
				proposal.update_attribute(:status, false)
			end 
			redirect_to root_path
		end 
	end 

	def destroy 
		@pending = Pending.find(params[:id])
		ParticipantMailer.denied_email(@pending).deliver_later
		@pending.deny
		redirect_to root_path
	end 

	def leave
		@team_member = TeamMember.find_by(participant_id: params[:id])
		ParticipantMailer.wish_to_leave_email(@team_member).deliver_later
		@team_member.wish_to_leave
		redirect_to root_path
	end 

	def acknowledge
		@team_member = TeamMember.find(params[:id])
		if current_participant == proposal_leader(@team_member.proposal)
			if is_last_member? @team_member.proposal 
				pending_not_full(@team_member.proposal.id)
				@team_member.proposal.update_attribute(:status, true)
			end 
			ParticipantMailer.allow_to_leave_email(@team_member).deliver_later
			@team_member.allow_to_leave
			redirect_to root_path
		else
			redirect_to root_path
		end
	end 

	def stay
		@team_member = TeamMember.find(params[:id])
		if current_participant == proposal_leader(@team_member.proposal)
			ParticipantMailer.stay_email(@team_member).deliver_later
			@team_member.stay
		end
		redirect_to root_path
	end 

	private
		def leader
			redirect_to root_path unless current_participant.proposal == Pending.find(params[:id]).proposal 
		end 

		def member
			redirect_to root_path unless current_participant.proposal.nil?
		end 

		def verify_leader
			redirect_to root_path unless current_participant == TeamMember.find(params[:id]).proposal.participant 
		end
end
