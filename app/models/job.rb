require 'will_paginate'
require 'rubygems'
require 'nokogiri' 
require 'open-uri'

COMMON_WORDS = ['a','able','about','above','abroad','according','accordingly','across','actually','adj','after','afterwards','again','against','ago','ahead','aint','all','allow','allows','almost','alone','along','alongside','already','also','although','always','am','amid','amidst','among','amongst','an','and','another','any','anybody','anyhow','anyone','anything','anyway','anyways','anywhere','apart','appear','appreciate','appropriate','are','arent','around','as','as','aside','ask','asking','associated','at','available','away','awfully','b','back','backward','backwards','be','became','because','become','becomes','becoming','been','before','beforehand','begin','behind','being','believe','below','beside','besides','best','better','between','beyond','both','brief','but','by','c','came','can','cannot','cant','cant','caption','cause','causes','certain','certainly','changes','clearly','cmon','co','co.','com','come','comes','concerning','consequently','consider','considering','contain','containing','contains','corresponding','could','couldnt','course','cs','currently','d','dare','darent','definitely','described','despite','did','didnt','different','directly','do','does','doesnt','doing','done','dont','down','downwards','during','e','each','edu','eg','eight','eighty','either','else','elsewhere','end','ending','enough','entirely','especially','et','etc','even','ever','evermore','every','everybody','everyone','everything','everywhere','ex','exactly','example','except','f','fairly','far','farther','few','fewer','fifth','first','five','followed','following','follows','for','forever','former','formerly','forth','forward','found','four','from','further','furthermore','g','get','gets','getting','given','gives','go','goes','going','gone','got','gotten','greetings','h','had','hadnt','half','happens','hardly','has','hasnt','have','havent','having','he','hed','hell','hello','help','hence','her','here','hereafter','hereby','herein','heres','hereupon','hers','herself','hes','hi','him','himself','his','hither','hopefully','how','howbeit','however','hundred','i','id','ie','if','ignored','ill','im','immediate','in','inasmuch','inc','inc.','indeed','indicate','indicated','indicates','inner','inside','insofar','instead','into','inward','is','isnt','it','itd','itll','its','its','itself','ive','j','just','k','keep','keeps','kept','know','known','knows','l','last','lately','later','latter','latterly','least','less','lest','let','lets','like','liked','likely','likewise','little','look','looking','looks','low','lower','ltd','m','made','mainly','make','makes','many','may','maybe','maynt','me','mean','meantime','meanwhile','merely','might','mightnt','mine','minus','miss','more','moreover','most','mostly','mr','mrs','much','must','mustnt','my','myself','n','name','namely','nd','near','nearly','necessary','need','neednt','needs','neither','never','neverf','neverless','nevertheless','new','next','nine','ninety','no','nobody','non','none','nonetheless','noone','no-one','nor','normally','not','nothing','notwithstanding','novel','now','nowhere','o','obviously','of','off','often','oh','ok','okay','old','on','once','one','ones','ones','only','onto','opposite','or','other','others','otherwise','ought','oughtnt','our','ours','ourselves','out','outside','over','overall','own','p','particular','particularly','past','per','perhaps','placed','please','plus','possible','presumably','probably','provided','provides','q','que','quite','qv','r','rather','rd','re','really','reasonably','recent','recently','regarding','regardless','regards','relatively','respectively','right','round','s','said','same','saw','say','saying','says','second','secondly','see','seeing','seem','seemed','seeming','seems','seen','self','selves','sensible','sent','serious','seriously','seven','several','shall','shant','she','shed','shell','shes','should','shouldnt','since','six','so','some','somebody','someday','somehow','someone','something','sometime','sometimes','somewhat','somewhere','soon','sorry','specified','specify','specifying','still','sub','such','sup','sure','t','take','taken','taking','tell','tends','th','than','thank','thanks','thanx','that','thatll','thats','thats','thatve','the','their','theirs','them','themselves','then','thence','there','thereafter','thereby','thered','therefore','therein','therell','therere','theres','theres','thereupon','thereve','these','they','theyd','theyll','theyre','theyve','thing','things','think','third','thirty','this','thorough','thoroughly','those','though','three','through','throughout','thru','thus','till','to','together','too','took','toward','towards','tried','tries','truly','try','trying','ts','twice','two','u','un','under','underneath','undoing','unfortunately','unless','unlike','unlikely','until','unto','up','upon','upwards','us','use','used','useful','uses','using','usually','v','value','various','versus','very','via','viz','vs','w','want','wants','was','wasnt','way','we','wed','welcome','well','well','went','were','were','werent','weve','what','whatever','whatll','whats','whatve','when','whence','whenever','where','whereafter','whereas','whereby','wherein','wheres','whereupon','wherever','whether','which','whichever','while','whilst','whither','who','whod','whoever','whole','wholl','whom','whomever','whos','whose','why','will','willing','wish','with','within','without','wonder','wont','would','wouldnt','x','y','yes','yet','you','youd','youll','your','youre','yours','yourself','yourselves','youve','z','zero']
manager_words = ['manager', 'president','senior']
old_list = []  #a list of already existing jobs to compare
new_list = []

