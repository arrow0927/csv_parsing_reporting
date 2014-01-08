class RemoveColFromDateRanges < ActiveRecord::Migration
  def change
	remove_column :date_ranges, :upload_id
  end
end
