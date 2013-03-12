class AddExtraToUser < ActiveRecord::Migration
  def change
    add_column :users, :education, :text
    add_column :users, :experience, :text
    add_column :users, :skill, :text
    add_column :users, :resume, :string
  end
end
