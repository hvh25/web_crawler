class ApplicationController < ActionController::Base
  helper :all
  protect_from_forgery

  protected

  rescue_from CanCan::AccessDenied do |exception|
  flash[:error] = "Access denied. You need to be an user or admin to access the previous page."
  if request.env["HTTP_REFERER"] == nil
  	redirect_to root_url
  else
  	redirect_to :back
  end
end
end
