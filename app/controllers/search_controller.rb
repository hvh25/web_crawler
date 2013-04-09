class SearchController < ApplicationController
  def search
  # only search if keyword has been entered
   # if params[:query].nil? || params[:query].empty?
   #   @result = [1]
   # else
      @search = Job.search do
      keywords params[:query]
      paginate(:per_page => 15, :page => params[:page])
      facet(:jobtype, :location, :comptype) 
      with(:jobtype, params[:jobtype]) if params[:jobtype].present?
      with(:location, params[:location]) if params[:location].present?
      with(:comptype, params[:comptype]) if params[:comptype].present?
      end
      @result = @search.results
      #@new = Job.order("created_at").last(100).sample(5)
      jobatjib = Job.all.select {|job| job.user != nil}
      @new = (jobatjib.sample((jobatjib.size/3).round) + Job.order("created_at").last(200).sample(5 - (jobatjib.size/3).round)).uniq
#	end
 
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @jobs }
    end
  end
end
