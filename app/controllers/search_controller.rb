class SearchController < ApplicationController
  def search
  # only search if keyword has been entered
    if params[:query].nil? || params[:query].empty?
      @result = [1]
    else
      @search = Job.search do
      keywords params[:query]
      paginate(:per_page => 20, :page => params[:page])
      facet(:jobtype) 
      with(:jobtype, params[:jobtype]) if params[:jobtype].present?
      end
      @result = @search.results
	end
 
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @jobs }
    end
  end
end
