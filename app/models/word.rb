class Word < ActiveRecord::Base
  has_many :jobs
  attr_accessible :content

  def self.search(search)
  	if search
  		find(:all, :conditions => ['content LIKE ?', "%#{search}%"])
  	else
  		find(:all)
  	end
  end
end


