class AddBaseUrlIdToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :base_url_id, :integer
  end
end
