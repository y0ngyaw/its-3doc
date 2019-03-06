module ApplicationHelper
	def after_event_view 
		ENV["AFTER_EVENT"] == "true"
	end 
end
