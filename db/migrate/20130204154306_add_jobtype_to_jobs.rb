class AddJobtypeToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :jobtype, :string
  end
end
