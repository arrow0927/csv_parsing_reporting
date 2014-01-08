class DropTableUploadsDateRanges < ActiveRecord::Migration
  def change
	drop_table :uploads_date_ranges
  end
end
