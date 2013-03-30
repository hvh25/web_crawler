require 'rubygems'
require 'nokogiri' 
require 'open-uri'

def self.fix_url(url)
    replacements = [ [" ", "%20"], ["|", "%7C"] ]
    replacements.each {|replacement| url.gsub!(replacement[0], replacement[1])}
    return url
end

 
subpage = Nokogiri::HTML(open('http://ub.com.vn/forums/41-TIN-NGAN-HANG-TUYEN-DUNG.html'))
 subpage.css('.nonsticky').each do |jobrow| 
 job_url = jobrow.css("a").select{|link| link['href'].to_s.include? ('threads/')}
          puts "http://ub.com.vn/forums"+job_url[0]['href']
          puts jobrow.css('.title').text
        end

