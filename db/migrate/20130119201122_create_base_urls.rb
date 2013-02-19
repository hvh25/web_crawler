class CreateBaseUrls < ActiveRecord::Migration
  def change
    create_table :base_urls do |t|
      t.string :page_url
      t.string :common_url
      t.string :base

      t.timestamps
    end
  end
end
