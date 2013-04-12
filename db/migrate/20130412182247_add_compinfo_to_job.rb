class AddCompinfoToJob < ActiveRecord::Migration
  def change
    add_column :jobs, :compinfo, :text
  end
end
