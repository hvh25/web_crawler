class RemoveColumns < ActiveRecord::Migration
  def up
  	remove_column :jobs, :sourcetype, :string
    remove_column :jobs, :jobrowcss, :string
    remove_column :jobs, :companycss, :string
    remove_column :jobs, :locationcss, :string
    remove_column :jobs, :descriptioncss, :string
    remove_column :jobs, :requirementcss, :string
    remove_column :jobs, :availabilitycss, :string
    remove_column :jobs, :jobtypecss, :string
  end

  def down
  	add_column :jobs, :sourcetype, :string
    add_column :jobs, :jobrowcss, :string
    add_column :jobs, :companycss, :string
    add_column :jobs, :locationcss, :string
    add_column :jobs, :descriptioncss, :string
    add_column :jobs, :requirementcss, :string
    add_column :jobs, :availabilitycss, :string
    add_column :jobs, :jobtypecss, :string
  end
end
