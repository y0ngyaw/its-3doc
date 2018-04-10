class ProjectsController < ApplicationController
	layout "sponsor_page_layout"
	include SponsorSessionsHelper
	before_action :logged_in_sponsor, only: [:new, :create, :index]
	before_action :admin_only, only: [:new, :create, :edit, :update, :destroy]

	def new
		@project = Project.new

		respond_to do |format|
			format.html
			format.js
		end 
	end 

	def create
		@project = Project.new(project_params)
		if @project.save
			redirect_to projects_path
		else 
			redirect_to projects_path
		end 
	end 

	def index
		@projects = Project.all 
	end 

	def edit
		@project = Project.find(params[:id])
	end 

	def update
		@project = Project.find(params[:id])
		if @project.update_attributes(project_params)
			redirect_to projects_path
		else 
			redirect_to projects_path
		end 
	end 

	def destroy
		@project = Project.find(params[:id])
		@project.destroy
		redirect_to projects_path
	end 

	private
	def project_params
		params.require(:project).permit(:title, :description, :tech, :theme, :documentation)
	end 

	def logged_in_sponsor
		redirect_to sponsor_login_path unless sponsor_logged_in?
	end 

	def admin_only
		redirect_to projects_path unless current_sponsor.admin?
	end
end
