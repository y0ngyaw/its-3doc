module TeamMembersHelper
	def team_is_available? proposal
		proposal.team_members.count < 3
	end 

	def all_team_members proposal
		proposal.team_members 
	end 

	def proposal_leader proposal 
		proposal.participant
	end 

	def inactive_member? team_member 
		team_member.status == "inactive"
	end 

	def is_last_member? proposal
		proposal.team_members.count == 3
	end

	def reactive_member? team_member
		team_member.status == "reactive"
	end 
end
