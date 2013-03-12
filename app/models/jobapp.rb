class Jobapp < ActiveRecord::Base
  belongs_to :job
  belongs_to :user
  has_attached_file :resume

  validates_presence_of :education, :experience, :skill, :other, :resume

  attr_accessible :education, :experience, :skill, :other, :resume
end

