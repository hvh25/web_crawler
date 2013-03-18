class ChangeDescriptionFormatInJob < ActiveRecord::Migration
  def change
    change_column :jobs, :description, :text, :limit => nil
  end
end
