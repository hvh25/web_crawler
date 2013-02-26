class AddIdToAssignments < ActiveRecord::Migration
  def change
    add_column :assignments, :user_id, :string
    add_column :assignments, :role_id, :string
  end
end
