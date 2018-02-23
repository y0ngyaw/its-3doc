class Pending < ApplicationRecord
  belongs_to :participant
  belongs_to :proposal

  def accept
  	self.participant.create_team_member(proposal_id: self.proposal_id)
  	all_pendings = self.participant.pendings 
  	all_pendings.each do |p| 
  		p.update_attribute(:status, "taken")
  	end 
  	self.update_attribute(:status, "accepted")
  end 

  def deny
  	self.update_attribute(:status, "denied")
  end 
  
end
