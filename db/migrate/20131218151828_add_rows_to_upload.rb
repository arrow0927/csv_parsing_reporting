class AddRowsToUpload < ActiveRecord::Migration
  def change
    add_column :uploads, :total_rows, :integer
	add_column :uploads, :rows_completed, :integer
  end
end
