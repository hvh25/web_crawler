class Jobapp < ActiveRecord::Base
  belongs_to :job
  belongs_to :user
  has_attached_file :resume

  validates_presence_of :other, :resume

  attr_protected
  #attr_accessible :education, :experience, :skill, :other, 
  				 # :resume, :user_attributes, :user_id 	
  accepts_nested_attributes_for :user, :allow_destroy => true
end

