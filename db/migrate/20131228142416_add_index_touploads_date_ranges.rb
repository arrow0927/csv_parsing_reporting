class AddIndexTouploadsDateRanges < ActiveRecord::Migration
  def change
	add_index :uploads_date_ranges, :date_range_id
	add_index :uploads_date_ranges, :upload_id
  end
end
