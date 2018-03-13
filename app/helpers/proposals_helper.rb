module ProposalsHelper
	def has_proposal?
		!current_participant.proposal.nil?
	end 

	def correct_proposal_participant proposal
		current_participant.id == proposal.participant_id
	end 

	def eligible_to_propose_topic?
		pendings = current_participant.pendings.where("status = ? OR status = ? OR status = ? OR status = ?", 'pending', 'taken', 'accepted', 'full')
		!has_proposal? && pendings.count == 0 && current_participant.team_member.nil?
	end 

	def eligible_to_delete? proposal 
		proposal.pendings.where("status = ?", 'pending').count == 0 && proposal.team_members.count == 0
	end 
end