class Job < ActiveRecord::Base
	belongs_to :word
	belongs_to :base_url
  
  attr_accessible :availability, :company, :description, :title, :url, :location, :requirement, :jobtype

  searchable do
  	text :description
  	#text :jobtype
  	text :title, :stored => true
  	string :jobtype
  end

  def open_by_nokogiri  #open html file by Nokogiri gem
	  page = Nokogiri::HTML(open(page_url))
	  return page
  end

  def extract_location(location)  #extract location from website
    if ['hanoi', 'ha noi'].any?{|w| location.downcase[w]} 
      return 'Hanoi'
    elsif ['tp.hcm','tphcm','tp hcm','hcm', 'hcmc', 'saigon', 'sai gon', 'ho chi minh', 'ho chi minh city', 'hochiminh', 'hochiminh city'].any?{|w| location.downcase[w]} 
      return 'HCMC'
    else
      return 'Other'
    end 
  end

  def extract_type(type)  #extract job type from website
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
  
  def create_job  #variable with 0 is fixed when input, others are css feed
      job = Job.create(:url => job_url, :title => page.css(titlecss).text,
            :company => companycss0 = ''? jobrow.css(companycss).text : companycss0,
            :location => locationcss0 = ''? extract_location(jobrow.css(locationcss).text) : locationcss0,
            :description => descriptioncss0 = ''? page.css(descriptioncss).text : descriptioncss0,
            :requirement => requirementcss0 = ''? page.css(requirementcss).text : requirementcss0,
            #:availability => page.css(availabilitycss).text,
            :jobtype => jobtypecss0 = ''? extract_type(page.css(jobtypecss).text) : jobtypecss0 )
  end

  #def self.get_all_links(id)
  #	find(id).get_all_links

  def self.get_all_links #MAIN ACTION, get links and create jobs
      old_list = []  #a list of already existing jobs to compare
      new_list = []  #a list of all current links
      Job.all.each{|job| old_list << job.url}

      BaseUrl.all.each {|base_url| page = page_url.open_by_nokogiri

      if sourcetype = 'job_by_row'   #for job list that has clear row for each jobs
                  #open job lists
                  page.css(jobrowcss).each do |jobrow|    #filter and create info for each job 
                  job_url = jobrow.css("a").select{|link| link['href'].to_s.include? common_url}
                  job_url = base+job_url[0]['href']
                  
                  new_list << job_url    #for comparison purpose later
                   if not old_list.include?(job_url)   #index only new jobs
          
                   remove_managerial_jobs    #the product is job_page = (base+job_url['href']).open
                   create_job
                   end 
                  end  
      else        #for job list that does NOT have clear row for each jobs
          new_links = page.css("a").select{|link| link['href'].to_s.include? common_url }  #get all links straight from source
          new_links.uniq.each{|job_url| job_url = base+job_url['href']

                  new_list << job_url    #for comparison purpose later
                  if not old_list.include?(job_url)  #index only new jobs

                    remove_managerial_jobs   #the product is page = job_url.open_by_nokogiri
                    jobrow = page    #in order to create jobs, fix to fit with company & location
                    create_job 
                  end}
      end }
      puts 9053439034093493993 + new_list.length
  end

end


			

