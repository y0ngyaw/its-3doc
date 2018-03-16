class Participant < ApplicationRecord
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 255 },
                format: { with: VALID_EMAIL_REGEX }, 
                uniqueness: { case_sensitive: false }
    has_secure_password
    validates :password_digest, presence: true
    has_one :proposal, dependent: :destroy
    has_many :pendings
    has_one :team_member
    attr_accessor :remember_token

    def Participant.digest token 
    	cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    	BCrypt::Password.create(token, cost: cost)
    end 

    def Participant.new_token
    	SecureRandom.urlsafe_base64
    end 

    def authenticated?(attribute, token)
    	digest = send("#{attribute}_digest")
        return false if digest.nil?
        BCrypt::Password.new(digest).is_password?(token)
    end 

    def remember
    	self.remember_token = Participant.new_token
    	update_attribute(:remember_digest, Participant.digest(remember_token))
    end 

    def forget
    	update_attribute(:remember_digest, nil)
    end 

    def secure_password
        SecureRandom.hex(5)
    end 

    def self.no_team_member_reminder 
        participants = Participant.all 
        participants.each do |p| 
            if !p.proposal.nil? && p.proposal.team_members.count == 0
                ParticipantMailer.no_team_member_email(p).deliver_later
            end 
        end 
    end
end
