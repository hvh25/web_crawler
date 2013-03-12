class CreateJobapps < ActiveRecord::Migration
  def change
    create_table :jobapps do |t|
      t.text :education
      t.text :experience
      t.references :job

      t.timestamps
    end
    add_index :jobapps, :job_id
  end
end
