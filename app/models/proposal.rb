class Proposal < ApplicationRecord
  belongs_to :participant
  validates :title, presence: true, length: { maximum: 65 }
  validates :description, presence: true, length: { maximum: 255 }
  validates :tech, presence: true, length: { maximum: 30 }
  validates :theme, presence: true, numericality: { only_integer: true }
  has_many :pendings, dependent: :destroy
  has_many :team_members
  has_many :votes, dependent: :destroy
  has_attached_file :documentation
  VALID_FILE_NAME = /pdf\z/
  validates_attachment_file_name :documentation, matches: VALID_FILE_NAME

  def has_member?
  	self.team_members.count > 0
  end 
  
end
