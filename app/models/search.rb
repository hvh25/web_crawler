class Search < ActiveRecord::Base
	belongs_to :user
	validates_each :user do |search, attr, value|
    	search.errors.add attr, "too much searches for user" if search.user.searches.size >= 7
    end

  	attr_accessible :keywords

	def jobs
	  @jobs ||= find_jobs
	end

	private

	def find_jobs
      	@jobs
	end

end
