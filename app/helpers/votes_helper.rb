module VotesHelper
	def top_five_proposal? id
		if Proposal.exists?(id)
			Proposal.find(id).top5
		else 
			return false
		end 
	end 

	def reach_voting_limit?
		current_participant.votes.count >= 2
	end 

	def eligible_to_vote? id 
		current_participant.vote? && !reach_voting_limit? && top_five_proposal?(id) && !voted?(id)
	end 

	def voted? id
		current_participant.votes.exists?(proposal_id: id)
	end

	def vote_remaining
		2 - current_participant.votes.count
	end 
	
end
