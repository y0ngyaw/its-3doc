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
end
