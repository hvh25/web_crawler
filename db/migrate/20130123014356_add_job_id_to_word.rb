class AddJobIdToWord < ActiveRecord::Migration
  def change
    add_column :words, :job_id, :integer
  end
end
