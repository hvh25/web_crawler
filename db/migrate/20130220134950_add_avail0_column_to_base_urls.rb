class AddAvail0ColumnToBaseUrls < ActiveRecord::Migration
  def change
    add_column :base_urls, :avail0, :integer
  end
end
