require 'rubygems'
require 'nokogiri' 
require 'open-uri'

COMMON_WORDS = ['a','able','about','above','abroad','according','accordingly','across','actually','adj','after','afterwards','again','against','ago','ahead','aint','all','allow','allows','almost','alone','along','alongside','already','also','although','always','am','amid','amidst','among','amongst','an','and','another','any','anybody','anyhow','anyone','anything','anyway','anyways','anywhere','apart','appear','appreciate','appropriate','are','arent','around','as','as','aside','ask','asking','associated','at','available','away','awfully','b','back','backward','backwards','be','became','because','become','becomes','becoming','been','before','beforehand','begin','behind','being','believe','below','beside','besides','best','better','between','beyond','both','brief','but','by','c','came','can','cannot','cant','cant','caption','cause','causes','certain','certainly','changes','clearly','cmon','co','co.','com','come','comes','concerning','consequently','consider','considering','contain','containing','contains','corresponding','could','couldnt','course','cs','currently','d','dare','darent','definitely','described','despite','did','didnt','different','directly','do','does','doesnt','doing','done','dont','down','downwards','during','e','each','edu','eg','eight','eighty','either','else','elsewhere','end','ending','enough','entirely','especially','et','etc','even','ever','evermore','every','everybody','everyone','everything','everywhere','ex','exactly','example','except','f','fairly','far','farther','few','fewer','fifth','first','five','followed','following','follows','for','forever','former','formerly','forth','forward','found','four','from','further','furthermore','g','get','gets','getting','given','gives','go','goes','going','gone','got','gotten','greetings','h','had','hadnt','half','happens','hardly','has','hasnt','have','havent','having','he','hed','hell','hello','help','hence','her','here','hereafter','hereby','herein','heres','hereupon','hers','herself','hes','hi','him','himself','his','hither','hopefully','how','howbeit','however','hundred','i','id','ie','if','ignored','ill','im','immediate','in','inasmuch','inc','inc.','indeed','indicate','indicated','indicates','inner','inside','insofar','instead','into','inward','is','isnt','it','itd','itll','its','its','itself','ive','j','just','k','keep','keeps','kept','know','known','knows','l','last','lately','later','latter','latterly','least','less','lest','let','lets','like','liked','likely','likewise','little','look','looking','looks','low','lower','ltd','m','made','mainly','make','makes','many','may','maybe','maynt','me','mean','meantime','meanwhile','merely','might','mightnt','mine','minus','miss','more','moreover','most','mostly','mr','mrs','much','must','mustnt','my','myself','n','name','namely','nd','near','nearly','necessary','need','neednt','needs','neither','never','neverf','neverless','nevertheless','new','next','nine','ninety','no','nobody','non','none','nonetheless','noone','no-one','nor','normally','not','nothing','notwithstanding','novel','now','nowhere','o','obviously','of','off','often','oh','ok','okay','old','on','once','one','ones','ones','only','onto','opposite','or','other','others','otherwise','ought','oughtnt','our','ours','ourselves','out','outside','over','overall','own','p','particular','particularly','past','per','perhaps','placed','please','plus','possible','presumably','probably','provided','provides','q','que','quite','qv','r','rather','rd','re','really','reasonably','recent','recently','regarding','regardless','regards','relatively','respectively','right','round','s','said','same','saw','say','saying','says','second','secondly','see','seeing','seem','seemed','seeming','seems','seen','self','selves','sensible','sent','serious','seriously','seven','several','shall','shant','she','shed','shell','shes','should','shouldnt','since','six','so','some','somebody','someday','somehow','someone','something','sometime','sometimes','somewhat','somewhere','soon','sorry','specified','specify','specifying','still','sub','such','sup','sure','t','take','taken','taking','tell','tends','th','than','thank','thanks','thanx','that','thatll','thats','thats','thatve','the','their','theirs','them','themselves','then','thence','there','thereafter','thereby','thered','therefore','therein','therell','therere','theres','theres','thereupon','thereve','these','they','theyd','theyll','theyre','theyve','thing','things','think','third','thirty','this','thorough','thoroughly','those','though','three','through','throughout','thru','thus','till','to','together','too','took','toward','towards','tried','tries','truly','try','trying','ts','twice','two','u','un','under','underneath','undoing','unfortunately','unless','unlike','unlikely','until','unto','up','upon','upwards','us','use','used','useful','uses','using','usually','v','value','various','versus','very','via','viz','vs','w','want','wants','was','wasnt','way','we','wed','welcome','well','well','went','were','were','werent','weve','what','whatever','whatll','whats','whatve','when','whence','whenever','where','whereafter','whereas','whereby','wherein','wheres','whereupon','wherever','whether','which','whichever','while','whilst','whither','who','whod','whoever','whole','wholl','whom','whomever','whos','whose','why','will','willing','wish','with','within','without','wonder','wont','would','wouldnt','x','y','yes','yet','you','youd','youll','your','youre','yours','yourself','yourselves','youve','z','zero']
manager_words = ['manager', 'president','senior']
old_list = []  #a list of already existing jobs to compare
new_list = []

