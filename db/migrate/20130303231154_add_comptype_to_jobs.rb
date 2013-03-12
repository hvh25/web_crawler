class AddComptypeToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :comptype, :string
  end
end
