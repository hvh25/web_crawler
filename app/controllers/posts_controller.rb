class PostsController < InheritedResources::Base

	def index
   # @jobs = Job.all

   @search = Sunspot.search(Post) do
      paginate(:per_page => 20, :page => params[:page])
      facet(:posttype)
    end
    @posts = @search.results
 
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @jobs }
    end
  end

end