class BaseUrl < ActiveRecord::Base
  attr_accessible :base, :common_url, :page_url, :sourcetype, :titlecss,
                  :jobrowcss, :companycss, :locationcss, :descriptioncss, :requirementcss, :availabilitycss, :jobtypecss,
                  :company0, :location0, :description0, :requirement0, :jobtype0, :avail0
  
  has_many :jobs

                  
  def open_by_nokogiri  #open html file by Nokogiri gem
  page = Nokogiri::HTML(open(page_url))
  return page
  end

  def extract_location(location)  #extract location from website
    if ['hanoi', 'ha noi'].any?{|w| location.downcase[w]} 
      return 'Hanoi'
    elsif ['hcm', 'hcmc', 'saigon', 'sai gon', 'ho chi minh', 'ho chi minh city', 'hochiminh', 'hochiminh city'].any?{|w| location.downcase[w]} 
      return 'HCMC'
    else
      return 'Other'
    end 
  end

  def extract_type(type)  #extract job type from website
    if ['internship','parttime', 'part-time','part time'].any?{|w| type.downcase[w]}
      return 'Internship/Part-time' 
    else
      return 'Junior Position'
    end
  end

  def get_all_links #MAIN ACTION, get links and create jobs
      old_list = []  #a list of already existing jobs to compare
      new_list = []  #a list of all current links
      Job.all.each{|job| old_list << job.url}

      manager_words = ['manager', 'president','senior','executive']

      BaseUrl.all.each {|base_url| page = page_url.open_by_nokogiri

      if source_type = 'job_by_row'   #for job list that has clear row for each jobs
                  #open job lists
                  page.css(jobrowcss).each do |jobrow|    #filter and create info for each job 
                  job_url = jobrow.css("a").select{|link| link['href'].to_s.include? common_url}
                  job_url = job_url[0]
          
                  remove_managerial_jobs_to_add_new_links    #the product is job_page = (base+job_url['href']).open
                  create_job
                  end   
      else        #for job list that does NOT have clear row for each jobs
          new_links = page.css("a").select{|link| link['href'].to_s.include? common_url }  #get all links straight from source
          new_links.uniq.each{|job_url|  

              remove_managerial_jobs_to_add_new_links   #the product is job_page = (base+job_url['href']).open
              jobrow = job_page    #in order to create jobs, fix to fit with company & location
              create_job }
      end }
  end

  def remove_managerial_jobs_to_add_new_links
          if manager_words.any?{|w| each_job.css('title').text.downcase[w]} == false then #remove job if it includes managerial words
              new_list << base+job_url['href']   #add to list for comparison purpose
              return job_page = (base+job_url['href']).open #open job url to extract info
          end
  end
  
  def create_job  #variable with 0 is fixed when input, others are css feed
      job = Job.create(:url => base+job_url['href'], :title => job_page.css('title').text,
            :company => companycss0 = ''? jobrow.css(companycss).text : companycss0,
            :location => locationcss0 = ''? extract_location(jobrow.css(locationcss).text) : locationcss0,
            :description => descriptioncss0 = ''? job_page.css(descriptioncss).text : descriptioncss0,
            :requirement => requirementcss0 = ''? job_page.css(requirementcss).text : requirementcss0,
            :availability => job_page.css(availabilitycss).text,
            :jobtype => jobtypecss0 = ''? extract_type(job_page.css(jobtypecss).text) : jobtypecss0 )
  end

