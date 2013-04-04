class CommentsController < ApplicationController
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
  	if @comment.save
  		redirect_to @commentable, notice: "Comment created."
  	else
  		render :new
  	end
  end
end
