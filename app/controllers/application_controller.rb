class ApplicationController < ActionController::Base
  helper :all
  protect_from_forgery

  def after_sign_out_path_for(resource_or_scope)
    request.referrer
  end

  #def after_sign_in_path_for(resource)
  #  redirect_to root_url
  #end

  protected

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied. You need to be an user or admin to access the previous page."
   # if request.env["HTTP_REFERER"] == nil
    #	redirect_to root_url
    #else
   # 	redirect_to :back
    #end
    redirect_to new_user_session_path
  end
end
