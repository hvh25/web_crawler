class UsersController < ApplicationController
	def update
    	@user = User.find(params[:id])
    	@user.update_attributes(params[:user])
    end
end