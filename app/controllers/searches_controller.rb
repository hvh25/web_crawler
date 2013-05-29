class SearchesController < ApplicationController
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
end
