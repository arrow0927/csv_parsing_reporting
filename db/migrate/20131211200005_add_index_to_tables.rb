class AddIndexToTables < ActiveRecord::Migration
  def change
	add_index :programs, [:program_name, :episode_name]
	add_index :channels, [:channel_name]
	add_index :demos, [:program_slot_id, :metric_type]
  end
end
