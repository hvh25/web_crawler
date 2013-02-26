class ApplicationController < ActionController::Base
  helper :all
  protect_from_forgery
  before_filter {|c| Authorization.current_user = c.current_user }

  protected

  def permission_denied
  	flash[:error] = 'You need to Sign Up or Sign In to access that page.'
  	redirect_to new_user_registration_path
  end
end
