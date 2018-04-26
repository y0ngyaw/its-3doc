class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  private
  def logged_in_participant 
  	unless logged_in?
  		redirect_to login_path
  	end 
  end 


  def after_event
  	redirect_to votes_path
  end 

end
