class SponsorVotesController < ApplicationController
	include VotesHelper

	before_action :after_event, only: [:new, :create]
	before_action :voting_session_only, only: [:new, :create]
	before_action :sponsor_only, only: [:new, :create]
	before_action :logged_in_participant, only: [:new, :create]

	def new
		@proposals_top5 = Proposal.where(top5: true).order(:title)

		respond_to do |format|
			format.js
			format.html
		end 
	end 

	def create 
		if SponsorVote.exists?(sponsor_id: current_participant.id)
			sponsor_vote = SponsorVote.find_by(sponsor_id: current_participant.id)
			sponsor_vote.update_attribute(:first_place, params[:proposal][0])
			sponsor_vote.update_attribute(:second_place, params[:proposal][1])
			sponsor_vote.update_attribute(:third_place, params[:proposal][2])
			sponsor_vote.update_attribute(:fourth_place, params[:proposal][3])
			sponsor_vote.update_attribute(:fifth_place, params[:proposal][4])
		else 
			sponsor_vote = current_participant.create_sponsor_vote(first_place: params[:proposal][0], second_place: params[:proposal][1], third_place: params[:proposal][2], fourth_place: params[:proposal][3], fifth_place: params[:proposal][4])
		end 
	end 

	private 
	def sponsor_only
		redirect_to votes_path unless current_participant.sponsor
	end

	def voting_session_only 
		redirect_to proposals_path unless voting_session?
	end  
end
