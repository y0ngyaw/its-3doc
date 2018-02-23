module SessionsHelper
	def log_in participant
		session[:participant_id] = participant.id 
	end 

	def log_out
		forget current_participant
		session.delete(:participant_id)
		@current_participant = nil
	end 

	def remember participant 
		participant.remember
		cookies.permanent.signed[:paticipant_id] = participant.id 
		cookies.permanent[:remember_token] = participant.remember_token
	end 

	def forget participant 
		participant.forget
		cookies.delete(:participant_id)
		cookies.delete(:remember_token)
	end 

	def current_participant
		if (participant_id = session[:participant_id])
			@current_participant ||= Participant.find_by(id: participant_id)
		elsif (participant_id = cookies.signed[:participant_id])
			participant = Participant.find_by(id: participant_id)
			if participant && participant.authenticated?(:remember, cookies[:remember_token])
				log_in participant 
				@current_participant = participant
			end 
		end 
	end 

	def current_participant? participant
		participant == current_participant
	end 

	def logged_in?
		!current_participant.nil?
	end 
end
