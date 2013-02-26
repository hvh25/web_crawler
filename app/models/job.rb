require 'will_paginate'
require 'rubygems'
require 'nokogiri' 
require 'open-uri'

class Job < ActiveRecord::Base
	belongs_to :word
	belongs_to :base_url
  belongs_to :user
  
  attr_accessible :availability, :company, :description, :title, 
                  :url, :location, :requirement, :jobtype, :user_id

  searchable do
  	text :description, :company
  	#text :jobtype
  	text :title, :stored => true
  	string :jobtype
    string :location
    #without(:jobtype, 'High Level')
  end

  

end


			

