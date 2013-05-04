class MessagesController < ApplicationController
  def index
  	@messageable = Job.find(params[:job_id])
    @owner = @messageable.user
  	@messages = @messageable.messages
    @message = @messageable.messages.new
  end

  def new
  	@messageable = Job.find(params[:job_id])
    @owner = @messageable.user
    @message = @messageable.messages.new(:parent_id => params[:parent_id])
  end

  def create
  	@messageable = Job.find(params[:job_id])
    @owner = @messageable.user
    @message = @messageable.messages.new(params[:message])
    @message.user = current_user

    respond_to do |format|
      format.html {
      	if @message.save
          redirect_to @messageable
        else
      		render :new
      	end
      }
      format.json
    end  
  end

end