end

  #def get_all_links
    #manager_words = ['manager', 'president','senior','executive']
    #page = self.open_url
    #new_links = page.css("a").select{|link| link['href'].to_s.include? common_url }
    #new_links.uniq.each{|link| new_page = Nokogiri::HTML(open(base+link['href']))
                          #if manager_words.any?{|w| new_page.css('title').text.downcase[w]} == false then

      #words = new_page.css('div').text.to_s.split(' ')

      #noneed = new_page.css('div#siteSelector').text.to_s.split(' ')
      
      #array_dict = words - noneed

      #job_descript =[]   #this is the description of a job, join later as 1 string
      #array_dict.each{|x| if x.length<15 
                          #then (job_descript<<x.gsub(/[\`\~\!\@\#\$\%\^\&\*\(\)\-\=\_\+\[\]\\\;\'\,\/\{\}\|\:\"\<\>\?]/,' '))
                          #end}

      #dictionary = []
      #array.uniq.each{|x| x=x.gsub(' ','') and 
                          #(if (x.length > 1 && COMMON_WORDS.include?(x)==false) 
                          #then dictionary<<x
                          #end)}
            #ActiveRecord::Base.transaction do 
##############################################################            
            #navigossearch
            #job = Job.create(:location => new_page.css(':nth-child(16)').text, :company => 'amazon', 
            #                 :description => new_page.css(':nth-child(9) , :nth-child(5) :nth-child(5)').text, 
            #                 :title => new_page.css('title').text, :url => base+link['href'])

            #mazars
            #job = Job.create(:location => new_page.css('.article p , .liste_puce li, b').text.include?('Hanoi')? 'Hanoi' : 'HCMC', :company => 'Mazars', 
            #                 :description => new_page.css('.article p , .liste_puce li, b').text, 
            #                 :title => new_page.css('title').text, :url => base+link['href'])

            #HSBC
            #job = Job.create(:location => new_page.css('li:nth-child(5) .valueR').text.include?('HCM')? 'HCM' : 'Hanoi', 
            #                 :company => 'HSBC', :description => new_page.css('.content_fck p').text, 
            #                 :title => new_page.css('title').text, :url => base+link['href'], 
            #                 :availability => new_page.css('.content_fck p').text.scan(/(\d+)(\/)(\d+)(\/)(\d+)/).join(''))
            
            #RMIT
            # (if new_page.css('.job-attributes').text.downcase.include?('expired') == false then
            # job = Job.create(:location => new_page.css('.field-name-field-job-location .even').text.include?('Saigon')? 'HCM' : 'Hanoi', 
            #                 :company => 'RMIT Vietnam', :description => new_page.css('.field-type-text-with-summary').text, 
            #                 :title => new_page.css('title').text, :url => base+link['href'], 
            #                 :availability => new_page.css('.field-type-datetime .field-items').text.scan(/(\d+)(\/)(\d+)(\/)(\d+)/).join(''))
            #  end)
          
            #Nestle Vietnam
            # job = Job.create(:location => new_page.css('#box_xctcvcdnhap_766 :nth-child(2) .w254:nth-child(2)').text, 
            #                 :company => 'Nestle Vietnam', :description => new_page.css('.content_xctcvcdnhap_764 , label').text, 
            #                 :title => new_page.css('title').text, :url => base+link['href'], 
            #                 :availability => new_page.css('.w254').text.scan(/(\d+)(\/)(\d+)(\/)(\d+)/).join(''))

             #CocCoc
              #job = Job.create(:location => 'Hanoi', :requirement => new_page.css('tr:nth-child(4) td , tr:nth-child(3) td').text,
              #                 :company => 'Coc Coc', :description => new_page.css('tr:nth-child(2) td , .first td').text, 
              #                 :title => new_page.css('title').text, :url => base+link['href'])

             #Internship.edu.vn Hanoi
                #job = Job.create(:location => 'Hanoi',
                #               :company => new_page.css('table:nth-child(7) tr:nth-child(1) .job_text').text, :description => new_page.css('.job_description').text, 
                #               :title => new_page.css('title').text, :url => base+link['href'],
                #               :availability => new_page.css('table:nth-child(2) .job_text').text.scan(/(\d+)(\-)(\d+)(\-)(\d+)/).join(''))
      
             #Vietnamworks HCMC
                #job = Job.create(:location => 'HCMC',
                 #              :company => new_page.css('.company-name .unlink').text, 
                  #             :description => new_page.css('.content-box:nth-child(3)').text, 
                   #            :title => new_page.css('title').text, :url => base+link['href'], 
                    #           :requirement => new_page.css('.content-box:nth-child(5)').text,
                     #          :availability => new_page.css('dd').text.scan(/(\d+)(\-)(...)(\-)(\d+)/).join(''),
                      #         :jobtype => ['intern', 'internship','trainee'].any?{|w| new_page.css('.content-box , .job-title .unlink').text.downcase[w]}? 'Internship' : 'Fulltime' )

              #Techcombank
                #job = Job.create(:location => 'Hanoi',
                #               :company => 'Techcombank', 
                 #              :description => new_page.css('ol li').text, 
                  #             :title => new_page.css('title').text, :url => base+link['href'], 
                   #            :requirement => new_page.css('#box_xctcvcdnhap_766 ul li').text,
                    #           :availability => new_page.css('.w254').text.scan(/(\d+)(\-)(\d+)(\-)(\d+)/).join(''))    

                #CMC
                #job = Job.create(:location => 'Hanoi',
                 #              :company => 'CMC', 
                  #             :description => new_page.css('.txt_contents').text, 
                   #            :title => new_page.css('title').text, :url => base+link['href'], 
                    #           :availability => new_page.css('.txt_quymo2').text.scan(/(\d+)(\-)(\d+)(\-)(\d+)/).join('')) 

                #Pepsico
                #job = Job.create(:location => new_page.css('.w254').text.include?('HCM')? 'HCM' : 'Hanoi',
                 #              :company => 'Pepsico', 
                  #             :description => new_page.css('.content_xctcvcdnhap_764').text, 
                   #            :title => new_page.css('title').text, :url => base+link['href'], 
                    #           :availability => new_page.css('.w254').text.scan(/(\d+)(\-)(\d+)(\-)(\d+)/).join('')) 
                 
                #Honda Vietnam
                 # job = Job.create(:location => 'Hanoi',
                  #             :company => 'Honda Vietnam', 
                   #            :description => new_page.css('.description').text, 
                    #           :title => new_page.css('title').text, :url => base+link['href'])

                #Savills 1 job not found --> end 
                #job = Job.create(:location => new_page.css('#txt_03 p').text.include?('Hanoi')? 'Hanoi' : 'HCMC',
                 #              :company => 'Savills', 
                  #             :description => new_page.css('#col_01').text, 
                   #            :title => new_page.css('title').text, :url => base+link['href']) 

                #Jobstreet
              #job = Job.create(:location => extract_location(new_page.css('p font:nth-child(2)').text),
                 #              :company => new_page.css('.comURL a').text, 
                  #             :description => new_page.css('ul').text, 
                   #            :title => new_page.css('title').text, :url => base+link['href'],
                    #           :jobtype => extract_type(new_page.css('td').text)) 
                              
                               
#############################################################            
            #end
        
        #ActiveRecord::Base.transaction do 
         # dictionary.each{|word| w = Word.create(:content => word)}
       #end
        #1000.times do Word.content.push(dictionary)
        #columns = [:content]
        #Word.import columns, dictionary
  # end }
 # end


