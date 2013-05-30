class SearchController < ApplicationController
  def search
  # only search if keyword has been entered
   # if params[:query].nil? || params[:query].empty?
   #   @result = [1]
   # else
      @search = Sunspot.search(Job) do
        keywords params[:query]
        paginate(:per_page => 15, :page => params[:page])
        facet(:jobtype, :location, :comptype) 
        with(:jobtype, params[:jobtype]) if params[:jobtype].present?
        with(:location, params[:location]) if params[:location].present?
        with(:comptype, params[:comptype]) if params[:comptype].present?
        with(:availability).greater_than(Date.today)
      end
      @result = @search.results
      #@new = Job.order("created_at").last(100).sample(5)
      jobatjib = Job.all.select {|job| job.user != nil && job.availability >= Date.today}
      jobcrawl = Job.all.select {|job| job.user == nil && job.availability >= Date.today}
      @new = jobatjib.sample(3) + jobcrawl.last(200).sample(2)
#	end
 
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @jobs }
    end
  end
end
