class TeamMembersController < ApplicationController
	include PendingsHelper
	include TeamMembersHelper
	before_action :logged_in_participant, only: [:create, :destroy, :leave, :acknowledge]
	before_action :leader, only: [:create, :destroy]
	before_action :member, only: [:leave]

	def create
		@pending = Pending.find(params[:id])
		if is_leader? && team_is_available?(@pending.proposal)
			@pending.accept
			@team_member = @pending.participant.team_member
			ParticipantMailer.joined_group_email(@team_member).deliver
			redirect_to root_path
		end 
	end 

	def destroy 
		@pending = Pending.find(params[:id])
		@pending.deny
		redirect_to root_path
	end 

	def leave
		@team_member = TeamMember.find_by(participant_id: params[:id])
		@team_member.wish_to_leave
		redirect_to root_path
	end 

	def acknowledge
		@team_member = TeamMember.find(params[:id])
		if current_participant == proposal_leader(@team_member.proposal)
			@team_member.allow_to_leave
			redirect_to root_path
		else
			redirect_to root_path
		end
	end 

	private
		def leader
			redirect_to root_path unless current_participant.proposal == Pending.find(params[:id]).proposal 
		end 

		def member
			redirect_to root_path unless current_participant.proposal.nil?
		end 
end
