require 'will_paginate'
require 'rubygems'
require 'nokogiri' 
require 'open-uri'
require "friendly_id"

class Job < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged
  is_impressionable #view counts

  has_attached_file :photo, :styles => { :small => "450x450>" }
  validates_attachment_size :photo, :less_than => 500.kilobytes
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']

  def should_generate_new_friendly_id?
    new_record?
  end

  validates_presence_of :company, :description, :title, :comptype,
                        :location, :requirement, :jobtype
	has_many :jobapps
  has_many :messages, as: :messageable
	belongs_to :base_url
  belongs_to :user
  
  attr_protected
  #attr_accessible :availability, :company, :description, :title, :comptype,
                #  :url, :location, :requirement, :jobtype, :base_url_id, :id
  accepts_nested_attributes_for :user, :allow_destroy => true

  

  searchable do
  	text :description, :company, :requirement
  	#text :jobtype
  	text :title, :stored => true
  	string :jobtype
    string :location
    string :comptype
    date :availability
    #without(:jobtype, 'High Level')
  end

  

end


			

