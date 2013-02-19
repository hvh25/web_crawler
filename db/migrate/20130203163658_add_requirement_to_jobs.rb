class AddRequirementToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :requirement, :text
  end
end
