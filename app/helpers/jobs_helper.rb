module JobsHelper

  manager_words = ['manager', 'president','senior','executive']

  def self.fix_url(url)
    replacements = [ [" ", "%20"], ["|", "%7C"] ]
    replacements.each {|replacement| url.gsub!(replacement[0], replacement[1])}
    return url
end

  def self.extract_location(location)  #extract location from website
    if ['hanoi', 'ha noi','hn','ha-noi'].any?{|w| location.downcase[w]} 
      return 'Hanoi'
    elsif ['sai-gon','ho-chi-minh','hcm','saigon', 'sai gon', 'ho chi minh','hochiminh'].any?{|w| location.downcase[w]} 
      return 'HCMC'
    else
      return 'Other'
    end 
  end

  def self.extract_type(type)  #extract job type from website
    if ['thuc tap','thuc-tap','thuctap','intern-','internship','parttime', 'part-time','part time','interns', 'intern '].any?{|w| type.downcase[w]}
      return 'Internship' 
    else
      return 'Entry Level'
    end
  end

  def remove_manager
          page = job_url.open_by_nokogiri   #this will return page = Nokogiri::HTML(open(page_url))
          managerg_words = ['manager', 'president','senior','executive']
          if manager_words.any?{|w| page.css('title').text.downcase[w]} == false then #remove job if it includes managerial words
              return page
          end
  end
  
  def self.job_update
    Job.all.each do |job|
      if job.availability == nil || job.availability == ''
        job.availability = (Date.today + 100.days)
        job.save 
      end
    end
  end  

    
  def self.test_get_links
    old_list = []  #a list of already existing jobs to compare
    new_list = []  #a list of all current links
    Job.all.each do |job| old_list << job.url if job.user.nil? end #exclude jobs from users

    BaseUrl.all.shuffle.each do |base_url| #if base_url.page_url == 'http://www.ngocentre.org.vn/jobs?page=0'
     puts base_url.page_url

    if base_url.sourcetype == 'job_by_row' #open source --> extract jobs
      page = Nokogiri::HTML(open(base_url.page_url))
      page.css(base_url.jobrowcss).each do |jobrow|
      new_link = jobrow.css("a").select{|link| link['href'].to_s.include? (base_url.common_url)}
      new_link = base_url.base+new_link[0]['href']
      
        if not new_list.include?(new_link) #avoid repeatation
        new_list << new_link    #for comparison purpose later       
        if not old_list.include?(new_link)  #index only new jobs
          
          puts new_link
          manager_words = ['manager', 'president','senior','executive','giam-doc','giamdoc']
          if manager_words.any?{|w| new_link.downcase[w]} == false #remove manager jobs
          begin
            if subpage = Nokogiri::HTML(open(new_link))

              puts jobrow.css(base_url.titlecss).text

                  job = Job.create(:url => new_link, :title => jobrow.css(base_url.titlecss).text,
                       :company => (base_url.companycss == ''? 
                          base_url.company0 : (jobrow.css(base_url.companycss).text == ''? subpage.css(base_url.companycss).text : jobrow.css(base_url.companycss).text)),
                       :comptype => base_url.comptype, :base_url_id => base_url.id,
                       :location => base_url.locationcss == ''? base_url.location0 : extract_location(subpage.css(base_url.locationcss).text+new_link),
                       :description => subpage.css(base_url.descriptioncss).text,
                       :requirement => base_url.requirementcss == ''? base_url.requirement0 : subpage.css(base_url.requirementcss).text,
                       :availability => (base_url.availabilitycss == '' || subpage.css(base_url.availabilitycss).text == '' || subpage.css(base_url.availabilitycss).text == nil)? 
                                        (Date.today + 100.days) : subpage.css(base_url.availabilitycss).text,
                       :jobtype => base_url.jobtypecss == ''? base_url.jobtype0 : extract_type(subpage.css(base_url.jobtypecss).text+new_link) )
                  #    base_url.jobs << job
            end #of if subpage

            

            rescue Exception => e
              case e.message
              when /404/ then puts '404!'
              when /500/ then puts '500!'
            else puts 'IDK!'
            end #of rescue
          end #of begin 
          end #of if manager_words
        end #of if not old_list.include?(job_url)
      end # of if not new_list.include?(job_url)
      end #of each do jobrow 



    else 
  		page = Nokogiri::HTML(open(base_url.page_url))
  		new_links = page.css("a").select{|link| link['href'].to_s.include? base_url.common_url }
  		new_links.uniq.each do |new_link|
  			new_link = base_url.base + fix_url(new_link['href'])
    
        if not new_list.include?(new_link) #avoid repeatation
        new_list << new_link    #for comparison purpose later       
        if not old_list.include?(new_link)  #index only new jobs
          puts new_link

          manager_words = ['manager', 'president','senior','executive','giam-doc','giamdoc']
          if manager_words.any?{|w| new_link.downcase[w]} == false #remove manager jobs
          begin
      			if subpage = Nokogiri::HTML(open(new_link))
        			    job = Job.create(:url => new_link, :title => subpage.css(base_url.titlecss).text,
                        :company => base_url.companycss == ''? base_url.company0 : subpage.css(base_url.companycss).text,
                        :comptype => base_url.comptype, :base_url_id => base_url.id,
                        :location => base_url.locationcss == ''? base_url.location0 : extract_location(subpage.css(base_url.locationcss).text+new_link),
                        :description => subpage.css(base_url.descriptioncss).text,
                        :requirement => base_url.requirementcss == ''? base_url.requirement0 : subpage.css(base_url.requirementcss).text,
                        :availability => base_url.availabilitycss == ''? Date.today + 120.days : subpage.css(base_url.availabilitycss).text,#.scan(/(\d+)(\/)(\d+)(\/)(\d+)/).join(''),
                        #:deadline => base_url.availabilitycss == ''? base_url.avail0 : subpage.css(base_url.availabilitycss).text,
                        :jobtype => base_url.jobtypecss == ''? base_url.jobtype0 : extract_type(subpage.css(base_url.jobtypecss).text+new_link) )  
                     #   base_url.jobs << job
            end #of if subpage

            rescue Exception => e
              case e.message
              when /404/ then puts '404!'
              when /500/ then puts '500!'
            else puts 'IDK!'
            end #of rescue

          end #of begin
          end #of if manager_words 
        end #of if not old_list.include?(job_url)
        end #of if not new_list.include?(job_url)
      end #of new_links.each do |new_link|
    #end # if page_url ==
    end #of if sourcetype == 
  	end #of BaseUrl.all.each do |base_url|
    puts old_list - new_list
    (old_list - new_list).each do |old_url|
      Job.all.each do |job| 
        job.destroy if (job.user.nil? && job.url == old_url)
      end
    end 
      


  end #of function
end #of MODULE
