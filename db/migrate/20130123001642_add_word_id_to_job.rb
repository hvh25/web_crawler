class AddWordIdToJob < ActiveRecord::Migration
  def change
    add_column :jobs, :word_id, :integer
  end
end
