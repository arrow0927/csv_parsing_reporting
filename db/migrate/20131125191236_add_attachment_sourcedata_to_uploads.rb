class AddAttachmentSourcedataToUploads < ActiveRecord::Migration
  def self.up
    change_table :uploads do |t|
      t.attachment :sourcedata
    end
  end

  def self.down
    drop_attached_file :uploads, :sourcedata
  end
end
