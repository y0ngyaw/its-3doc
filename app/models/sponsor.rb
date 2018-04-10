class Sponsor < ApplicationRecord
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 255 },
                format: { with: VALID_EMAIL_REGEX }, 
                uniqueness: { case_sensitive: false }
    has_secure_password
    validates :password_digest, presence: true
    attr_accessor :remember_token

    def Sponsor.digest token 
    	cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    	BCrypt::Password.create(token, cost: cost)
    end 

    def Sponsor.new_token
    	SecureRandom.urlsafe_base64
    end 

    def authenticated?(attribute, token)
    	digest = send("#{attribute}_digest")
        return false if digest.nil?
        BCrypt::Password.new(digest).is_password?(token)
    end 

    def remember
    	self.remember_token = Sponsor.new_token
    	update_attribute(:remember_digest, Sponsor.digest(remember_token))
    end 

    def forget
    	update_attribute(:remember_digest, nil)
    end 

    def generate_password
        self.password = SecureRandom.hex(4)
    end 
end
