class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :content
      t.integer :messageable_id
      t.string :messageable_type
      t.integer :user_id

      t.timestamps
    end
    add_index :messages, [:messageable_id, :messageable_type]
  end
end
