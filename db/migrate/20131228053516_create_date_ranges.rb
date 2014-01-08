class CreateDateRanges < ActiveRecord::Migration
  def change
    create_table :date_ranges do |t|
      t.string :date_range
      t.text :description
      t.integer :upload_id

      t.timestamps
    end
  end
end
