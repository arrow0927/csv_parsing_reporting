class RemoveColsfromDateRanges < ActiveRecord::Migration
  def change
	remove_column :date_ranges, :date_hash 
  end
end
