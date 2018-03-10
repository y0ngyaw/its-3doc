class Proposal < ApplicationRecord
  belongs_to :participant
  validates :title, presence: true, length: { maximum: 65 }
  validates :description, presence: true, length: { maximum: 255 }
  validates :theme, presence: true, numericality: { only_integer: true }
  has_many :pendings, dependent: :destroy
  has_many :team_members

  def has_member?
  	self.team_members.count > 0
  end 
  
end
