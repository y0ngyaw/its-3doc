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
		!is_leader? && is_available?(proposal) && !in_pending?(proposal) && !in_team? && !reach_pending_limit?
	end 

	def reach_pending_limit?
		current_participant.pendings.where("status = ?", 'pending').count >= 3
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

	def full? pending 
		pending.status == "full"
	end 

	def pending_full p_id 
		@other_pendings = Proposal.find(p_id).pendings
		@other_pendings.each do |p|
			if pending? p 
				p.update_attribute(:status, "full")
			end 
		end 
	end

	def pending_not_full p_id 
		@other_pendings = Proposal.find(p_id).pendings
		@other_pendings.each do |p|
			if full? p 
				p.update_attribute(:status, "pending")
			end 
		end 
	end 

end
