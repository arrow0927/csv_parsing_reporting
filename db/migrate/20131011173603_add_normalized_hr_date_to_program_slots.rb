class AddNormalizedHrDateToProgramSlots < ActiveRecord::Migration
  def change    
    add_column :program_slots, :normalized_hr, :string
	add_column :program_slots, :normalized_date, :string
  end
end
