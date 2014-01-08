class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

	def refresh_badges
			@badge_values = Hash.new
			@badge_values[:uploads_count] = Upload.where.not(:status => [ 2, -1, 0]).count
			@badge_values[:channel_count] = Channel.all.count
			@badge_values[:program_count] = Program.all.count
			@badge_values[:demo_count] = Demo.all.count
			@badge_values[:program_slot_count] = ProgramSlot.all.count
			@badge_values
			respond_to do |format|
				format.js {render "layouts/refresh_badges"}
			end
	end


end
