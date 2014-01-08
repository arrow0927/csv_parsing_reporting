class DropDateRangesUploadsTable < ActiveRecord::Migration
  def change
	drop_table :date_ranges_uploads
  end
end
