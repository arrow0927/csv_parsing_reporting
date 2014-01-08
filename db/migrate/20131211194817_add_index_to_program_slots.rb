class AddIndexToProgramSlots < ActiveRecord::Migration
  def change
	add_index :program_slots, [:market_id, :channel_id]
  end
end
