desc "update job"
task :update_jobs => :environment do
	require 'nokogiri'
	require 'open-uri'

	old_list = []  #a list of already existing jobs to compare
	new_list = []  #a list of all current links
	Job.all.each{|job| old_list << job.url} 
	puts old_list
end