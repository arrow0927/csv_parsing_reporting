class CreateDateRangeUploadAssociation < ActiveRecord::Migration
  def change
	create_table :uploads_date_ranges do |t|
    	t.belongs_to :upload
		t.belongs_to :date_range
	end
  end
end
