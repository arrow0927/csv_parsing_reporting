class AddDateRangesUploadsTable < ActiveRecord::Migration
  def change
		create_table :date_ranges_uploads, :id=> false do |t|
			t.belongs_to :date_range
			t.belongs_to :upload
    	end
	add_index :date_ranges_uploads, :date_range_id
	add_index :date_ranges_uploads, :upload_id

  end
end
