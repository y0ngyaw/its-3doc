class TeamMember < ApplicationRecord
  belongs_to :proposal
  belongs_to :participant

  def wish_to_leave
  	self.update_attribute(:status, "inactive")
  end 

  def allow_to_leave
  	participant = Participant.find(self.participant_id)
  	participant.pendings.destroy_all
  	self.destroy
  end 
end
