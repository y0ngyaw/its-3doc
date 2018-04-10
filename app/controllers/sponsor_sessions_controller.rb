class SponsorSessionsController < ApplicationController
	include SponsorSessionsHelper

	def new
		if sponsor_logged_in?
			redirect_to projects_path
		else 
			render layout: "login_page_layout"
		end 
	end 

	def create
		sponsor = Sponsor.find_by(email: params[:session][:email])
		if sponsor && sponsor.authenticate(params[:session][:password])
			log_in_sponsor sponsor
			params[:session][:remember_me] == '1' ? remember_sponsor(sponsor) : forget_sponsor(sponsor)
			redirect_to projects_path
		else 
			flash[:error] = "Invalid email and/or password"
			redirect_to sponsor_login_path
		end 
	end 

	def destroy
		log_out_sponsor if sponsor_logged_in?
		redirect_to sponsor_login_path
	end 
end
