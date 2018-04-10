module SponsorSessionsHelper
	def log_in_sponsor sponsor
		session[:sponsor_id] = sponsor.id 
	end 

	def log_out_sponsor
		forget current_sponsor
		session.delete(:sponsor_id)
		@current_sponsor = nil
	end 

	def remember_sponsor sponsor 
		sponsor.remember
		cookies.permanent.signed[:sponsor_id] = sponsor.id 
		cookies.permanent[:remember_token] = sponsor.remember_token
	end 

	def forget_sponsor sponsor 
		sponsor.forget
		cookies.delete(:sponsor_id)
		cookies.delete(:remember_token)
	end 

	def current_sponsor
		if (sponsor_id = session[:sponsor_id])
			@current_sponsor ||= Sponsor.find_by(id: sponsor_id)
		elsif (sponsor_id = cookies.signed[:sponsor_id])
			sponsor = Sponsor.find_by(id: sponsor_id)
			if sponsor && sponsor.authenticated?(:remember, cookies[:remember_token])
				log_in sponsor 
				@current_sponsor = sponsor
			end 
		end 
	end 

	def current_sponsor? sponsor
		sponsor == current_sponsor
	end 

	def sponsor_logged_in?
		!current_sponsor.nil?
	end 
end
