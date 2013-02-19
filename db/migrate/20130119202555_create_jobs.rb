class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :url
      t.string :description
      t.string :company
      t.date :availability
      t.string :title

      t.timestamps
    end
  end
end
