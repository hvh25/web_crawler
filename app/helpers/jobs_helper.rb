module JobsHelper
def open_by_nokogiri page_url #open html file by Nokogiri gem
	  page = Nokogiri::HTML(open(page_url))
	  return page
  end

  def self.extract_location(location)  #extract location from website
    if ['hanoi', 'ha noi'].any?{|w| location.downcase[w]} 
      return 'Hanoi'
    elsif ['tp.hcm','tphcm','tp hcm','hcm', 'hcmc', 'saigon', 'sai gon', 'ho chi minh', 'ho chi minh city', 'hochiminh', 'hochiminh city'].any?{|w| location.downcase[w]} 
      return 'HCMC'
    else
      return 'Other'
    end 
  end

  def self.extract_type(type)  #extract job type from website
    if ['internship','parttime', 'part-time','part time','intern'].any?{|w| type.downcase[w]}
      return 'Internship/Part-time' 
    else
      return 'Junior Position'
    end
  end

  def remove_managerial_jobs
          page = job_url.open_by_nokogiri   #this will return page = Nokogiri::HTML(open(page_url))
          manager_words = ['manager', 'president','senior','executive']
          if manager_words.any?{|w| page.css('title').text.downcase[w]} == false then #remove job if it includes managerial words
              return page
          end
  end
  
  def create_job base_url, jobrow, page  #variable with 0 is fixed when input, others are css feed
      job = Job.create(:url => job_url, :title => page.css(base_url.titlecss).text,
            :company => base_url.company0 = ''? jobrow.css(base_url.companycss).text : company0,
            :location => base_url.location0 = ''? extract_location(jobrow.css(locationcss).text) : base_url.location0,
            :description => base_url.description0 = ''? page.css(base_url.descriptioncss).text : base_url.description0,
            :requirement => base_url.requirement0 = ''? page.css(base_url.requirementcss).text : base_url.requirement0,
            #:availability => page.css(availabilitycss).text,
            :jobtype => base_url.jobtype0 = ''? extract_type(page.css(jobtypecss).text) : base_url.jobtype0 )
  end

  #def self.get_all_links(id)
  #	find(id).get_all_links

  def self.get_all_links #MAIN ACTION, get links and create jobs
     # old_list = []  #a list of already existing jobs to compare
   #   new_list = []  #a list of all current links
     # Job.all.each{|job| old_list << job.url}

      BaseUrl.all.each {|base_url| page = Nokogiri::HTML(open(base_url.page_url)) 

     # if sourcetype = 'job_by_row'   #for job list that has clear row for each jobs
      #            #open job lists
      #            page.css(jobrowcss).each do |jobrow|    #filter and create info for each job 
       #           job_url = jobrow.css("a").select{|link| link['href'].to_s.include? common_url}
        #          job_url = base+job_url[0]['href']
                  
         #         new_list << job_url    #for comparison purpose later
          #         if not old_list.include?(job_url)   #index only new jobs
          
           #        remove_managerial_jobs    #the product is job_page = (base+job_url['href']).open

		    #        job = Job.create(:url => job_url, :title => page.css(base_url.titlecss).text,
		     #       :company => base_url.company0 = ''? jobrow.css(base_url.companycss).text : company0,
		      #      :location => base_url.location0 = ''? extract_location(jobrow.css(locationcss).text) : base_url.location0,
		       #     :description => base_url.description0 = ''? page.css(base_url.descriptioncss).text : base_url.description0,
		        #    :requirement => base_url.requirement0 = ''? page.css(base_url.requirementcss).text : base_url.requirement0,
		            #:availability => page.css(availabilitycss).text,
		         #   :jobtype => base_url.jobtype0 = ''? extract_type(page.css(jobtypecss).text) : base_url.jobtype0 )
                  # end 
                  #end  
     # else        #for job list that does NOT have clear row for each jobs
          new_links = page.css("a").select{|link| link['href'].to_s.include? base_url.common_url }  #get all links straight from source
          new_links.uniq.each{|job_url| job_url = base_url.base+job_url['href']
          	subpage = Nokogiri::HTML(open(job_url))

                #  new_list << job_url    #for comparison purpose later
                 #if not old_list.include?(job_url)  #index only new jobs

                    #remove_managerial_jobs   #the product is page = job_url.open_by_nokogiri
                    jobrow = subpage    #in order to create jobs, fix to fit with company & location
			            job = Job.create(:url => job_url, :title => subpage.css(base_url.titlecss).text,
			            :company => base_url.company0 = ''? jobrow.css(base_url.companycss).text : company0,
			            :location => base_url.location0 = ''? extract_location(jobrow.css(locationcss).text) : base_url.location0,
			            :description => base_url.description0 = ''? subpage.css(base_url.descriptioncss).text : base_url.description0,
			            :requirement => base_url.requirement0 = ''? subpage.css(base_url.requirementcss).text : base_url.requirement0,
			            #:availability => page.css(availabilitycss).text,
    :jobtype => base_url.jobtype0 = ''? extract_type(subpage.css(jobtypecss).text) : base_url.jobtype0 )
			      #end
			  }
      #end 
  }
      #puts 9053439034093493993 + new_list.length
  end

  def self.test_get_links
  	BaseUrl.all.each do |base_url|
  		page = Nokogiri::HTML(open(base_url.page_url))
  		new_links = page.css("a").select{|link| link['href'].to_s.include? base_url.common_url }
  		new_links.each do |new_link|
  			new_link = base_url.base + new_link['href']
  			subpage = Nokogiri::HTML(open(new_link))
  			job = Job.create(:url => new_link, :company => base_url.company0, 
  							:requirement => base_url.requirement0,
  							:jobtype => base_url.jobtype0)
  		end
  	end

  end
end
