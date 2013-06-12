task :job_weekly => :environment do
	Search.all.each do |search|
		@jib = Sunspot.search(Job) do
			sea = search
        	fulltext sea.keywords end
  			@jobs = @jib.results
  			
		@user = search.user
		@email = @user.email
		#@name = @user.first_name
		@keywords = search.keywords
		UserMailer.job_weekly(@email,@jobs,@user,@keywords).deliver! 
	end
end