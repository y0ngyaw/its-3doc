# Preview all emails at http://localhost:3000/rails/mailers/participant_mailer
class ParticipantMailerPreview < ActionMailer::Preview
	def participant_created
		ParticipantMailer.participant_created(Participant.first, "lalala")
	end

	def request_email
		ParticipantMailer.request_email(Pending.first)
	end 

	def joined_group_email
		ParticipantMailer.joined_group_email(TeamMember.find_by(status: "active"))
	end

	def no_team_member_email
		ParticipantMailer.no_team_member_email(TeamMember.first.proposal.participant)
	end 
end
