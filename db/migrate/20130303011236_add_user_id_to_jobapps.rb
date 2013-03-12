class AddUserIdToJobapps < ActiveRecord::Migration
  def change
    add_column :jobapps, :user_id, :integer
  end
end
