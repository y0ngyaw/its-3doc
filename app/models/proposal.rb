class Proposal < ApplicationRecord
  belongs_to :participant
  validates :title, presence: true
  validates :description, presence: true
  validates :theme, presence: true
  has_many :pendings, dependent: :destroy
  has_many :team_members

  def has_member?
  	self.team_members.count > 0
  end 
  
end
