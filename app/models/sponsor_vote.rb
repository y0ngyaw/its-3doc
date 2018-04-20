class SponsorVote < ApplicationRecord
	belongs_to :participant, :foreign_key => 'sponsor_id'
end
