class SearchesController < ApplicationController
	def index
	    @searches = Search.all

	    respond_to do |format|
	      format.html # index.html.erb
	      format.json { render json: @base_urls }
    	end
  	end

	def new
	  @search = Search.new
	  @search.user = current_user
	end

	def create
	  @search = current_user.searches.create!(params[:search])
	  @id = @search.id
	  redirect_to searches_path+'/'+@search.id.to_s, notice: 'Advanced search was successfully created. New jobs based on your search will be sent to '+current_user.email
	end

	def show
	  @search = Search.find(params[:id])
	  @jib = Sunspot.search(Job) do
	  @search = Search.find(params[:id])
	        fulltext @search.keywords end
      	@jobs = @jib.results
	end

	def deliver
		Search.all.each do |search|
				@jib = Sunspot.search(Job) do
		        	fulltext search.keywords end
	      			@jobs = @jib.results
				@user = search.user
				@email = @user.email
				@name = @user.first_name
				UserMailer.job_weekly(@email,@jobs,@user,@name).delay.deliver 
		end

      redirect_to searches_path, notice: "Successfully deliver job results."
    end
				
end
