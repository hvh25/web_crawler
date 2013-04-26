class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.string :author
      t.string :posttype

      t.timestamps
    end
  end

  def down
    drop_table :posts
  end

end
