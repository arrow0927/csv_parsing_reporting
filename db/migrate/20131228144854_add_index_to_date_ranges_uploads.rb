class AddIndexToDateRangesUploads < ActiveRecord::Migration
  def change
	add_index :date_ranges_uploads, :date_range_id
	add_index :date_ranges_uploads, :upload_id
  end
end
