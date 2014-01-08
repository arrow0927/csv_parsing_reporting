class AddIndexToDateRange < ActiveRecord::Migration
  def change
	add_index :date_ranges, :date_range
	add_index :date_ranges, :upload_id
  end
end
