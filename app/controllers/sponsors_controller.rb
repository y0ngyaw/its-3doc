class SponsorsController < ApplicationController
	layout "sponsor_page_layout"
	include SponsorSessionsHelper
	before_action :admin_only, only: [:new, :create, :index, :delete]

	def new
		@sponsor = Sponsor.new

		respond_to do |format|
			format.html
			format.js
		end 
	end 

	def create
		@sponsor = Sponsor.new(sponsor_params)
		@password = @sponsor.generate_password
		if @sponsor.save
			redirect_to projects_path
		else 
			flash.now[:error] = "Failed to create a new participant"
			redirect_to projects_path
		end 
	end 

	def index
		@sponsors = Sponsor.all
	end 

	def destroy
		@sponsor = Sponsor.find(params[:id])
		@sponsor.destroy
		redirect_to sponsors_path
	end 

	private
	def sponsor_params
		params.require(:sponsor).permit(:email)
	end 

	def admin_only
		redirect_to projects_path unless sponsor_logged_in? && current_sponsor.admin?
	end 
end
