namespace :email_task do
  
  desc "send no team member email"
  task send_no_team_member_email: :environment do
  	proposals = Proposal.all 
  	proposals.each do |p|
  		if(!p.proposal.nil? && p.team_members.exists?)
  			ParticipantMailer.no_team_member_email(p.participant).deliver_later
  		end 
  	end 
  end

end
