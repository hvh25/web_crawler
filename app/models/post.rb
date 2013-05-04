class Post < ActiveRecord::Base
  attr_accessible :author, :content, :title, :posttype

  searchable do
  	text :content
  	string :posttype
  	string :title
  	string :author
    date :created_at
  end

end
