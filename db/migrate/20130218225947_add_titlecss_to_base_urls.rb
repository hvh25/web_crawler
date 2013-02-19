class AddTitlecssToBaseUrls < ActiveRecord::Migration
  def change
    add_column :base_urls, :titlecss, :string
    add_column :base_urls, :company0, :string
    add_column :base_urls, :location0, :string
    add_column :base_urls, :description0, :string
    add_column :base_urls, :requirement0, :string
    add_column :base_urls, :jobtype0, :string
  end
end
