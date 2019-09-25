class HomeController < ApplicationController

  def index
  	if current_user and current_user.role.name == "Doctor"
  		redirect_to appointments_path
  	elsif current_user and current_user.role.name == "Patient" 
  		@doctors = User.doctors
  	else
  		redirect_to new_user_session_path
  	end
  end
end
