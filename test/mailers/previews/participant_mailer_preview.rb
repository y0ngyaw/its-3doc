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

	def denied_email
		ParticipantMailer.denied_email(Pending.first)
	end 

	def wish_to_leave_email
		ParticipantMailer.wish_to_leave_email(TeamMember.first)
	end 

	def allow_to_leave_email
		ParticipantMailer.allow_to_leave_email(TeamMember.first)
	end

	def stay_email
		ParticipantMailer.stay_email(TeamMember.first)
	end 
end
