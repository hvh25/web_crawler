class AddAttachmentResumeToJobapps < ActiveRecord::Migration
  def self.up
    change_table :jobapps do |t|
      t.attachment :resume
    end
  end

  def self.down
    drop_attached_file :jobapps, :resume
  end
end
