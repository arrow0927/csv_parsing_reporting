class AddDateHashToDateRange < ActiveRecord::Migration
  def change
    add_column :date_ranges, :date_hash, :text
  end
end
