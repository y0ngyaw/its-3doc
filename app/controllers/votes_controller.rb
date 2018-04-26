class VotesController < ApplicationController
	layout "voting_page_layout"
	include VotesHelper
	include SponsorVotesHelper
	before_action :logged_in_participant, only: [:new, :create, :index, :results, :general_results, :votes_redirect, :get_general_result, :get_sponsor_result]
	before_action :voting_session_only, only: [:new, :create, :index, :results, :general_results, :get_general_result, :get_sponsor_result]
	before_action :after_event, only: [:new, :create]
	before_action :admin_only, only: [:results, :general_results, :get_general_result, :get_sponsor_result]

	def new
	end 

	def create
		if eligible_to_vote? params[:id]
			@vote = current_participant.votes.create(proposal_id: params[:id])
			redirect_to votes_path
		else 
			redirect_to votes_path
		end 
	end 

	def index
		@proposals = Proposal.all.order(:id) 
	end 

	def results
		if Proposal.where(top5: true).first.sp_marks == 0
			calc_sponsor_vote
		end 
	end 

	def general_results
		render json: Vote.group(:proposal_id).count.map{ |id, counter| 
			title = Proposal.find(id).title
			[title, counter]}
	end 

	def votes_redirect
	end 

	def get_general_result
		respond_to do |format| 
			format.js
			format.html
		end 
	end 

	def get_sponsor_result
		@sponsor_vote_results = Proposal.where(top5: true).order(sp_marks: :desc)

		respond_to do |format|
			format.js
			format.html
		end 
	end 

	private 
	def admin_only
		redirect_to votes_path unless current_participant.admin
	end 

	def voting_session_only 
		redirect_to votes_redirect_votes_path unless voting_session?
	end  
end
