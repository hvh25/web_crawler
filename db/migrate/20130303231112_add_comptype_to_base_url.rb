class AddComptypeToBaseUrl < ActiveRecord::Migration
  def change
    add_column :base_urls, :comptype, :string
  end
end
