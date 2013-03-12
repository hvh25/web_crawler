class AddSourceIdToJob < ActiveRecord::Migration
  def change
    add_column :jobs, :source_id, :integer
    add_column :jobs, :source_type, :string
  end
end
