class AddSkillAndOtherToJobapp < ActiveRecord::Migration
  def change
    add_column :jobapps, :skill, :text
    add_column :jobapps, :other, :text
  end
end
