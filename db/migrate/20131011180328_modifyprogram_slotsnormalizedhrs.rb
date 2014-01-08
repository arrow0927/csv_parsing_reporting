class ModifyprogramSlotsnormalizedhrs < ActiveRecord::Migration
  def change
	add_column :program_slots, :normalized_end_time, :string
	rename_column :program_slots, :normalized_hr, :normalized_start_time
  end
end
