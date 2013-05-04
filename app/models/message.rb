class Message < ActiveRecord::Base
  attr_accessible :content, :parent_id
  belongs_to :messageable, polymorphic: true
  belongs_to :user

  has_ancestry #nested messages

  #validates_length_of :content, :minimum => 5
end
