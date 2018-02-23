module PendingsHelper
	def is_leader?
		!current_participant.proposal.nil?
	end 

	def is_available? proposal 
		proposal.team_members.count < 3
	end 

	def in_pending? proposal 
		current_participant.pendings.exists?(proposal_id: proposal.id)
	end 

	def in_team? 
		!current_participant.team_member.nil?
	end 

	def eligible_to_join? proposal
		!is_leader? && is_available?(proposal) && !in_pending?(proposal) && !in_team?
	end 

	def reach_pending_limit?
		current_participant.pendings.count >= 3
	end 

	def pending? pending
		pending.status == "pending"
	end 

	def accepted? pending 
		pending.status == "accepted"
	end 

	def denied? pending 
		pending.status == "denied"
	end 

	def taken? pending 
		pending.status == "taken"
	end 

end
