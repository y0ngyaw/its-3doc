module ProposalsHelper
	def has_proposal?
		!current_participant.proposal.nil?
	end 

	def correct_proposal_participant proposal
		current_participant.id == proposal.participant_id
	end 

end
