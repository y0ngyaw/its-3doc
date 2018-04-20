module SponsorVotesHelper

	def calc_sponsor_vote
		sponsor_votes = SponsorVote.all
		top5_proposal = Proposal.where(top5: true)
		sponsor_votes.each do |sv|
			top5_proposal.find(sv.first_place).update_attribute(:sp_marks, top5_proposal.find(sv.first_place).sp_marks + 5)
			top5_proposal.find(sv.second_place).update_attribute(:sp_marks, top5_proposal.find(sv.second_place).sp_marks + 4)
			top5_proposal.find(sv.third_place).update_attribute(:sp_marks, top5_proposal.find(sv.third_place).sp_marks + 3)
			top5_proposal.find(sv.fourth_place).update_attribute(:sp_marks, top5_proposal.find(sv.fourth_place).sp_marks + 2)
			top5_proposal.find(sv.fifth_place).update_attribute(:sp_marks, top5_proposal.find(sv.fifth_place).sp_marks + 1)
		end 
	end 	

	def same_marks_checking(proposal_marks, last_marks)
		proposal_marks == last_marks
	end 

end
