class Vote < ApplicationRecord
  belongs_to :participant
  belongs_to :proposal
end
