class CommentsController < ApplicationController::Base
  def index
  	@commentable = Job.find(params[:job_id])
    @owner = @commentable.user
  	@comments = @commentable.comments
  end

  def new
  	@commentable = Job.find(params[:job_id])
    @owner = @commentable.user
    @comment = @commentable.comments.new
  end

  def create
  	@commentable = Job.find(params[:job_id])
    @owner = @commentable.user
    @comment = @commentable.comments.new(params[:comment])
    @comment.user = current_user

    respond_to do |format|
      format.html {
      	if @comment.save
          redirect_to @commentable
        else
      		render :new
      	end
      }
      format.json
    end  
  end

end
