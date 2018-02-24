# Preview all emails at http://localhost:3000/rails/mailers/participant_mailer
class ParticipantMailerPreview < ActionMailer::Preview
	def participant_created
		ParticipantMailer.participant_created(Participant.first)
	end

	def request_email
		ParticipantMailer.request_email(Pending.first)
	end 

	def joined_group_email
		ParticipantMailer.joined_group_email(TeamMember.find_by(status: "active"))
	end
end
