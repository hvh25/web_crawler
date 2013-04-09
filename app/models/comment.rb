class Comment < ActiveRecord::Base
  attr_accessible :content
  belongs_to :commentable, polymorphic: true
  belongs_to :user

  validates_length_of :content, :minimum => 5
end
