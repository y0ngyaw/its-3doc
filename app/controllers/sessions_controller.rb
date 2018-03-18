class SessionsController < ApplicationController
	include SessionsHelper

	def new
		if logged_in?
			redirect_to proposals_path
		else 
			render layout: "login_page_layout"
		end 
	end 

	def create
		participant = Participant.find_by(email: params[:session][:email])
		if participant && participant.authenticate(params[:session][:password])
			log_in participant
			params[:session][:remember_me] == '1' ? remember(participant) : forget(participant)
			redirect_to proposals_path
		else 
			flash[:error] = "Invalid email and/or password"
			redirect_to root_path
		end 
	end 

	def destroy 
		log_out if logged_in?
		redirect_to root_path
	end 

	private
	def session_param
		params.require(:session).permit(:email, :password)
	end 
end
