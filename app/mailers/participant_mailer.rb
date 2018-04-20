class ParticipantMailer < ApplicationMailer
	def participant_created(participant, password)
		@participant = participant 
		@password = password
		mail to: @participant.email, subject: "3 Days of Code Hackathon Team-Forming Platform"
	end 

	def request_email(pending)
		@participant = pending.participant
		@leader = pending.proposal.participant
		mail to: @leader.email, subject: "Request to Join - 3 Days of Code Hackathon"
	end 

	def joined_group_email(team_member)
		@leader = team_member.proposal.participant 
		@member = team_member.participant 
		mail to: @member.email, subject: "Grouping Status - 3 Days of Code Hackathon"
	end 

	def no_team_member_email(participant)
		@leader = participant
		@proposal = participant.proposal
		mail to: @leader.email, subject: "Team Status - 3 Days of Code Hackathon"
	end 

	def denied_email(pending)
		@participant_name = pending.participant.name
		@proposal_title = pending.proposal.title
		mail to: pending.participant.email, subject: "Request denied - 3 Days of Code Hackathon"
	end 

	def wish_to_leave_email(team_member)
		@participant = team_member.participant 
		@leader = team_member.proposal.participant 
		mail to: @leader.email, subject: "Team Member Leaving Request - 3 Days of Code Hackathon"
	end 

	def allow_to_leave_email(team_member)
		@participant = team_member.participant 
		@proposal = team_member.proposal
		mail to: @participant.email, subject: "Leaving Request Granted - 3 Days of Code Hackathon"
	end

	def stay_email(team_member)
		@participant = team_member.participant 
		@proposal = team_member.proposal
		mail to: @participant.email, subject: "Team Stay - 3 Days of Code Hackathon"
	end

	def sponsor_created_email(sponsor, password)
		@sponsor = sponsor
		@password = password
		mail to: @sponsor.email, subject: "Sponsors' Platform - 3 Days of Code Hackathon"
	end 
end
